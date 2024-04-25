package ethernet

import chisel3._
import chisel3.util._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.regmapper._
import org.chipsalliance.cde.config.Parameters
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}

class TemacConfigIO() extends Bundle {
  val packetSize        = Output(UInt(16.W))
  val srcMac            = Output(UInt(48.W))
  val srcIp             = Output(UInt(32.W))
  val srcPort           = Output(UInt(16.W))
  val dstMac            = Output(UInt(48.W))
  val dstIp             = Output(UInt(32.W))
  val dstPort           = Output(UInt(16.W))
  val dstPort2          = Output(UInt(16.W))
  val dstPort1PacketNum = Output(UInt(16.W))
  val dstPort2PacketNum = Output(UInt(16.W))
}

class TemacConfig(csrAddress: AddressSet, beatBytes:  Int) extends LazyModule()(Parameters.empty) {
  lazy val io = Wire(new TemacConfigIO)

  val mem = Some(AXI4RegisterNode(address = csrAddress, beatBytes = beatBytes))

  lazy val module = new LazyModuleImp(this) {
    val packetSize        = WireDefault(UInt(16.W), 1024.U)
    val srcMacHigh        = WireDefault(UInt(24.W), 0.U)
    val srcMacLow         = WireDefault(UInt(24.W), 0.U)
    val srcIp             = WireDefault(UInt(32.W), 0.U)
    val srcPort           = WireDefault(UInt(16.W), 0.U)
    val dstMacHigh        = WireDefault(UInt(24.W), 0.U)
    val dstMacLow         = WireDefault(UInt(24.W), 0.U)
    val dstIp             = WireDefault(UInt(32.W), 0.U)
    val dstPort           = WireDefault(UInt(16.W), 0.U)
    val dstPort2          = WireDefault(UInt(16.W), 0.U)
    val dstPort1PacketNum = WireDefault(UInt(16.W), 16.U)
    val dstPort2PacketNum = WireDefault(UInt(16.W), 16.U)

    val fields: Seq[RegField] = Seq(
      RegField.w(16, packetSize,        RegFieldDesc(name = "packetSize",        desc = "Packet size")),                             // 0x20
      RegField.w(24, srcMacHigh,        RegFieldDesc(name = "srcMacHigh",        desc = "Source MAC address higher bytes")),         // 0x9C
      RegField.w(24, srcMacLow,         RegFieldDesc(name = "srcMacLow",         desc = "Source MAC address lower bytes")),          // 0xA0
      RegField.w(32, srcIp,             RegFieldDesc(name = "srcIp",             desc = "Source IP address")),                       // 0xA4
      RegField.w(16, srcPort,           RegFieldDesc(name = "srcPort",           desc = "Source port number")),                      // 0xA8
      RegField.w(24, dstMacHigh,        RegFieldDesc(name = "dstMacHigh",        desc = "Destination MAC address higher bytes")),    // 0xAC
      RegField.w(24, dstMacLow,         RegFieldDesc(name = "dstMacLow",         desc = "Destination MAC address lower bytes")),     // 0xB0
      RegField.w(32, dstIp,             RegFieldDesc(name = "dstIp",             desc = "Destination IP address")),                  // 0xB4
      RegField.w(16, dstPort,           RegFieldDesc(name = "dstPort",           desc = "Destination port number")),                 // 0xB8
      RegField.w(16, dstPort2,          RegFieldDesc(name = "dstPort2",          desc = "Destination port 2 number")),               // 0xBC
      RegField.w(16, dstPort1PacketNum, RegFieldDesc(name = "dstPort1PacketNum", desc = "Number of packets to destination port 1")), // 0xC0
      RegField.w(16, dstPort2PacketNum, RegFieldDesc(name = "dstPort2PacketNum", desc = "Number of packets to destination port 2"))  // 0xC4
    )
    mem.get.regmap(fields.zipWithIndex.map({ case (f, i) => i * beatBytes -> Seq(f) }): _*)

    io.packetSize        := packetSize
    io.srcMac            := Cat(srcMacHigh, srcMacLow)
    io.srcIp             := srcIp
    io.srcPort           := srcPort
    io.dstMac            := Cat(dstMacHigh, dstMacLow)
    io.dstIp             := dstIp
    io.dstPort           := dstPort
    io.dstPort2          := dstPort2
    io.dstPort1PacketNum := dstPort1PacketNum
    io.dstPort2PacketNum := dstPort2PacketNum
  }
}

class TemacConfigBlock(csrAddress: AddressSet, beatBytes:  Int)(implicit p: Parameters) extends TemacConfig(csrAddress, beatBytes) {
  def makeIO2(): TemacConfigIO = {
    val io2: TemacConfigIO = IO(io.cloneType)
    io2.suggestName("ioConfig")
    io2 <> io
    io2
  }
  val ioConfig = InModuleBody { makeIO2() }

  def standaloneParams = AXI4BundleParameters(addrBits = 32, dataBits = 32, idBits = 1)
  val ioMem = mem.map { m => {
      val ioMemNode = BundleBridgeSource(() => AXI4Bundle(standaloneParams))
      m := BundleBridgeToAXI4(AXI4MasterPortParameters(Seq(AXI4MasterParameters("bundleBridgeToAXI4")))) := ioMemNode
      val ioMem = InModuleBody { ioMemNode.makeIO() }
      ioMem
    }
  }
}

object TemacConfigBlockApp extends App {
  implicit val p: Parameters = Parameters.empty
  val configModule = LazyModule(new TemacConfigBlock(AddressSet(0x20000000, 0xff), 4) {
    override def standaloneParams = AXI4BundleParameters(addrBits = 32, dataBits = 32, idBits = 1)
  })
  (new ChiselStage).execute(Array("--target-dir", "verilog/TemacConfig"), Seq(ChiselGeneratorAnnotation(() => configModule.module)))
}
