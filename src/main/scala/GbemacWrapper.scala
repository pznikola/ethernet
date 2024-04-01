package ethernet

import chisel3._
import chisel3.util._
import chisel3.experimental.Analog
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4stream._
import org.chipsalliance.cde.config.Parameters
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}

class GbEMAC extends BlackBox with HasBlackBoxResource {
  val io = IO(new Bundle {
    val clk                     = Input(Clock())
    val clk125                  = Input(Clock())
    val clk125_90               = Input(Clock())
    val clk5                    = Input(Clock())
    val reset                   = Input(Bool())

    val tx_streaming_data       = Input(UInt(32.W))
    val tx_streaming_valid      = Input(Bool())
    val tx_streaming_last       = Input(Bool())
    val tx_streaming_ready      = Output(Bool())

    val phy_resetn              = Output(Bool())
    val rgmii_txd               = Output(UInt(4.W))
    val rgmii_tx_ctl            = Output(Bool())
    val rgmii_txc               = Output(Bool())
    val rgmii_rxd               = Input(UInt(4.W))
    val rgmii_rx_ctl            = Input(Bool())
    val rgmii_rxc               = Input(Bool())
    val mdio                    = Analog(1.W)
    val mdc                     = Output(Bool())

    val txHwmark                = Input(UInt(5.W))
    val txLwmark                = Input(UInt(5.W))
    val pauseFrameSendEn        = Input(Bool())
    val pauseQuantaSet          = Input(UInt(16.W))
    val macTxAddEn              = Input(Bool())
    val fullDuplex              = Input(Bool())
    val maxRetry                = Input(UInt(4.W))
    val ifgSet                  = Input(UInt(6.W))
    val macTxAddPromData        = Input(UInt(8.W))
    val macTxAddPromAdd         = Input(UInt(3.W))
    val macTxAddPromWr          = Input(Bool())
    val txPauseEn               = Input(Bool())
    val xOffCpu                 = Input(Bool())
    val xOnCpu                  = Input(Bool())
    val macRxAddChkEn           = Input(Bool())
    val macRxAddPromData        = Input(UInt(8.W))
    val macRxAddPromAdd         = Input(UInt(3.W))
    val macRxAddPromWr          = Input(Bool())
    val broadcastFilterEn       = Input(Bool())
    val broadcastBucketDepth    = Input(UInt(16.W))
    val broadcastBucketInterval = Input(UInt(16.W))
    val rxAppendCrc             = Input(Bool())
    val rxHwmark                = Input(UInt(5.W))
    val rxLwmark                = Input(UInt(5.W))
    val crcCheckEn              = Input(Bool())
    val rxIfgSet                = Input(UInt(6.W))
    val rxMaxLength             = Input(UInt(16.W))
    val rxMinLength             = Input(UInt(7.W))
    val cpuRdAddr               = Input(UInt(6.W))
    val cpuRdApply              = Input(Bool())
    val lineLoopEn              = Input(Bool())
    val speed                   = Input(UInt(3.W))
    val divider                 = Input(UInt(8.W))
    val ctrlData                = Input(UInt(16.W))
    val rgAd                    = Input(UInt(5.W))
    val fiAd                    = Input(UInt(5.W))
    val writeCtrlData           = Input(Bool())
    val noPreamble              = Input(Bool())
    val packetSize              = Input(UInt(16.W))
    val srcMac                  = Input(UInt(48.W))
    val srcIp                   = Input(UInt(32.W))
    val srcPort                 = Input(UInt(16.W))
    val dstMac                  = Input(UInt(48.W))
    val dstIp                   = Input(UInt(32.W))
    val dstPort                 = Input(UInt(16.W))
    val dstPort2                = Input(UInt(16.W))
    val dstPort1PacketNum       = Input(UInt(16.W))
    val dstPort2PacketNum       = Input(UInt(16.W))
  })
  addResource("ethernet/vsrc/ethernet/rtl/AXI4StreamWidthAdapter1to4.v")
  addResource("ethernet/vsrc/ethernet/rtl/AXI4StreamWidthAdapter4to1.v")
  addResource("ethernet/vsrc/ethernet/rtl/axis_adapter.v")
  addResource("ethernet/vsrc/ethernet/rtl/axis_async_fifo.v")
  addResource("ethernet/vsrc/ethernet/rtl/axis_async_fifo_adapter.v")
  addResource("ethernet/vsrc/ethernet/rtl/axis_gmii_rx.v")
  addResource("ethernet/vsrc/ethernet/rtl/axis_gmii_tx.v")
  addResource("ethernet/vsrc/ethernet/rtl/eth_clockgen.v")
  addResource("ethernet/vsrc/ethernet/rtl/eth_mac_1g.v")
  addResource("ethernet/vsrc/ethernet/rtl/eth_mac_1g_rgmii.v")
  addResource("ethernet/vsrc/ethernet/rtl/eth_mac_1g_rgmii_fifo.v")
  addResource("ethernet/vsrc/ethernet/rtl/eth_miim.v")
  addResource("ethernet/vsrc/ethernet/rtl/eth_outputcontrol.v")
  addResource("ethernet/vsrc/ethernet/rtl/eth_shiftreg.v")
  addResource("ethernet/vsrc/ethernet/rtl/iddr.v")
  addResource("ethernet/vsrc/ethernet/rtl/lfsr.v")
  addResource("ethernet/vsrc/ethernet/rtl/oddr.v")
  addResource("ethernet/vsrc/ethernet/rtl/packet_creation_udp_8b.v")
  addResource("ethernet/vsrc/ethernet/rtl/phy_chip_conf_fsm.v")
  addResource("ethernet/vsrc/ethernet/rtl/rgmii_phy_if.v")
  addResource("ethernet/vsrc/ethernet/rtl/ssio_ddr_in.v")
  addResource("ethernet/vsrc/GbEMAC.v")
}

