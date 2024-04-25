package ethernet

import chisel3._
import chisel3.util._
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4stream._
import org.chipsalliance.cde.config.Parameters
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}

class GbEMAC extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle {
    val clk                = Input(Clock())
    val clk125             = Input(Clock())
    val clk125_90          = Input(Clock())
    val reset              = Input(Bool())

    val tx_streaming_data  = Input(UInt(32.W))
    val tx_streaming_valid = Input(Bool())
    val tx_streaming_last  = Input(Bool())
    val tx_streaming_ready = Output(Bool())

    val rx_streaming_data  = Output(UInt(32.W))
    val rx_streaming_valid = Output(Bool())
    val rx_streaming_last  = Output(Bool())
    val rx_streaming_ready = Input(Bool())

    val phy_resetn         = Output(Bool())
    val rgmii_txd          = Output(UInt(4.W))
    val rgmii_tx_ctl       = Output(Bool())
    val rgmii_txc          = Output(Bool())
    val rgmii_rxd          = Input(UInt(4.W))
    val rgmii_rx_ctl       = Input(Bool())
    val rgmii_rxc          = Input(Bool())

    val packetSize         = Input(UInt(16.W))
    val srcMac             = Input(UInt(48.W))
    val srcIp              = Input(UInt(32.W))
    val srcPort            = Input(UInt(16.W))
    val dstMac             = Input(UInt(48.W))
    val dstIp              = Input(UInt(32.W))
    val dstPort            = Input(UInt(16.W))
    val dstPort2           = Input(UInt(16.W))
    val dstPort1PacketNum  = Input(UInt(16.W))
    val dstPort2PacketNum  = Input(UInt(16.W))
  })

  // From Alex ethernet
  addResource("axis_gmii_rx.v")
  addResource("axis_gmii_tx.v")
  addResource("eth_mac_1g.v")
  addResource("eth_mac_1g_rgmii.v")
  addResource("eth_mac_1g_rgmii_fifo.v")
  addResource("iddr.v")
  addResource("lfsr.v")
  addResource("oddr.v")
  addResource("rgmii_phy_if.v")
  addResource("ssio_ddr_in.v")
  // From Alex axis
  addResource("axis_adapter.v")
  addResource("axis_async_fifo.v")
  addResource("axis_async_fifo_adapter.v")
  // Added RTL
  addResource("AXI4StreamWidthAdapter1to4.v")
  addResource("AXI4StreamWidthAdapter4to1.v")
  addResource("packet_creation_udp.v")
  addResource("GbEMAC.v")
}

class GbemacWrapperIO() extends Bundle {
  val clk125       = Input(Clock())
  val clk125_90    = Input(Clock())
  val phy_resetn   = Output(Bool())
  val rgmii_txd    = Output(UInt(4.W))
  val rgmii_tx_ctl = Output(Bool())
  val rgmii_txc    = Output(Bool())
  val rgmii_rxd    = Input(UInt(4.W))
  val rgmii_rx_ctl = Input(Bool())
  val rgmii_rxc    = Input(Bool())
}

class GbemacWrapper(csrAddress: AddressSet, beatBytes: Int) extends LazyModule()(Parameters.empty) {
  val configBlock = LazyModule(new TemacConfig(csrAddress, beatBytes) {
    def makeIO2(): TemacConfigIO = {
      val io2: TemacConfigIO = IO(io.cloneType)
      io2.suggestName("ioReg")
      io2 <> io
      io2
    }
    val ioReg = InModuleBody { makeIO2() }
  })

  // Nodes
  val mem: Option[AXI4IdentityNode] = Some(AXI4IdentityNode())
  val streamNode: AXI4StreamIdentityNode = AXI4StreamIdentityNode()
  configBlock.mem.get := mem.get

  // IO
  lazy val io: GbemacWrapperIO = IO(new GbemacWrapperIO)

