package ethernet

import chisel3._
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}
import chisel3.util._
import dspblocks.DspBlock
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.diplomacy.{AddressSet, SimpleDevice}
import freechips.rocketchip.regmapper._
import freechips.rocketchip.tilelink.{BundleBridgeToTL, TLBundle, TLBundleParameters, TLClientPortParameters, TLEdgeIn, TLEdgeOut, TLManagerPortParameters, TLMasterParameters, TLMasterPortParameters, TLRegisterNode}
import org.chipsalliance.cde.config.Parameters
import org.chipsalliance.diplomacy.bundlebridge.BundleBridgeSource
import org.chipsalliance.diplomacy.lazymodule.{InModuleBody, LazyModule, LazyModuleImp}
import org.chipsalliance.diplomacy.nodes.MixedNode

class TemacConfigIO extends Bundle {
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

class TLTemacConfig(csrAddress: AddressSet, beatBytes: Int)
  extends TemacConfig[TLClientPortParameters, TLManagerPortParameters, TLEdgeOut, TLEdgeIn, TLBundle](csrAddress, beatBytes) {
  // make diplomatic TL node for regmap
  override val mem: Option[TLRegisterNode] = Some(TLRegisterNode(address = Seq(csrAddress), device = dtsdevice, beatBytes = beatBytes))
  override def regmap(mapping: (Int, Seq[RegField])*): Unit = mem.get.regmap(mapping: _*)
}

class AXI4TemacConfig(csrAddress: AddressSet, beatBytes: Int)
  extends TemacConfig[AXI4MasterPortParameters, AXI4SlavePortParameters, AXI4EdgeParameters, AXI4EdgeParameters, AXI4Bundle](csrAddress, beatBytes) {
  // make diplomatic TL node for regmap
  override val mem: Option[AXI4RegisterNode] = Some(AXI4RegisterNode(address = csrAddress, beatBytes = beatBytes))
  override def regmap(mapping: (Int, Seq[RegField])*): Unit = mem.get.regmap(mapping: _*)
}

abstract class TemacConfig[D, U, EO, EI, B <: Data](csrAddress: AddressSet, beatBytes: Int) extends LazyModule()(Parameters.empty) {
  // DTS
  val dtsdevice: SimpleDevice = new SimpleDevice("temac", Seq("gbemac"))

  // Memory Mapped Node for registers
  val mem: Option[MixedNode[D, U, EI, B, D, U, EO, B]]

  // RegMap
  def regmap(mapping: RegField.Map*): Unit

  lazy val module = new Impl
  class Impl extends LazyModuleImp(this) {
    // IO
    val io: TemacConfigIO = IO(new TemacConfigIO)
    // Registers
    val packetSize        = RegInit(UInt(16.W), 1024.U)
    val srcMacHigh        = RegInit(UInt(24.W), 0.U)
    val srcMacLow         = RegInit(UInt(24.W), 0.U)
    val srcIp             = RegInit(UInt(32.W), 0.U)
    val srcPort           = RegInit(UInt(16.W), 0.U)
    val dstMacHigh        = RegInit(UInt(24.W), 0.U)
    val dstMacLow         = RegInit(UInt(24.W), 0.U)
    val dstIp             = RegInit(UInt(32.W), 0.U)
    val dstPort           = RegInit(UInt(16.W), 0.U)
    val dstPort2          = RegInit(UInt(16.W), 0.U)
    val dstPort1PacketNum = RegInit(UInt(16.W), 16.U)
    val dstPort2PacketNum = RegInit(UInt(16.W), 16.U)

    val fields: Seq[RegField] = Seq(
      RegField.w(16, packetSize,        RegFieldDesc(name = "packetSize",        desc = "Packet size")),                             // 0x00
      RegField.w(24, srcMacHigh,        RegFieldDesc(name = "srcMacHigh",        desc = "Source MAC address higher bytes")),         // 0x04
      RegField.w(24, srcMacLow,         RegFieldDesc(name = "srcMacLow",         desc = "Source MAC address lower bytes")),          // 0x08
      RegField.w(32, srcIp,             RegFieldDesc(name = "srcIp",             desc = "Source IP address")),                       // 0x0A
      RegField.w(16, srcPort,           RegFieldDesc(name = "srcPort",           desc = "Source port number")),                      // 0x10
      RegField.w(24, dstMacHigh,        RegFieldDesc(name = "dstMacHigh",        desc = "Destination MAC address higher bytes")),    // 0x14
      RegField.w(24, dstMacLow,         RegFieldDesc(name = "dstMacLow",         desc = "Destination MAC address lower bytes")),     // 0x18
      RegField.w(32, dstIp,             RegFieldDesc(name = "dstIp",             desc = "Destination IP address")),                  // 0x1A
      RegField.w(16, dstPort,           RegFieldDesc(name = "dstPort",           desc = "Destination port number")),                 // 0x20
      RegField.w(16, dstPort2,          RegFieldDesc(name = "dstPort2",          desc = "Destination port 2 number")),               // 0x24
      RegField.w(16, dstPort1PacketNum, RegFieldDesc(name = "dstPort1PacketNum", desc = "Number of packets to destination port 1")), // 0x28
      RegField.w(16, dstPort2PacketNum, RegFieldDesc(name = "dstPort2PacketNum", desc = "Number of packets to destination port 2"))  // 0x2A
    )
    regmap(fields.zipWithIndex.map({ case (f, i) => i * beatBytes -> Seq(f) }): _*)

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

class TLTemacConfigBlock(csrAddress: AddressSet, beatBytes:  Int)(implicit p: Parameters) extends TLTemacConfig(csrAddress, beatBytes) {
  val ioMem = mem.map { m => {
    val ioMemNode = BundleBridgeSource(() => TLBundle(standaloneParams))
    m := BundleBridgeToTL(TLMasterPortParameters.v1(Seq(TLMasterParameters.v1("bundleBridgeToTL")))) := ioMemNode
    val ioMem = InModuleBody { ioMemNode.makeIO() }
    ioMem
  }
  }
  // Generate TL slave output
  def standaloneParams: TLBundleParameters =
    TLBundleParameters(
      addressBits    = beatBytes * 8,
      dataBits       = beatBytes * 8,
      sourceBits     = 1,
      sinkBits       = 1,
      sizeBits       = 6,
      echoFields     = Seq(),
      requestFields  = Seq(),
      responseFields = Seq(),
      hasBCE         = false
    )
}

object TLTemacConfigBlockApp extends App {
  implicit val p: Parameters = Parameters.empty
  val configModule = LazyModule(new TLTemacConfigBlock(AddressSet(0x20000000, 0xff), 4))
  (new ChiselStage).execute(Array("--target-dir", "verilog/TemacConfig"), Seq(ChiselGeneratorAnnotation(() => configModule.module)))
}
