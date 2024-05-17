`timescale 1ns / 1ps

module GbEMAC (
    input         clk                ,
    input         clk125             ,
    input         clk125_90          ,
    input         reset              ,

    input  [ 7:0] tx_streaming_data  ,
    input         tx_streaming_valid ,
    input         tx_streaming_last  ,
    output        tx_streaming_ready ,
    output [ 7:0] rx_streaming_data  ,
    output        rx_streaming_valid ,
    output        rx_streaming_last  ,
    input         rx_streaming_ready ,

    output        phy_resetn         ,
    output [ 3:0] rgmii_txd          ,
    output        rgmii_tx_ctl       ,
    output        rgmii_txc          ,
    input  [ 3:0] rgmii_rxd          ,
    input         rgmii_rx_ctl       ,
    input         rgmii_rxc          ,

    input  [15:0] packetSize         ,
    input  [47:0] srcMac             ,
    input  [31:0] srcIp              ,
    input  [15:0] srcPort            ,
    input  [47:0] dstMac             ,
    input  [31:0] dstIp              ,
    input  [15:0] dstPort            ,
    input  [15:0] dstPort2           ,
    input  [15:0] dstPort1PacketNum  ,
    input  [15:0] dstPort2PacketNum
);

wire [7:0] tx_data_8b;
wire tx_valid_8b;
wire tx_ready_8b;
wire tx_last_8b;

wire [7:0] rx_data_8b;
wire rx_valid_8b;
wire rx_ready_8b;
wire rx_last_8b;

assign phy_resetn = 1'b1;

packet_creation_udp protocol_ctrl (
    .clk                   (clk),
    .reset                 (reset),
    .slave_data            (rx_data_8b),
    .slave_valid           (rx_valid_8b),
    .slave_last            (rx_last_8b),
    .slave_ready           (rx_ready_8b),
    .master_data           (tx_data_8b),
    .master_valid          (tx_valid_8b),
    .master_ready          (tx_ready_8b),
    .master_last           (tx_last_8b),

    .srcMac                (srcMac),
    .srcIp                 (srcIp),
    .srcPort               (srcPort),
    .dstMac                (dstMac),
    .dstIp                 (dstIp),
    .dstPort               (dstPort),
    .packetSize            (packetSize),

    .dstPort2              (dstPort2),
    .dstPort1PacketNum     (dstPort1PacketNum),
    .dstPort2PacketNum     (dstPort2PacketNum),

    .tx_streaming_data     (tx_streaming_data),
    .tx_streaming_valid    (tx_streaming_valid),
    .tx_streaming_ready    (tx_streaming_ready),
    .tx_streaming_last     (tx_streaming_last),

    .rx_streaming_data     (rx_streaming_data),
    .rx_streaming_valid    (rx_streaming_valid),
    .rx_streaming_ready    (rx_streaming_ready),
    .rx_streaming_last     (rx_streaming_last)
);

eth_mac_1g_rgmii_fifo #(
    .TARGET                ("XILINX"),
    .IODDR_STYLE           ("IODDR"),
    .CLOCK_INPUT_STYLE     ("BUFR"),
    .USE_CLK90             ("TRUE"),
    .AXIS_DATA_WIDTH       (8),
    .AXIS_KEEP_ENABLE      (1),
    .AXIS_KEEP_WIDTH       (1),
    .ENABLE_PADDING        (1),
    .MIN_FRAME_LENGTH      (64),
    .TX_FIFO_DEPTH         (1536),
    .TX_FIFO_RAM_PIPELINE  (1),
    .TX_FRAME_FIFO         (1),
    .TX_DROP_OVERSIZE_FRAME(1),
    .TX_DROP_BAD_FRAME     (1),
    .TX_DROP_WHEN_FULL     (0),
    .RX_FIFO_DEPTH         (128),
    .RX_FIFO_RAM_PIPELINE  (1),
    .RX_FRAME_FIFO         (1),
    .RX_DROP_OVERSIZE_FRAME(1),
    .RX_DROP_BAD_FRAME     (1),
    .RX_DROP_WHEN_FULL     (1)
)
eth_mac (
    .gtx_clk               (clk125),
    .gtx_clk90             (clk125_90),
    .gtx_rst               (reset),
    .logic_clk             (clk),
    .logic_rst             (reset),
    /* AXI input */
    .tx_axis_tdata         (tx_data_8b),
    .tx_axis_tvalid        (tx_valid_8b),
    .tx_axis_tready        (tx_ready_8b),
    .tx_axis_tlast         (tx_last_8b),
    .tx_axis_tuser         (0),
    .rx_axis_tdata         (rx_data_8b),
    .rx_axis_tvalid        (rx_valid_8b),
    .rx_axis_tready        (rx_ready_8b),
    .rx_axis_tlast         (rx_last_8b),
    .rx_axis_tuser         (),
    /* RGMII interface */
    .rgmii_rx_clk          (rgmii_rxc),
    .rgmii_rxd             (rgmii_rxd),
    .rgmii_rx_ctl          (rgmii_rx_ctl),
    .rgmii_tx_clk          (rgmii_txc),
    .rgmii_txd             (rgmii_txd),
    .rgmii_tx_ctl          (rgmii_tx_ctl),
    /* Status */
    .tx_error_underflow    ( ),
    .tx_fifo_overflow      ( ),
    .tx_fifo_bad_frame     ( ),
    .tx_fifo_good_frame    ( ),
    .rx_error_bad_frame    ( ),
    .rx_error_bad_fcs      ( ),
    .rx_fifo_overflow      ( ),
    .rx_fifo_bad_frame     ( ),
    .rx_fifo_good_frame    ( ),
    .speed                 ( ),
    .cfg_ifg               (8'd12),
    .cfg_tx_enable         (1'b1),
    .cfg_rx_enable         (1'b1)
);
endmodule
