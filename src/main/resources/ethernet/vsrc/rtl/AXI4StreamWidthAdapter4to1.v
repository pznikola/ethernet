module VoidModuleWidthAdapter4to1(
  input        auto_out_out_ready,
  output       auto_out_out_valid,
  output [7:0] auto_out_out_bits_data,
  output       auto_out_out_bits_last,
  output       auto_in_in_ready,
  input        auto_in_in_valid,
  input  [7:0] auto_in_in_bits_data,
  input        auto_in_in_bits_last
);
  assign auto_out_out_valid = auto_in_in_valid; // @[LazyModule.scala 173:49]
  assign auto_out_out_bits_data = auto_in_in_bits_data; // @[LazyModule.scala 173:49]
  assign auto_out_out_bits_last = auto_in_in_bits_last; // @[LazyModule.scala 173:49]
  assign auto_in_in_ready = auto_out_out_ready; // @[LazyModule.scala 173:31]
endmodule
module VoidModuleWidthAdapter4to1_1(
  input         auto_out_out_ready,
  output        auto_out_out_valid,
  output [31:0] auto_out_out_bits_data,
  output        auto_out_out_bits_last,
  output        auto_in_in_ready,
  input         auto_in_in_valid,
  input  [31:0] auto_in_in_bits_data,
  input         auto_in_in_bits_last
);
  assign auto_out_out_valid = auto_in_in_valid; // @[LazyModule.scala 173:49]
  assign auto_out_out_bits_data = auto_in_in_bits_data; // @[LazyModule.scala 173:49]
  assign auto_out_out_bits_last = auto_in_in_bits_last; // @[LazyModule.scala 173:49]
  assign auto_in_in_ready = auto_out_out_ready; // @[LazyModule.scala 173:31]