  lazy val module: LazyModuleImp = new LazyModuleImp(this) {
    val gbemac: GbEMAC = Module(new GbEMAC())

    gbemac.io.clk                    := clock
    gbemac.io.clk125                 := io.clk125
    gbemac.io.clk125_90              := io.clk125_90
    gbemac.io.reset                  := reset

    io.phy_resetn                    := gbemac.io.phy_resetn
    io.rgmii_txd                     := gbemac.io.rgmii_txd
    io.rgmii_tx_ctl                  := gbemac.io.rgmii_tx_ctl
    io.rgmii_txc                     := gbemac.io.rgmii_txc
    gbemac.io.rgmii_rxd              := io.rgmii_rxd
    gbemac.io.rgmii_rx_ctl           := io.rgmii_rx_ctl
    gbemac.io.rgmii_rxc              := io.rgmii_rxc

    gbemac.io.tx_streaming_data      := streamNode.in.head._1.bits.data
    gbemac.io.tx_streaming_valid     := streamNode.in.head._1.valid
    gbemac.io.tx_streaming_last      := streamNode.in.head._1.bits.last
    streamNode.in.head._1.ready      := gbemac.io.tx_streaming_ready

    streamNode.out.head._1.bits.data := gbemac.io.rx_streaming_data
    streamNode.out.head._1.valid     := gbemac.io.rx_streaming_valid
    streamNode.out.head._1.bits.last := gbemac.io.rx_streaming_last
    gbemac.io.rx_streaming_ready     := streamNode.out.head._1.ready

    gbemac.io.packetSize             := configBlock.ioReg.packetSize
    gbemac.io.srcMac                 := configBlock.ioReg.srcMac
    gbemac.io.srcIp                  := configBlock.ioReg.srcIp
    gbemac.io.srcPort                := configBlock.ioReg.srcPort
    gbemac.io.dstMac                 := configBlock.ioReg.dstMac
    gbemac.io.dstIp                  := configBlock.ioReg.dstIp
    gbemac.io.dstPort                := configBlock.ioReg.dstPort
    gbemac.io.dstPort2               := configBlock.ioReg.dstPort2
    gbemac.io.dstPort1PacketNum      := configBlock.ioReg.dstPort1PacketNum
    gbemac.io.dstPort2PacketNum      := configBlock.ioReg.dstPort2PacketNum
  }
}

class GbemacWrapperBlock(csrAddress: AddressSet, beatBytes: Int)(implicit p: Parameters) extends GbemacWrapper(csrAddress, beatBytes) {
  // Memory Node
  def standaloneParams = AXI4BundleParameters(addrBits = 32, dataBits = 32, idBits = 1)
  val ioMem = mem.map { m => {
      val ioMemNode = BundleBridgeSource(() => AXI4Bundle(standaloneParams))
      m := BundleBridgeToAXI4(AXI4MasterPortParameters(Seq(AXI4MasterParameters("bundleBridgeToAXI4")))) := ioMemNode
      val ioMem = InModuleBody { ioMemNode.makeIO() }
      ioMem
    }
  }
  // Stream Node
  val ioInNode = BundleBridgeSource(() => new AXI4StreamBundle(AXI4StreamBundleParameters(n = 4)))
  val ioOutNode = BundleBridgeSink[AXI4StreamBundle]()
  ioOutNode  := AXI4StreamToBundleBridge(AXI4StreamSlaveParameters())       := streamNode
  streamNode := BundleBridgeToAXI4Stream(AXI4StreamMasterParameters(n = 4)) := ioInNode
  val in  = InModuleBody { ioInNode.makeIO() }
  val out = InModuleBody { ioOutNode.makeIO() }
}

object GbemacWrapperBlockApp extends App {
  implicit val p: Parameters = Parameters.empty
  val gbemacModule = LazyModule(new GbemacWrapperBlock(AddressSet(0x20000000, 0xff), 4) {
    override def standaloneParams = AXI4BundleParameters(addrBits = 32, dataBits = 32, idBits = 1)
  })
  (new ChiselStage).execute(Array("--target-dir", "verilog/GbemacWrapper"), Seq(ChiselGeneratorAnnotation(() => gbemacModule.module)))
}
