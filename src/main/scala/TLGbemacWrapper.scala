package ethernet

import chisel3._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.axi4stream._
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.tilelink._
import org.chipsalliance.cde.config.Parameters
import chisel3.stage.{ChiselGeneratorAnnotation, ChiselStage}

class TLGbemacWrapper(csrAddress: AddressSet, beatBytes: Int) extends LazyModule()(Parameters.empty) {
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
  val configBlock = LazyModule(new TemacConfig(csrAddress, beatBytes) {
    def makeIO2(): TemacConfigIO = {
      val io2: TemacConfigIO = IO(io.cloneType)
      io2.suggestName("ioReg")
      io2 <> io
      io2
    }
    val ioReg: ModuleValue[TemacConfigIO] = InModuleBody { makeIO2() }
  })

  val mem:        Option[TLIdentityNode] = Some(TLIdentityNode())
  val streamNode: Option[AXI4StreamSlaveNode] = Some(AXI4StreamSlaveNode(AXI4StreamSlaveParameters()))

  configBlock.mem.get := AXI4UserYanker() := AXI4Deinterleaver(64) := TLToAXI4() := mem.get
}

class TLGbemacWrapperBlock(csrAddress: AddressSet, beatBytes: Int)(implicit p: Parameters)
    extends TLGbemacWrapper(csrAddress, beatBytes) {
  val ioMem = mem.map { m => {
      val ioMemNode = BundleBridgeSource(() => TLBundle(standaloneParams))
      m := BundleBridgeToTL(TLMasterPortParameters.v1(Seq(TLMasterParameters.v1("bundleBridgeToTL")))) := ioMemNode
      val ioMem = InModuleBody { ioMemNode.makeIO() }
      ioMem
    }
  }
  val ioInNode: BundleBridgeSource[AXI4StreamBundle] = BundleBridgeSource(() => new AXI4StreamBundle(AXI4StreamBundleParameters(n = 4)))
  val in: ModuleValue[AXI4StreamBundle] = InModuleBody { ioInNode.makeIO() }
  streamNode.get := BundleBridgeToAXI4Stream(AXI4StreamMasterParameters(n = 4)) := ioInNode

  // Generate TL slave output
  def standaloneParams: TLBundleParameters =
    TLBundleParameters(
      addressBits = beatBytes * 8,
      dataBits = beatBytes * 8,
      sourceBits = 1,
      sinkBits = 1,
      sizeBits = 6,
      echoFields = Seq(),
      requestFields = Seq(),
      responseFields = Seq(),
      hasBCE = false
    )
}

object TLGbemacWrapperBlockApp extends App {
  implicit val p: Parameters = Parameters.empty
  val gbemacModule = LazyModule(new TLGbemacWrapperBlock(AddressSet(0x20000000, 0xff), 4))

  (new ChiselStage).execute(Array("--target-dir", "verilog/TLGbemacWrapper"), Seq(ChiselGeneratorAnnotation(() => gbemacModule.module)))
}