class GbemacWrapperIO() extends Bundle {
  val clk125       = Input(Clock())
  val clk125_90    = Input(Clock())
  val clk5         = Input(Clock())
  val phy_resetn   = Output(Bool())
  val rgmii_txd    = Output(UInt(4.W))
  val rgmii_tx_ctl = Output(Bool())
  val rgmii_txc    = Output(Bool())
  val rgmii_rxd    = Input(UInt(4.W))
  val rgmii_rx_ctl = Input(Bool())
  val rgmii_rxc    = Input(Bool())
  val mdio         = Analog(1.W)
  val mdc          = Output(Bool())
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

  // Memory Node
  val mem = Some(AXI4IdentityNode())
  configBlock.mem.get := mem.get
  // Stream Node
  val streamNode = Some(AXI4StreamSlaveNode(AXI4StreamSlaveParameters()))
  // IO
  lazy val io: GbemacWrapperIO = IO(new GbemacWrapperIO)

  lazy val module: LazyModuleImp = new LazyModuleImp(this) {

    val gbemac: GbEMAC = Module(new GbEMAC())

    gbemac.io.clk                     := clock
    gbemac.io.clk125                  := io.clk125
    gbemac.io.clk125_90               := io.clk125_90
    gbemac.io.clk5                    := io.clk5
    gbemac.io.reset                   := reset

    io.phy_resetn                     := gbemac.io.phy_resetn
    io.rgmii_txd                      := gbemac.io.rgmii_txd
    io.rgmii_tx_ctl                   := gbemac.io.rgmii_tx_ctl
    io.rgmii_txc                      := gbemac.io.rgmii_txc
    gbemac.io.rgmii_rxd               := io.rgmii_rxd
    gbemac.io.rgmii_rx_ctl            := io.rgmii_rx_ctl
    gbemac.io.rgmii_rxc               := io.rgmii_rxc
    gbemac.io.mdio                    <> io.mdio
    io.mdc                            := gbemac.io.mdc

    gbemac.io.tx_streaming_data       := streamNode.get.in.head._1.bits.data
    gbemac.io.tx_streaming_valid      := streamNode.get.in.head._1.valid
    gbemac.io.tx_streaming_last       := streamNode.get.in.head._1.bits.last
    streamNode.get.in.head._1.ready   := gbemac.io.tx_streaming_ready

    gbemac.io.txHwmark                := configBlock.ioReg.txHwmark
    gbemac.io.txLwmark                := configBlock.ioReg.txLwmark
    gbemac.io.pauseFrameSendEn        := configBlock.ioReg.pauseFrameSendEn
    gbemac.io.pauseQuantaSet          := configBlock.ioReg.pauseQuantaSet
    gbemac.io.ifgSet                  := configBlock.ioReg.ifgSet
    gbemac.io.fullDuplex              := configBlock.ioReg.fullDuplex
    gbemac.io.maxRetry                := configBlock.ioReg.maxRetry
    gbemac.io.macTxAddEn              := configBlock.ioReg.macTxAddEn
    gbemac.io.macTxAddPromData        := configBlock.ioReg.macTxAddPromData
    gbemac.io.macTxAddPromAdd         := configBlock.ioReg.macTxAddPromAdd
    gbemac.io.macTxAddPromWr          := configBlock.ioReg.macTxAddPromWr
    gbemac.io.txPauseEn               := configBlock.ioReg.txPauseEn
    gbemac.io.xOffCpu                 := configBlock.ioReg.xOffCpu
    gbemac.io.xOnCpu                  := configBlock.ioReg.xOnCpu
    gbemac.io.macRxAddChkEn           := configBlock.ioReg.macRxAddChkEn
    gbemac.io.macRxAddPromData        := configBlock.ioReg.macRxAddPromData
    gbemac.io.macRxAddPromAdd         := configBlock.ioReg.macRxAddPromAdd
    gbemac.io.macRxAddPromWr          := configBlock.ioReg.macRxAddPromWr
    gbemac.io.broadcastFilterEn       := configBlock.ioReg.broadcastFilterEn
    gbemac.io.broadcastBucketDepth    := configBlock.ioReg.broadcastBucketDepth
    gbemac.io.broadcastBucketInterval := configBlock.ioReg.broadcastBucketInterval
    gbemac.io.rxAppendCrc             := configBlock.ioReg.rxAppendCrc
    gbemac.io.rxHwmark                := configBlock.ioReg.rxHwmark
    gbemac.io.rxLwmark                := configBlock.ioReg.rxLwmark
    gbemac.io.crcCheckEn              := configBlock.ioReg.crcCheckEn
    gbemac.io.rxIfgSet                := configBlock.ioReg.rxIfgSet
    gbemac.io.rxMaxLength             := configBlock.ioReg.rxMaxLength
    gbemac.io.rxMinLength             := configBlock.ioReg.rxMinLength
    gbemac.io.cpuRdAddr               := configBlock.ioReg.cpuRdAddr
    gbemac.io.cpuRdApply              := configBlock.ioReg.cpuRdApply
    gbemac.io.lineLoopEn              := configBlock.ioReg.lineLoopEn
    gbemac.io.speed                   := configBlock.ioReg.speed
    gbemac.io.divider                 := configBlock.ioReg.divider
    gbemac.io.ctrlData                := configBlock.ioReg.ctrlData
    gbemac.io.rgAd                    := configBlock.ioReg.rgAd
    gbemac.io.fiAd                    := configBlock.ioReg.fiAd
    gbemac.io.writeCtrlData           := configBlock.ioReg.writeCtrlData
    gbemac.io.noPreamble              := configBlock.ioReg.noPreamble
    gbemac.io.packetSize              := configBlock.ioReg.packetSize
    gbemac.io.srcMac                  := configBlock.ioReg.srcMac
    gbemac.io.srcIp                   := configBlock.ioReg.srcIp
    gbemac.io.srcPort                 := configBlock.ioReg.srcPort
    gbemac.io.dstMac                  := configBlock.ioReg.dstMac
    gbemac.io.dstIp                   := configBlock.ioReg.dstIp
    gbemac.io.dstPort                 := configBlock.ioReg.dstPort
    gbemac.io.dstPort2                := configBlock.ioReg.dstPort2
    gbemac.io.dstPort1PacketNum       := configBlock.ioReg.dstPort1PacketNum
    gbemac.io.dstPort2PacketNum       := configBlock.ioReg.dstPort2PacketNum
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
  streamNode.get := BundleBridgeToAXI4Stream(AXI4StreamMasterParameters(n = 4)) := ioInNode
  val in = InModuleBody { ioInNode.makeIO() }
}

object GbemacWrapperBlockApp extends App {
  implicit val p: Parameters = Parameters.empty
  val gbemacModule = LazyModule(new GbemacWrapperBlock(AddressSet(0x20000000, 0xff), 4) {
    override def standaloneParams = AXI4BundleParameters(addrBits = 32, dataBits = 32, idBits = 1)
  })
  (new ChiselStage).execute(Array("--target-dir", "verilog/GbemacWrapper"), Seq(ChiselGeneratorAnnotation(() => gbemacModule.module)))
}