endmodule
module AXI4StreamWidthAdapater_4_to_1(
  input         clock,
  input         reset,
  output        auto_in_ready,
  input         auto_in_valid,
  input  [7:0]  auto_in_bits_data,
  input         auto_in_bits_last,
  input         auto_out_ready,
  output        auto_out_valid,
  output [31:0] auto_out_bits_data,
  output        auto_out_bits_last
);
  reg [7:0] _T; // @[AXI4StreamWidthAdapter.scala 101:37]
  reg [31:0] _RAND_0;
  reg [7:0] _T_1; // @[AXI4StreamWidthAdapter.scala 101:37]
  reg [31:0] _RAND_1;
  reg [7:0] _T_2; // @[AXI4StreamWidthAdapter.scala 101:37]
  reg [31:0] _RAND_2;
  reg [1:0] _T_3; // @[AXI4StreamWidthAdapter.scala 102:22]
  reg [31:0] _RAND_3;
  wire  _T_4; // @[AXI4StreamWidthAdapter.scala 103:14]
  wire  _T_5; // @[AXI4StreamWidthAdapter.scala 103:38]
  wire [2:0] _T_6; // @[AXI4StreamWidthAdapter.scala 103:60]
  wire [2:0] _T_7; // @[AXI4StreamWidthAdapter.scala 103:33]
  wire [2:0] _GEN_0; // @[AXI4StreamWidthAdapter.scala 103:21]
  wire  _T_9; // @[AXI4StreamWidthAdapter.scala 106:29]
  wire  _T_10; // @[AXI4StreamWidthAdapter.scala 106:22]
  wire  _T_12; // @[AXI4StreamWidthAdapter.scala 106:29]
  wire  _T_13; // @[AXI4StreamWidthAdapter.scala 106:22]
  wire  _T_15; // @[AXI4StreamWidthAdapter.scala 106:29]
  wire  _T_16; // @[AXI4StreamWidthAdapter.scala 106:22]
  wire [23:0] _T_18; // @[Cat.scala 29:58]
  wire  ov0; // @[AXI4StreamWidthAdapter.scala 112:32]
  reg  _T_20; // @[AXI4StreamWidthAdapter.scala 101:37]
  reg [31:0] _RAND_4;
  reg  _T_21; // @[AXI4StreamWidthAdapter.scala 101:37]
  reg [31:0] _RAND_5;
  reg  _T_22; // @[AXI4StreamWidthAdapter.scala 101:37]
  reg [31:0] _RAND_6;
  reg [1:0] _T_23; // @[AXI4StreamWidthAdapter.scala 102:22]
  reg [31:0] _RAND_7;
  wire  _T_25; // @[AXI4StreamWidthAdapter.scala 103:38]
  wire [2:0] _T_26; // @[AXI4StreamWidthAdapter.scala 103:60]
  wire [2:0] _T_27; // @[AXI4StreamWidthAdapter.scala 103:33]
  wire [2:0] _GEN_4; // @[AXI4StreamWidthAdapter.scala 103:21]
  wire  _T_29; // @[AXI4StreamWidthAdapter.scala 106:29]
  wire  _T_30; // @[AXI4StreamWidthAdapter.scala 106:22]
  wire  _T_32; // @[AXI4StreamWidthAdapter.scala 106:29]
  wire  _T_33; // @[AXI4StreamWidthAdapter.scala 106:22]
  wire  _T_35; // @[AXI4StreamWidthAdapter.scala 106:29]
  wire  _T_36; // @[AXI4StreamWidthAdapter.scala 106:22]
  wire [3:0] _T_39; // @[Cat.scala 29:58]
  wire  ov1; // @[AXI4StreamWidthAdapter.scala 112:32]
  reg [1:0] _T_44; // @[AXI4StreamWidthAdapter.scala 102:22]
  reg [31:0] _RAND_8;
  wire  _T_46; // @[AXI4StreamWidthAdapter.scala 103:38]
  wire [2:0] _T_47; // @[AXI4StreamWidthAdapter.scala 103:60]
  wire [2:0] _T_48; // @[AXI4StreamWidthAdapter.scala 103:33]
  wire [2:0] _GEN_8; // @[AXI4StreamWidthAdapter.scala 103:21]
  wire  ov2; // @[AXI4StreamWidthAdapter.scala 112:32]
  reg [1:0] _T_64; // @[AXI4StreamWidthAdapter.scala 102:22]
  reg [31:0] _RAND_9;
  wire  _T_66; // @[AXI4StreamWidthAdapter.scala 103:38]
  wire [2:0] _T_67; // @[AXI4StreamWidthAdapter.scala 103:60]
  wire [2:0] _T_68; // @[AXI4StreamWidthAdapter.scala 103:33]
  wire [2:0] _GEN_12; // @[AXI4StreamWidthAdapter.scala 103:21]
  wire  ov3; // @[AXI4StreamWidthAdapter.scala 112:32]
  reg [1:0] _T_84; // @[AXI4StreamWidthAdapter.scala 102:22]
  reg [31:0] _RAND_10;
  wire  _T_86; // @[AXI4StreamWidthAdapter.scala 103:38]
  wire [2:0] _T_87; // @[AXI4StreamWidthAdapter.scala 103:60]
  wire [2:0] _T_88; // @[AXI4StreamWidthAdapter.scala 103:33]
  wire [2:0] _GEN_16; // @[AXI4StreamWidthAdapter.scala 103:21]
  wire  ov4; // @[AXI4StreamWidthAdapter.scala 112:32]
  wire  _T_101; // @[AXI4StreamWidthAdapter.scala 42:16]
  wire  _T_103; // @[AXI4StreamWidthAdapter.scala 42:11]
  wire  _T_104; // @[AXI4StreamWidthAdapter.scala 42:11]
  wire  _T_105; // @[AXI4StreamWidthAdapter.scala 43:16]
  wire  _T_107; // @[AXI4StreamWidthAdapter.scala 43:11]
  wire  _T_108; // @[AXI4StreamWidthAdapter.scala 43:11]
  wire  _T_109; // @[AXI4StreamWidthAdapter.scala 44:16]
  wire  _T_111; // @[AXI4StreamWidthAdapter.scala 44:11]
  wire  _T_112; // @[AXI4StreamWidthAdapter.scala 44:11]
  wire  _T_113; // @[AXI4StreamWidthAdapter.scala 45:16]
  wire  _T_115; // @[AXI4StreamWidthAdapter.scala 45:11]
  wire  _T_116; // @[AXI4StreamWidthAdapter.scala 45:11]
  assign _T_4 = auto_in_valid & auto_out_ready; // @[AXI4StreamWidthAdapter.scala 103:14]
  assign _T_5 = _T_3 == 2'h3; // @[AXI4StreamWidthAdapter.scala 103:38]
  assign _T_6 = _T_3 + 2'h1; // @[AXI4StreamWidthAdapter.scala 103:60]
  assign _T_7 = _T_5 ? 3'h0 : _T_6; // @[AXI4StreamWidthAdapter.scala 103:33]
  assign _GEN_0 = _T_4 ? _T_7 : {{1'd0}, _T_3}; // @[AXI4StreamWidthAdapter.scala 103:21]
  assign _T_9 = _T_3 == 2'h0; // @[AXI4StreamWidthAdapter.scala 106:29]
  assign _T_10 = _T_4 & _T_9; // @[AXI4StreamWidthAdapter.scala 106:22]
  assign _T_12 = _T_3 == 2'h1; // @[AXI4StreamWidthAdapter.scala 106:29]
  assign _T_13 = _T_4 & _T_12; // @[AXI4StreamWidthAdapter.scala 106:22]
  assign _T_15 = _T_3 == 2'h2; // @[AXI4StreamWidthAdapter.scala 106:29]
  assign _T_16 = _T_4 & _T_15; // @[AXI4StreamWidthAdapter.scala 106:22]
  assign _T_18 = {auto_in_bits_data,_T_2,_T_1}; // @[Cat.scala 29:58]
  assign ov0 = _T_5 & auto_in_valid; // @[AXI4StreamWidthAdapter.scala 112:32]
  assign _T_25 = _T_23 == 2'h3; // @[AXI4StreamWidthAdapter.scala 103:38]
  assign _T_26 = _T_23 + 2'h1; // @[AXI4StreamWidthAdapter.scala 103:60]
  assign _T_27 = _T_25 ? 3'h0 : _T_26; // @[AXI4StreamWidthAdapter.scala 103:33]
  assign _GEN_4 = _T_4 ? _T_27 : {{1'd0}, _T_23}; // @[AXI4StreamWidthAdapter.scala 103:21]
  assign _T_29 = _T_23 == 2'h0; // @[AXI4StreamWidthAdapter.scala 106:29]
  assign _T_30 = _T_4 & _T_29; // @[AXI4StreamWidthAdapter.scala 106:22]
  assign _T_32 = _T_23 == 2'h1; // @[AXI4StreamWidthAdapter.scala 106:29]
  assign _T_33 = _T_4 & _T_32; // @[AXI4StreamWidthAdapter.scala 106:22]
  assign _T_35 = _T_23 == 2'h2; // @[AXI4StreamWidthAdapter.scala 106:29]
  assign _T_36 = _T_4 & _T_35; // @[AXI4StreamWidthAdapter.scala 106:22]
  assign _T_39 = {auto_in_bits_last,_T_22,_T_21,_T_20}; // @[Cat.scala 29:58]
  assign ov1 = _T_25 & auto_in_valid; // @[AXI4StreamWidthAdapter.scala 112:32]
  assign _T_46 = _T_44 == 2'h3; // @[AXI4StreamWidthAdapter.scala 103:38]
  assign _T_47 = _T_44 + 2'h1; // @[AXI4StreamWidthAdapter.scala 103:60]
  assign _T_48 = _T_46 ? 3'h0 : _T_47; // @[AXI4StreamWidthAdapter.scala 103:33]
  assign _GEN_8 = _T_4 ? _T_48 : {{1'd0}, _T_44}; // @[AXI4StreamWidthAdapter.scala 103:21]
  assign ov2 = _T_46 & auto_in_valid; // @[AXI4StreamWidthAdapter.scala 112:32]
  assign _T_66 = _T_64 == 2'h3; // @[AXI4StreamWidthAdapter.scala 103:38]
  assign _T_67 = _T_64 + 2'h1; // @[AXI4StreamWidthAdapter.scala 103:60]
  assign _T_68 = _T_66 ? 3'h0 : _T_67; // @[AXI4StreamWidthAdapter.scala 103:33]
  assign _GEN_12 = _T_4 ? _T_68 : {{1'd0}, _T_64}; // @[AXI4StreamWidthAdapter.scala 103:21]
  assign ov3 = _T_66 & auto_in_valid; // @[AXI4StreamWidthAdapter.scala 112:32]
  assign _T_86 = _T_84 == 2'h3; // @[AXI4StreamWidthAdapter.scala 103:38]
  assign _T_87 = _T_84 + 2'h1; // @[AXI4StreamWidthAdapter.scala 103:60]
  assign _T_88 = _T_86 ? 3'h0 : _T_87; // @[AXI4StreamWidthAdapter.scala 103:33]
  assign _GEN_16 = _T_4 ? _T_88 : {{1'd0}, _T_84}; // @[AXI4StreamWidthAdapter.scala 103:21]
  assign ov4 = _T_86 & auto_in_valid; // @[AXI4StreamWidthAdapter.scala 112:32]
  assign _T_101 = ov0 == ov1; // @[AXI4StreamWidthAdapter.scala 42:16]
  assign _T_103 = _T_101 | reset; // @[AXI4StreamWidthAdapter.scala 42:11]
  assign _T_104 = ~_T_103; // @[AXI4StreamWidthAdapter.scala 42:11]
  assign _T_105 = ov0 == ov2; // @[AXI4StreamWidthAdapter.scala 43:16]
  assign _T_107 = _T_105 | reset; // @[AXI4StreamWidthAdapter.scala 43:11]
  assign _T_108 = ~_T_107; // @[AXI4StreamWidthAdapter.scala 43:11]
  assign _T_109 = ov0 == ov3; // @[AXI4StreamWidthAdapter.scala 44:16]
  assign _T_111 = _T_109 | reset; // @[AXI4StreamWidthAdapter.scala 44:11]
  assign _T_112 = ~_T_111; // @[AXI4StreamWidthAdapter.scala 44:11]
  assign _T_113 = ov0 == ov4; // @[AXI4StreamWidthAdapter.scala 45:16]
  assign _T_115 = _T_113 | reset; // @[AXI4StreamWidthAdapter.scala 45:11]
  assign _T_116 = ~_T_115; // @[AXI4StreamWidthAdapter.scala 45:11]
  assign auto_in_ready = auto_out_ready; // @[LazyModule.scala 173:31]
  assign auto_out_valid = _T_5 & auto_in_valid; // @[LazyModule.scala 173:49]
  assign auto_out_bits_data = {_T_18,_T}; // @[LazyModule.scala 173:49]
  assign auto_out_bits_last = _T_39 != 4'h0; // @[LazyModule.scala 173:49]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T = _RAND_0[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  _T_1 = _RAND_1[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_2 = _RAND_2[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  _T_3 = _RAND_3[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T_20 = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_21 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  _T_22 = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  _T_23 = _RAND_7[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_44 = _RAND_8[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  _T_64 = _RAND_9[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  _T_84 = _RAND_10[1:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (_T_10) begin
      _T <= auto_in_bits_data;
    end
    if (_T_13) begin
      _T_1 <= auto_in_bits_data;
    end
    if (_T_16) begin
      _T_2 <= auto_in_bits_data;
    end
    if (reset) begin
      _T_3 <= 2'h0;
    end else begin
      _T_3 <= _GEN_0[1:0];
    end
    if (_T_30) begin
      _T_20 <= auto_in_bits_last;
    end
    if (_T_33) begin
      _T_21 <= auto_in_bits_last;
    end
    if (_T_36) begin
      _T_22 <= auto_in_bits_last;
    end
    if (reset) begin
      _T_23 <= 2'h0;
    end else begin
      _T_23 <= _GEN_4[1:0];
    end
    if (reset) begin
      _T_44 <= 2'h0;
    end else begin
      _T_44 <= _GEN_8[1:0];
    end
    if (reset) begin
      _T_64 <= 2'h0;
    end else begin
      _T_64 <= _GEN_12[1:0];
    end
    if (reset) begin
      _T_84 <= 2'h0;
    end else begin
      _T_84 <= _GEN_16[1:0];
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_104) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:42 assert(ov0 === ov1)\n"); // @[AXI4StreamWidthAdapter.scala 42:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_104) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 42:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_108) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:43 assert(ov0 === ov2)\n"); // @[AXI4StreamWidthAdapter.scala 43:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_108) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 43:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_112) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:44 assert(ov0 === ov3)\n"); // @[AXI4StreamWidthAdapter.scala 44:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_112) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 44:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_116) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:45 assert(ov0 === ov4)\n"); // @[AXI4StreamWidthAdapter.scala 45:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_116) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 45:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module BundleBridgeToAXI4StreamWidthAdapter4to1(
  output       auto_in_ready,
  input        auto_in_valid,
  input  [7:0] auto_in_bits_data,
  input        auto_in_bits_last,
  input        auto_out_ready,
  output       auto_out_valid,
  output [7:0] auto_out_bits_data,
  output       auto_out_bits_last
);
  assign auto_in_ready = auto_out_ready; // @[LazyModule.scala 173:31]
  assign auto_out_valid = auto_in_valid; // @[LazyModule.scala 173:49]
  assign auto_out_bits_data = auto_in_bits_data; // @[LazyModule.scala 173:49]
  assign auto_out_bits_last = auto_in_bits_last; // @[LazyModule.scala 173:49]
endmodule
module AXI4StreamToBundleBridgeWidthAdapter4to1(
  output        auto_in_ready,
  input         auto_in_valid,
  input  [31:0] auto_in_bits_data,
  input         auto_in_bits_last,
  input         auto_out_ready,
  output        auto_out_valid,
  output [31:0] auto_out_bits_data,
  output        auto_out_bits_last
);
  assign auto_in_ready = auto_out_ready; // @[LazyModule.scala 173:31]
  assign auto_out_valid = auto_in_valid; // @[LazyModule.scala 173:49]
  assign auto_out_bits_data = auto_in_bits_data; // @[LazyModule.scala 173:49]
  assign auto_out_bits_last = auto_in_bits_last; // @[LazyModule.scala 173:49]
endmodule
module AXI4StreamWidthAdapter4to1(
  input         clock,
  input         reset,
  output        in_0_ready,
  input         in_0_valid,
  input  [7:0]  in_0_bits_data,
  input         in_0_bits_last,
  input         out_0_ready,
  output        out_0_valid,
  output [31:0] out_0_bits_data,
  output        out_0_bits_last
);
  wire  voidModuleIn_auto_out_out_ready; // @[widthAdapter.scala 42:32]
  wire  voidModuleIn_auto_out_out_valid; // @[widthAdapter.scala 42:32]
  wire [7:0] voidModuleIn_auto_out_out_bits_data; // @[widthAdapter.scala 42:32]
  wire  voidModuleIn_auto_out_out_bits_last; // @[widthAdapter.scala 42:32]
  wire  voidModuleIn_auto_in_in_ready; // @[widthAdapter.scala 42:32]
  wire  voidModuleIn_auto_in_in_valid; // @[widthAdapter.scala 42:32]
  wire [7:0] voidModuleIn_auto_in_in_bits_data; // @[widthAdapter.scala 42:32]
  wire  voidModuleIn_auto_in_in_bits_last; // @[widthAdapter.scala 42:32]
  wire  voidModuleOut_auto_out_out_ready; // @[widthAdapter.scala 43:33]
  wire  voidModuleOut_auto_out_out_valid; // @[widthAdapter.scala 43:33]
  wire [31:0] voidModuleOut_auto_out_out_bits_data; // @[widthAdapter.scala 43:33]
  wire  voidModuleOut_auto_out_out_bits_last; // @[widthAdapter.scala 43:33]
  wire  voidModuleOut_auto_in_in_ready; // @[widthAdapter.scala 43:33]
  wire  voidModuleOut_auto_in_in_valid; // @[widthAdapter.scala 43:33]
  wire [31:0] voidModuleOut_auto_in_in_bits_data; // @[widthAdapter.scala 43:33]
  wire  voidModuleOut_auto_in_in_bits_last; // @[widthAdapter.scala 43:33]
  wire  widthAdapter_clock; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_reset; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_in_ready; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_in_valid; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire [7:0] widthAdapter_auto_in_bits_data; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_in_bits_last; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_out_ready; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_out_valid; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire [31:0] widthAdapter_auto_out_bits_data; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_out_bits_last; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  converter_auto_in_ready; // @[Nodes.scala 201:31]
  wire  converter_auto_in_valid; // @[Nodes.scala 201:31]
  wire [7:0] converter_auto_in_bits_data; // @[Nodes.scala 201:31]
  wire  converter_auto_in_bits_last; // @[Nodes.scala 201:31]
  wire  converter_auto_out_ready; // @[Nodes.scala 201:31]
  wire  converter_auto_out_valid; // @[Nodes.scala 201:31]
  wire [7:0] converter_auto_out_bits_data; // @[Nodes.scala 201:31]
  wire  converter_auto_out_bits_last; // @[Nodes.scala 201:31]
  wire  converter_1_auto_in_ready; // @[Nodes.scala 165:31]
  wire  converter_1_auto_in_valid; // @[Nodes.scala 165:31]
  wire [31:0] converter_1_auto_in_bits_data; // @[Nodes.scala 165:31]
  wire  converter_1_auto_in_bits_last; // @[Nodes.scala 165:31]
  wire  converter_1_auto_out_ready; // @[Nodes.scala 165:31]
  wire  converter_1_auto_out_valid; // @[Nodes.scala 165:31]
  wire [31:0] converter_1_auto_out_bits_data; // @[Nodes.scala 165:31]
  wire  converter_1_auto_out_bits_last; // @[Nodes.scala 165:31]
  VoidModuleWidthAdapter4to1 voidModuleIn ( // @[widthAdapter.scala 42:32]
    .auto_out_out_ready(voidModuleIn_auto_out_out_ready),
    .auto_out_out_valid(voidModuleIn_auto_out_out_valid),
    .auto_out_out_bits_data(voidModuleIn_auto_out_out_bits_data),
    .auto_out_out_bits_last(voidModuleIn_auto_out_out_bits_last),
    .auto_in_in_ready(voidModuleIn_auto_in_in_ready),
    .auto_in_in_valid(voidModuleIn_auto_in_in_valid),
    .auto_in_in_bits_data(voidModuleIn_auto_in_in_bits_data),
    .auto_in_in_bits_last(voidModuleIn_auto_in_in_bits_last)
  );
  VoidModuleWidthAdapter4to1_1 voidModuleOut ( // @[widthAdapter.scala 43:33]
    .auto_out_out_ready(voidModuleOut_auto_out_out_ready),
    .auto_out_out_valid(voidModuleOut_auto_out_out_valid),
    .auto_out_out_bits_data(voidModuleOut_auto_out_out_bits_data),
    .auto_out_out_bits_last(voidModuleOut_auto_out_out_bits_last),
    .auto_in_in_ready(voidModuleOut_auto_in_in_ready),
    .auto_in_in_valid(voidModuleOut_auto_in_in_valid),
    .auto_in_in_bits_data(voidModuleOut_auto_in_in_bits_data),
    .auto_in_in_bits_last(voidModuleOut_auto_in_in_bits_last)
  );
  AXI4StreamWidthAdapater_4_to_1 widthAdapter ( // @[AXI4StreamWidthAdapter.scala 82:34]
    .clock(widthAdapter_clock),
    .reset(widthAdapter_reset),
    .auto_in_ready(widthAdapter_auto_in_ready),
    .auto_in_valid(widthAdapter_auto_in_valid),
    .auto_in_bits_data(widthAdapter_auto_in_bits_data),
    .auto_in_bits_last(widthAdapter_auto_in_bits_last),
    .auto_out_ready(widthAdapter_auto_out_ready),
    .auto_out_valid(widthAdapter_auto_out_valid),
    .auto_out_bits_data(widthAdapter_auto_out_bits_data),
    .auto_out_bits_last(widthAdapter_auto_out_bits_last)
  );
  BundleBridgeToAXI4StreamWidthAdapter4to1 converter ( // @[Nodes.scala 201:31]
    .auto_in_ready(converter_auto_in_ready),
    .auto_in_valid(converter_auto_in_valid),
    .auto_in_bits_data(converter_auto_in_bits_data),
    .auto_in_bits_last(converter_auto_in_bits_last),
    .auto_out_ready(converter_auto_out_ready),
    .auto_out_valid(converter_auto_out_valid),
    .auto_out_bits_data(converter_auto_out_bits_data),
    .auto_out_bits_last(converter_auto_out_bits_last)
  );
  AXI4StreamToBundleBridgeWidthAdapter4to1 converter_1 ( // @[Nodes.scala 165:31]
    .auto_in_ready(converter_1_auto_in_ready),
    .auto_in_valid(converter_1_auto_in_valid),
    .auto_in_bits_data(converter_1_auto_in_bits_data),
    .auto_in_bits_last(converter_1_auto_in_bits_last),
    .auto_out_ready(converter_1_auto_out_ready),
    .auto_out_valid(converter_1_auto_out_valid),
    .auto_out_bits_data(converter_1_auto_out_bits_data),
    .auto_out_bits_last(converter_1_auto_out_bits_last)
  );
  assign in_0_ready = converter_auto_in_ready; // @[Nodes.scala 624:60]
  assign out_0_valid = converter_1_auto_out_valid; // @[Nodes.scala 649:56]
  assign out_0_bits_data = converter_1_auto_out_bits_data; // @[Nodes.scala 649:56]
  assign out_0_bits_last = converter_1_auto_out_bits_last; // @[Nodes.scala 649:56]
  assign voidModuleIn_auto_out_out_ready = widthAdapter_auto_in_ready; // @[LazyModule.scala 167:57]
  assign voidModuleIn_auto_in_in_valid = converter_auto_out_valid; // @[LazyModule.scala 167:31]
  assign voidModuleIn_auto_in_in_bits_data = converter_auto_out_bits_data; // @[LazyModule.scala 167:31]
  assign voidModuleIn_auto_in_in_bits_last = converter_auto_out_bits_last; // @[LazyModule.scala 167:31]
  assign voidModuleOut_auto_out_out_ready = converter_1_auto_in_ready; // @[LazyModule.scala 167:57]
  assign voidModuleOut_auto_in_in_valid = widthAdapter_auto_out_valid; // @[LazyModule.scala 167:31]
  assign voidModuleOut_auto_in_in_bits_data = widthAdapter_auto_out_bits_data; // @[LazyModule.scala 167:31]
  assign voidModuleOut_auto_in_in_bits_last = widthAdapter_auto_out_bits_last; // @[LazyModule.scala 167:31]
  assign widthAdapter_clock = clock;
  assign widthAdapter_reset = reset;
  assign widthAdapter_auto_in_valid = voidModuleIn_auto_out_out_valid; // @[LazyModule.scala 167:57]
  assign widthAdapter_auto_in_bits_data = voidModuleIn_auto_out_out_bits_data; // @[LazyModule.scala 167:57]
  assign widthAdapter_auto_in_bits_last = voidModuleIn_auto_out_out_bits_last; // @[LazyModule.scala 167:57]
  assign widthAdapter_auto_out_ready = voidModuleOut_auto_in_in_ready; // @[LazyModule.scala 167:31]
  assign converter_auto_in_valid = in_0_valid; // @[LazyModule.scala 167:57]
  assign converter_auto_in_bits_data = in_0_bits_data; // @[LazyModule.scala 167:57]
  assign converter_auto_in_bits_last = in_0_bits_last; // @[LazyModule.scala 167:57]
  assign converter_auto_out_ready = voidModuleIn_auto_in_in_ready; // @[LazyModule.scala 167:31]
  assign converter_1_auto_in_valid = voidModuleOut_auto_out_out_valid; // @[LazyModule.scala 167:57]
  assign converter_1_auto_in_bits_data = voidModuleOut_auto_out_out_bits_data; // @[LazyModule.scala 167:57]
  assign converter_1_auto_in_bits_last = voidModuleOut_auto_out_out_bits_last; // @[LazyModule.scala 167:57]
  assign converter_1_auto_out_ready = out_0_ready; // @[LazyModule.scala 167:31]
endmodule
