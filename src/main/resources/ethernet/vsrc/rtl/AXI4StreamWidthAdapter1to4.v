module VoidModuleWidthAdapter1to4(
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
module VoidModuleWidthAdapter1to4_1(
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
module AXI4StreamWidthAdapater_1_to_4(
  input         clock,
  input         reset,
  output        auto_in_ready,
  input         auto_in_valid,
  input  [31:0] auto_in_bits_data,
  input         auto_in_bits_last,
  input         auto_out_ready,
  output        auto_out_valid,
  output [7:0]  auto_out_bits_data,
  output        auto_out_bits_last
);
  reg [1:0] _T_5; // @[AXI4StreamWidthAdapter.scala 158:22]
  reg [31:0] _RAND_0;
  wire  _T_6; // @[AXI4StreamWidthAdapter.scala 159:14]
  wire  _T_7; // @[AXI4StreamWidthAdapter.scala 159:38]
  wire [2:0] _T_8; // @[AXI4StreamWidthAdapter.scala 159:60]
  wire [2:0] _T_9; // @[AXI4StreamWidthAdapter.scala 159:33]
  wire [2:0] _GEN_0; // @[AXI4StreamWidthAdapter.scala 159:21]
  wire  ir0; // @[AXI4StreamWidthAdapter.scala 163:34]
  reg [1:0] _T_11; // @[AXI4StreamWidthAdapter.scala 167:22]
  reg [31:0] _RAND_1;
  wire  _T_13; // @[AXI4StreamWidthAdapter.scala 168:38]
  wire [2:0] _T_14; // @[AXI4StreamWidthAdapter.scala 168:60]
  wire [2:0] _T_15; // @[AXI4StreamWidthAdapter.scala 168:33]
  wire [2:0] _GEN_1; // @[AXI4StreamWidthAdapter.scala 168:21]
  wire  ir1; // @[AXI4StreamWidthAdapter.scala 170:60]
  reg [1:0] _T_20; // @[AXI4StreamWidthAdapter.scala 158:22]
  reg [31:0] _RAND_2;
  wire  _T_22; // @[AXI4StreamWidthAdapter.scala 159:38]
  wire [2:0] _T_23; // @[AXI4StreamWidthAdapter.scala 159:60]
  wire [2:0] _T_24; // @[AXI4StreamWidthAdapter.scala 159:33]
  wire [2:0] _GEN_2; // @[AXI4StreamWidthAdapter.scala 159:21]
  wire  ir2; // @[AXI4StreamWidthAdapter.scala 163:34]
  reg [1:0] _T_27; // @[AXI4StreamWidthAdapter.scala 158:22]
  reg [31:0] _RAND_3;
  wire  _T_29; // @[AXI4StreamWidthAdapter.scala 159:38]
  wire [2:0] _T_30; // @[AXI4StreamWidthAdapter.scala 159:60]
  wire [2:0] _T_31; // @[AXI4StreamWidthAdapter.scala 159:33]
  wire [2:0] _GEN_3; // @[AXI4StreamWidthAdapter.scala 159:21]
  wire  ir3; // @[AXI4StreamWidthAdapter.scala 163:34]
  reg [1:0] _T_34; // @[AXI4StreamWidthAdapter.scala 158:22]
  reg [31:0] _RAND_4;
  wire  _T_36; // @[AXI4StreamWidthAdapter.scala 159:38]
  wire [2:0] _T_37; // @[AXI4StreamWidthAdapter.scala 159:60]
  wire [2:0] _T_38; // @[AXI4StreamWidthAdapter.scala 159:33]
  wire [2:0] _GEN_4; // @[AXI4StreamWidthAdapter.scala 159:21]
  wire  ir4; // @[AXI4StreamWidthAdapter.scala 163:34]
  wire  _T_56; // @[AXI4StreamWidthAdapter.scala 46:16]
  wire  _T_58; // @[AXI4StreamWidthAdapter.scala 46:11]
  wire  _T_59; // @[AXI4StreamWidthAdapter.scala 46:11]
  wire  _T_60; // @[AXI4StreamWidthAdapter.scala 47:16]
  wire  _T_62; // @[AXI4StreamWidthAdapter.scala 47:11]
  wire  _T_63; // @[AXI4StreamWidthAdapter.scala 47:11]
  wire  _T_64; // @[AXI4StreamWidthAdapter.scala 48:16]
  wire  _T_66; // @[AXI4StreamWidthAdapter.scala 48:11]
  wire  _T_67; // @[AXI4StreamWidthAdapter.scala 48:11]
  wire  _T_68; // @[AXI4StreamWidthAdapter.scala 49:16]
  wire  _T_70; // @[AXI4StreamWidthAdapter.scala 49:11]
  wire  _T_71; // @[AXI4StreamWidthAdapter.scala 49:11]
  wire [7:0] _GEN_6; // @[AXI4StreamWidthAdapter.scala 54:19]
  wire [7:0] _GEN_7; // @[AXI4StreamWidthAdapter.scala 54:19]
  assign _T_6 = auto_in_valid & auto_out_ready; // @[AXI4StreamWidthAdapter.scala 159:14]
  assign _T_7 = _T_5 == 2'h3; // @[AXI4StreamWidthAdapter.scala 159:38]
  assign _T_8 = _T_5 + 2'h1; // @[AXI4StreamWidthAdapter.scala 159:60]
  assign _T_9 = _T_7 ? 3'h0 : _T_8; // @[AXI4StreamWidthAdapter.scala 159:33]
  assign _GEN_0 = _T_6 ? _T_9 : {{1'd0}, _T_5}; // @[AXI4StreamWidthAdapter.scala 159:21]
  assign ir0 = _T_7 & auto_out_ready; // @[AXI4StreamWidthAdapter.scala 163:34]
  assign _T_13 = _T_11 == 2'h3; // @[AXI4StreamWidthAdapter.scala 168:38]
  assign _T_14 = _T_11 + 2'h1; // @[AXI4StreamWidthAdapter.scala 168:60]
  assign _T_15 = _T_13 ? 3'h0 : _T_14; // @[AXI4StreamWidthAdapter.scala 168:33]
  assign _GEN_1 = _T_6 ? _T_15 : {{1'd0}, _T_11}; // @[AXI4StreamWidthAdapter.scala 168:21]
  assign ir1 = _T_13 & auto_out_ready; // @[AXI4StreamWidthAdapter.scala 170:60]
  assign _T_22 = _T_20 == 2'h3; // @[AXI4StreamWidthAdapter.scala 159:38]
  assign _T_23 = _T_20 + 2'h1; // @[AXI4StreamWidthAdapter.scala 159:60]
  assign _T_24 = _T_22 ? 3'h0 : _T_23; // @[AXI4StreamWidthAdapter.scala 159:33]
  assign _GEN_2 = _T_6 ? _T_24 : {{1'd0}, _T_20}; // @[AXI4StreamWidthAdapter.scala 159:21]
  assign ir2 = _T_22 & auto_out_ready; // @[AXI4StreamWidthAdapter.scala 163:34]
  assign _T_29 = _T_27 == 2'h3; // @[AXI4StreamWidthAdapter.scala 159:38]
  assign _T_30 = _T_27 + 2'h1; // @[AXI4StreamWidthAdapter.scala 159:60]
  assign _T_31 = _T_29 ? 3'h0 : _T_30; // @[AXI4StreamWidthAdapter.scala 159:33]
  assign _GEN_3 = _T_6 ? _T_31 : {{1'd0}, _T_27}; // @[AXI4StreamWidthAdapter.scala 159:21]
  assign ir3 = _T_29 & auto_out_ready; // @[AXI4StreamWidthAdapter.scala 163:34]
  assign _T_36 = _T_34 == 2'h3; // @[AXI4StreamWidthAdapter.scala 159:38]
  assign _T_37 = _T_34 + 2'h1; // @[AXI4StreamWidthAdapter.scala 159:60]
  assign _T_38 = _T_36 ? 3'h0 : _T_37; // @[AXI4StreamWidthAdapter.scala 159:33]
  assign _GEN_4 = _T_6 ? _T_38 : {{1'd0}, _T_34}; // @[AXI4StreamWidthAdapter.scala 159:21]
  assign ir4 = _T_36 & auto_out_ready; // @[AXI4StreamWidthAdapter.scala 163:34]
  assign _T_56 = ir0 == ir1; // @[AXI4StreamWidthAdapter.scala 46:16]
  assign _T_58 = _T_56 | reset; // @[AXI4StreamWidthAdapter.scala 46:11]
  assign _T_59 = ~_T_58; // @[AXI4StreamWidthAdapter.scala 46:11]
  assign _T_60 = ir0 == ir2; // @[AXI4StreamWidthAdapter.scala 47:16]
  assign _T_62 = _T_60 | reset; // @[AXI4StreamWidthAdapter.scala 47:11]
  assign _T_63 = ~_T_62; // @[AXI4StreamWidthAdapter.scala 47:11]
  assign _T_64 = ir0 == ir3; // @[AXI4StreamWidthAdapter.scala 48:16]
  assign _T_66 = _T_64 | reset; // @[AXI4StreamWidthAdapter.scala 48:11]
  assign _T_67 = ~_T_66; // @[AXI4StreamWidthAdapter.scala 48:11]
  assign _T_68 = ir0 == ir4; // @[AXI4StreamWidthAdapter.scala 49:16]
  assign _T_70 = _T_68 | reset; // @[AXI4StreamWidthAdapter.scala 49:11]
  assign _T_71 = ~_T_70; // @[AXI4StreamWidthAdapter.scala 49:11]
  assign _GEN_6 = 2'h1 == _T_5 ? auto_in_bits_data[15:8] : auto_in_bits_data[7:0]; // @[AXI4StreamWidthAdapter.scala 54:19]
  assign _GEN_7 = 2'h2 == _T_5 ? auto_in_bits_data[23:16] : _GEN_6; // @[AXI4StreamWidthAdapter.scala 54:19]
  assign auto_in_ready = _T_7 & auto_out_ready; // @[LazyModule.scala 173:31]
  assign auto_out_valid = auto_in_valid; // @[LazyModule.scala 173:49]
  assign auto_out_bits_data = 2'h3 == _T_5 ? auto_in_bits_data[31:24] : _GEN_7; // @[LazyModule.scala 173:49]
  assign auto_out_bits_last = auto_in_bits_last & _T_13; // @[LazyModule.scala 173:49]
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
  _T_5 = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  _T_11 = _RAND_1[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_20 = _RAND_2[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  _T_27 = _RAND_3[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T_34 = _RAND_4[1:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      _T_5 <= 2'h0;
    end else begin
      _T_5 <= _GEN_0[1:0];
    end
    if (reset) begin
      _T_11 <= 2'h0;
    end else begin
      _T_11 <= _GEN_1[1:0];
    end
    if (reset) begin
      _T_20 <= 2'h0;
    end else begin
      _T_20 <= _GEN_2[1:0];
    end
    if (reset) begin
      _T_27 <= 2'h0;
    end else begin
      _T_27 <= _GEN_3[1:0];
    end
    if (reset) begin
      _T_34 <= 2'h0;
    end else begin
      _T_34 <= _GEN_4[1:0];
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_59) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:46 assert(ir0 === ir1)\n"); // @[AXI4StreamWidthAdapter.scala 46:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_59) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 46:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_63) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:47 assert(ir0 === ir2)\n"); // @[AXI4StreamWidthAdapter.scala 47:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_63) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 47:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_67) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:48 assert(ir0 === ir3)\n"); // @[AXI4StreamWidthAdapter.scala 48:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_67) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 48:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_71) begin
          $fwrite(32'h80000002,"Assertion failed\n    at AXI4StreamWidthAdapter.scala:49 assert(ir0 === ir4)\n"); // @[AXI4StreamWidthAdapter.scala 49:11]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef STOP_COND
      if (`STOP_COND) begin
    `endif
        if (_T_71) begin
          $fatal; // @[AXI4StreamWidthAdapter.scala 49:11]
        end
    `ifdef STOP_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module BundleBridgeToAXI4StreamWidthAdapter1to4(
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
module AXI4StreamToBundleBridgeWidthAdapter1to4(
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
module AXI4StreamWidthAdapter1to4(
  input         clock,
  input         reset,
  output        in_0_ready,
  input         in_0_valid,
  input  [31:0] in_0_bits_data,
  input         in_0_bits_last,
  input         out_0_ready,
  output        out_0_valid,
  output [7:0]  out_0_bits_data,
  output        out_0_bits_last
);
  wire  voidModuleIn_auto_out_out_ready; // @[widthAdapter.scala 62:32]
  wire  voidModuleIn_auto_out_out_valid; // @[widthAdapter.scala 62:32]
  wire [31:0] voidModuleIn_auto_out_out_bits_data; // @[widthAdapter.scala 62:32]
  wire  voidModuleIn_auto_out_out_bits_last; // @[widthAdapter.scala 62:32]
  wire  voidModuleIn_auto_in_in_ready; // @[widthAdapter.scala 62:32]
  wire  voidModuleIn_auto_in_in_valid; // @[widthAdapter.scala 62:32]
  wire [31:0] voidModuleIn_auto_in_in_bits_data; // @[widthAdapter.scala 62:32]
  wire  voidModuleIn_auto_in_in_bits_last; // @[widthAdapter.scala 62:32]
  wire  voidModuleOut_auto_out_out_ready; // @[widthAdapter.scala 63:33]
  wire  voidModuleOut_auto_out_out_valid; // @[widthAdapter.scala 63:33]
  wire [7:0] voidModuleOut_auto_out_out_bits_data; // @[widthAdapter.scala 63:33]
  wire  voidModuleOut_auto_out_out_bits_last; // @[widthAdapter.scala 63:33]
  wire  voidModuleOut_auto_in_in_ready; // @[widthAdapter.scala 63:33]
  wire  voidModuleOut_auto_in_in_valid; // @[widthAdapter.scala 63:33]
  wire [7:0] voidModuleOut_auto_in_in_bits_data; // @[widthAdapter.scala 63:33]
  wire  voidModuleOut_auto_in_in_bits_last; // @[widthAdapter.scala 63:33]
  wire  widthAdapter_clock; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_reset; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_in_ready; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_in_valid; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire [31:0] widthAdapter_auto_in_bits_data; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_in_bits_last; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_out_ready; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_out_valid; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire [7:0] widthAdapter_auto_out_bits_data; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  widthAdapter_auto_out_bits_last; // @[AXI4StreamWidthAdapter.scala 82:34]
  wire  converter_auto_in_ready; // @[Nodes.scala 201:31]
  wire  converter_auto_in_valid; // @[Nodes.scala 201:31]
  wire [31:0] converter_auto_in_bits_data; // @[Nodes.scala 201:31]
  wire  converter_auto_in_bits_last; // @[Nodes.scala 201:31]
  wire  converter_auto_out_ready; // @[Nodes.scala 201:31]
  wire  converter_auto_out_valid; // @[Nodes.scala 201:31]
  wire [31:0] converter_auto_out_bits_data; // @[Nodes.scala 201:31]
  wire  converter_auto_out_bits_last; // @[Nodes.scala 201:31]
  wire  converter_1_auto_in_ready; // @[Nodes.scala 165:31]
  wire  converter_1_auto_in_valid; // @[Nodes.scala 165:31]
  wire [7:0] converter_1_auto_in_bits_data; // @[Nodes.scala 165:31]
  wire  converter_1_auto_in_bits_last; // @[Nodes.scala 165:31]
  wire  converter_1_auto_out_ready; // @[Nodes.scala 165:31]
  wire  converter_1_auto_out_valid; // @[Nodes.scala 165:31]
  wire [7:0] converter_1_auto_out_bits_data; // @[Nodes.scala 165:31]
  wire  converter_1_auto_out_bits_last; // @[Nodes.scala 165:31]
  VoidModuleWidthAdapter1to4 voidModuleIn ( // @[widthAdapter.scala 62:32]
    .auto_out_out_ready(voidModuleIn_auto_out_out_ready),
    .auto_out_out_valid(voidModuleIn_auto_out_out_valid),
    .auto_out_out_bits_data(voidModuleIn_auto_out_out_bits_data),
    .auto_out_out_bits_last(voidModuleIn_auto_out_out_bits_last),
    .auto_in_in_ready(voidModuleIn_auto_in_in_ready),
    .auto_in_in_valid(voidModuleIn_auto_in_in_valid),
    .auto_in_in_bits_data(voidModuleIn_auto_in_in_bits_data),
    .auto_in_in_bits_last(voidModuleIn_auto_in_in_bits_last)
  );
  VoidModuleWidthAdapter1to4_1 voidModuleOut ( // @[widthAdapter.scala 63:33]
    .auto_out_out_ready(voidModuleOut_auto_out_out_ready),
    .auto_out_out_valid(voidModuleOut_auto_out_out_valid),
    .auto_out_out_bits_data(voidModuleOut_auto_out_out_bits_data),
    .auto_out_out_bits_last(voidModuleOut_auto_out_out_bits_last),
    .auto_in_in_ready(voidModuleOut_auto_in_in_ready),
    .auto_in_in_valid(voidModuleOut_auto_in_in_valid),
    .auto_in_in_bits_data(voidModuleOut_auto_in_in_bits_data),
    .auto_in_in_bits_last(voidModuleOut_auto_in_in_bits_last)
  );
  AXI4StreamWidthAdapater_1_to_4 widthAdapter ( // @[AXI4StreamWidthAdapter.scala 82:34]
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
  BundleBridgeToAXI4StreamWidthAdapter1to4 converter ( // @[Nodes.scala 201:31]
    .auto_in_ready(converter_auto_in_ready),
    .auto_in_valid(converter_auto_in_valid),
    .auto_in_bits_data(converter_auto_in_bits_data),
    .auto_in_bits_last(converter_auto_in_bits_last),
    .auto_out_ready(converter_auto_out_ready),
    .auto_out_valid(converter_auto_out_valid),
    .auto_out_bits_data(converter_auto_out_bits_data),
    .auto_out_bits_last(converter_auto_out_bits_last)
  );
  AXI4StreamToBundleBridgeWidthAdapter1to4 converter_1 ( // @[Nodes.scala 165:31]
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
