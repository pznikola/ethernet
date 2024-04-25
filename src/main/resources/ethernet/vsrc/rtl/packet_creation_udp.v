`timescale 1ns / 1ps

module packet_creation_udp (
    input         clk                ,
    input         reset              ,
    input  [ 7:0] slave_data         ,
    input         slave_valid        ,
    input         slave_last         ,
    output        slave_ready        ,
    output [ 7:0] master_data        ,
    output        master_valid       ,
    input         master_ready       ,
    output        master_last        ,
    input  [ 7:0] tx_streaming_data  ,
    input         tx_streaming_valid ,
    input         tx_streaming_last  ,
    output        tx_streaming_ready ,
    output [ 7:0] rx_streaming_data  ,
    output        rx_streaming_valid ,
    output        rx_streaming_last  ,
    input         rx_streaming_ready ,

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

    reg [15:0] PACKET_SIZE;
    reg [47:0] SRC_MAC;
    reg [31:0] SRC_IP;
    reg [15:0] SRC_PORT;
    reg [47:0] DST_MAC;
    reg [31:0] DST_IP;
    reg [15:0] DST_PORT;
    reg [15:0] DST_PORT2;

    reg [15:0] MAC_LENGTH;
    reg [15:0] UDP_LENGTH;

    reg [47:0] dest_mac_arp;
    reg [31:0] dest_ip_arp;

    reg [5:0] reply_arp_counter;
    reg [5:0] rx_arp_counter;
    reg [5:0] rx_arp_counter_dl;

    wire [7:0] internal_data_rx;
    wire internal_valid_rx;
    wire internal_last_rx;
    wire internal_ready_rx;

    wire [7:0] internal_data_reply;
    wire internal_valid_reply;
    wire internal_last_reply;
    wire internal_ready_reply;

    reg  [7:0] reply_tx_data;
    reg  reply_tx_valid;
    reg  reply_tx_last;

    wire rx_arp_started0, rx_arp_started1;
    reg  rx_arp_started_reg;
    reg  rx_arp_started_reg0, rx_arp_started_reg1,
         rx_arp_started_reg2, rx_arp_started_reg3,
         rx_arp_started_reg4, rx_arp_started_reg5;
    reg  error_rx_arp;

    reg  reply_arp_requested;

    reg  [47:0] dest_mac_udp;
    reg  [31:0] dest_ip_udp;

    reg  [15:0] tx_udp_counter;

    reg  [15:0] udp_payload_length, udp_total_length, udp_total_length_divided, tx_packet_length;

    reg  [15:0] header_checksum;
    reg  [31:0] header_checksum_temp1, header_checksum_temp2;

    wire [7:0] stream_data_internal;
    wire stream_valid_internal;
    wire stream_ready_internal;
    wire stream_last_internal;

    reg  streaming_started;

    wire tx_streaming_ready_internal;

    reg  [15:0] rx_udp_counter;
    reg  error_rx_udp;
    reg  [15:0] rx_udp_length;
    reg  [15:0] rx_udp_packet_size;
    reg  [15:0] rx_udp_total_length_shifted;
    wire rx_udp_started0, rx_udp_started1, rx_udp_started2;
    reg  rx_udp_started_reg0, rx_udp_started_reg1,
         rx_udp_started_reg2, rx_udp_started_reg3,
         rx_udp_started_reg4, rx_udp_started_reg5;

    reg  [15:0] packet_counter;
    reg  port_indicator;

    assign slave_ready = internal_ready_rx;
    assign internal_valid_rx = slave_valid;
    assign internal_data_rx = slave_data;
    assign internal_last_rx = slave_last;

    always @(posedge clk) begin
        if (reset) begin
            SRC_MAC     <= 1'b0;
            SRC_IP      <= 1'b0;
            SRC_PORT    <= 1'b0;
            DST_MAC     <= 1'b0;
            DST_IP      <= 1'b0;
            DST_PORT    <= 1'b0;
            DST_PORT2   <= 1'b0;
            PACKET_SIZE <= 1'b0;
            MAC_LENGTH  <= 1'b0;
            UDP_LENGTH  <= 1'b0;
        end
        else begin
            SRC_MAC     <= srcMac;
            SRC_IP      <= srcIp;
            SRC_PORT    <= srcPort;
            DST_MAC     <= dstMac;
            DST_IP      <= dstIp;
            DST_PORT    <= dstPort;
            DST_PORT2   <= dstPort2;
            PACKET_SIZE <= packetSize;
            MAC_LENGTH  <= PACKET_SIZE + 16'd28;
            UDP_LENGTH  <= PACKET_SIZE + 16'd8;
        end
    end

    /*************************************** ARP ****************************************************/
    always @(posedge clk) begin
        if(reset) begin
            rx_arp_started_reg0 <= 1'b0;
            rx_arp_started_reg1 <= 1'b0;
            rx_arp_started_reg2 <= 1'b0;
            rx_arp_started_reg3 <= 1'b0;
            rx_arp_started_reg4 <= 1'b0;
            rx_arp_started_reg5 <= 1'b0;
        end
        else if(internal_valid_rx && (rx_arp_counter == 6'd0) && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[47:40])))
            rx_arp_started_reg0 <= 1'b1;
        else if(internal_valid_rx && (rx_arp_counter == 6'd1) && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[39:32])))
            rx_arp_started_reg1 <= 1'b1;
        else if(internal_valid_rx && (rx_arp_counter == 6'd2) && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[31:24])))
            rx_arp_started_reg2 <= 1'b1;
        else if(internal_valid_rx && (rx_arp_counter == 6'd3) && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[23:16])))
            rx_arp_started_reg3 <= 1'b1;
        else if(internal_valid_rx && (rx_arp_counter == 6'd4) && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[15:8])))
            rx_arp_started_reg4 <= 1'b1;
        else if(internal_valid_rx && (rx_arp_counter == 6'd5) && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[7:0])))
            rx_arp_started_reg5 <= 1'b1;
        else if((rx_arp_counter == 6'd41) && internal_valid_rx) begin
            rx_arp_started_reg0 <= 1'b0;
            rx_arp_started_reg1 <= 1'b0;
            rx_arp_started_reg2 <= 1'b0;
            rx_arp_started_reg3 <= 1'b0;
            rx_arp_started_reg4 <= 1'b0;
            rx_arp_started_reg5 <= 1'b0;
        end
        else if(error_rx_arp) begin
            rx_arp_started_reg0 <= 1'b0;
            rx_arp_started_reg1 <= 1'b0;
            rx_arp_started_reg2 <= 1'b0;
            rx_arp_started_reg3 <= 1'b0;
            rx_arp_started_reg4 <= 1'b0;
            rx_arp_started_reg5 <= 1'b0;
        end
    end

    assign rx_arp_started0 = rx_arp_started_reg0 && rx_arp_started_reg1 && rx_arp_started_reg2 && rx_arp_started_reg3 && rx_arp_started_reg4 && rx_arp_started_reg5;
    assign rx_arp_started1 = internal_valid_rx && (rx_arp_counter == 6'd0) && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[47:40]));

    always @(posedge clk) begin
        if(reset) begin
            rx_arp_counter <= 1'b0;
            dest_mac_arp <= 1'b0;
            dest_ip_arp <= 1'b0;
            error_rx_arp <= 1'b0;
        end
        else begin
            if (internal_valid_rx && (rx_arp_started_reg0 || rx_arp_started1) && (rx_arp_counter < 6'd41))
                rx_arp_counter <= rx_arp_counter + 1'b1;
            else if (((rx_arp_counter == 6'd41) && internal_valid_rx) || error_rx_arp || internal_last_rx)
                rx_arp_counter <= 1'b0;

            if(rx_arp_counter == 22)
                dest_mac_arp[47:40] <= internal_data_rx;
            else if(rx_arp_counter == 23)
                dest_mac_arp[39:32] <= internal_data_rx;
            else if(rx_arp_counter == 24)
                dest_mac_arp[31:24] <= internal_data_rx;
            else if(rx_arp_counter == 25)
                dest_mac_arp[23:16] <= internal_data_rx;
            else if(rx_arp_counter == 26)
                dest_mac_arp[15:8] <= internal_data_rx;
            else if(rx_arp_counter == 27)
                dest_mac_arp[7:0] <= internal_data_rx;
            else if(rx_arp_counter == 28)
                dest_ip_arp[31:24] <= internal_data_rx;
            else if(rx_arp_counter == 29)
                dest_ip_arp[23:16] <= internal_data_rx;
            else if(rx_arp_counter == 30)
                dest_ip_arp[15:8] <= internal_data_rx;
            else if(rx_arp_counter == 31)
                dest_ip_arp[7:0] <= internal_data_rx;

            if(internal_valid_rx && (rx_arp_counter == 6'd0) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[47:40])))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd1) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[39:32])))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd2) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[31:24])))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd3) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[23:16])))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd4) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[15:8])))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd5) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[7:0])))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd12) && !(internal_data_rx == 8'h08))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd13) && !(internal_data_rx == 8'h06))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd14) && !(internal_data_rx == 8'h00))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd15) && !(internal_data_rx == 8'h01))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd16) && !(internal_data_rx == 8'h08))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd17) && !(internal_data_rx == 8'h00))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd20) && !(internal_data_rx == 8'h00))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd21) && !(internal_data_rx == 8'h01))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd38) && !(internal_data_rx == SRC_IP[31:24]))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd39) && !(internal_data_rx == SRC_IP[23:16]))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd40) && !(internal_data_rx == SRC_IP[15:8]))
                error_rx_arp <= 1'b1;
            else if(internal_valid_rx && (rx_arp_counter == 6'd41) && !(internal_data_rx == SRC_IP[7:0]))
                error_rx_arp <= 1'b1;
            else if(rx_arp_started1)
                error_rx_arp <= 1'b0;
        end
    end

    always @(posedge clk) begin
        if(reset)
            rx_arp_counter_dl <= 1'b0;
         else
            rx_arp_counter_dl <= rx_arp_counter;
    end

    always @(posedge clk) begin
        if(reset)
            reply_arp_requested <= 1'b0;
        else if((rx_arp_counter == 6'b0) && (rx_arp_counter_dl == 6'd41) && !error_rx_arp)
            reply_arp_requested <= 1'b1;
        else if((reply_arp_counter == 6'd45) && internal_ready_reply) //41
            reply_arp_requested <= 1'b0;
    end
    /*************************************** ARP End ****************************************************/

    /***************************************   UDP   ****************************************************/
     always @(posedge clk) begin
        if(reset) begin
            rx_udp_started_reg0 <= 1'b0;
            rx_udp_started_reg1 <= 1'b0;
            rx_udp_started_reg2 <= 1'b0;
            rx_udp_started_reg3 <= 1'b0;
            rx_udp_started_reg4 <= 1'b0;
            rx_udp_started_reg5 <= 1'b0;
        end
        else if(internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[47:40])) && (rx_udp_counter == 6'd0))
            rx_udp_started_reg0 <= 1'b1;
        else if(internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[39:32])) && (rx_udp_counter == 6'd1))
            rx_udp_started_reg1 <= 1'b1;
        else if(internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[31:24])) && (rx_udp_counter == 6'd2))
            rx_udp_started_reg2 <= 1'b1;
        else if(internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[23:16])) && (rx_udp_counter == 6'd3))
            rx_udp_started_reg3 <= 1'b1;
        else if(internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[15:8])) && (rx_udp_counter == 6'd4))
            rx_udp_started_reg4 <= 1'b1;
        else if(internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[7:0])) && (rx_udp_counter == 6'd5))
            rx_udp_started_reg5 <= 1'b1;
        else if((rx_udp_counter == rx_udp_total_length_shifted) && internal_valid_rx && internal_ready_rx) begin
            rx_udp_started_reg0 <= 1'b0;
            rx_udp_started_reg1 <= 1'b0;
            rx_udp_started_reg2 <= 1'b0;
            rx_udp_started_reg3 <= 1'b0;
            rx_udp_started_reg4 <= 1'b0;
            rx_udp_started_reg5 <= 1'b0;
        end
        else if(error_rx_udp && rx_udp_started2) begin
            rx_udp_started_reg0 <= 1'b0;
            rx_udp_started_reg1 <= 1'b0;
            rx_udp_started_reg2 <= 1'b0;
            rx_udp_started_reg3 <= 1'b0;
            rx_udp_started_reg4 <= 1'b0;
            rx_udp_started_reg5 <= 1'b0;
        end
    end

    assign rx_udp_started2 = rx_udp_started_reg0 && rx_udp_started_reg1 && rx_udp_started_reg2 && rx_udp_started_reg3 && rx_udp_started_reg4 && rx_udp_started_reg5;
    assign rx_udp_started0 = rx_udp_started_reg0 && rx_udp_started_reg1 && rx_udp_started_reg2 && rx_udp_started_reg3 && rx_udp_started_reg4 && (internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[7:0])) && (rx_udp_counter == 6'd5));
    assign rx_udp_started1 = internal_valid_rx && internal_ready_rx && ((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[47:40])) && (rx_udp_counter == 6'd0); 

     always @(posedge clk) begin
        if(reset)
            rx_udp_counter <= 1'b0;
        else if (internal_valid_rx && internal_ready_rx && (rx_udp_started_reg0 || rx_udp_started1) && (rx_udp_counter < rx_udp_total_length_shifted))
            rx_udp_counter <= rx_udp_counter + 1'b1;
        else if (((rx_udp_counter == rx_udp_total_length_shifted) && internal_valid_rx && internal_ready_rx) || error_rx_udp)
            rx_udp_counter <= 1'b0;
     end

     always @(posedge clk) begin
        if(reset)
            error_rx_udp <= 1'b0;
        else begin
            if((rx_udp_counter == rx_udp_total_length_shifted))
                error_rx_udp <= 1'b0;
            else if((rx_udp_counter == 0) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[47:40])) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 1) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[39:32])) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 2) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[31:24])) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 3) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[23:16])) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 4) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[15:8])) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 5) && !((internal_data_rx == 8'hff) || (internal_data_rx == SRC_MAC[7:0])) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 12) && !(internal_data_rx == 8'h08) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 13) && !(internal_data_rx == 8'h00) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 23) && !(internal_data_rx == 8'h11) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 30) && !(internal_data_rx == SRC_IP[31:24]) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 31) && !(internal_data_rx == SRC_IP[23:16]) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 32) && !(internal_data_rx == SRC_IP[15:8]) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 33) && !(internal_data_rx == SRC_IP[7:0]) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 36) && !(internal_data_rx == SRC_PORT[15:8]) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if((rx_udp_counter == 37) && !(internal_data_rx == SRC_PORT[7:0]) && internal_valid_rx && internal_ready_rx)
                error_rx_udp <= 1'b1;
            else if(rx_udp_started0)
                error_rx_udp <= 1'b0;
        end
     end

     assign internal_ready_rx = (rx_udp_counter > 41) && (rx_udp_counter <= rx_udp_total_length_shifted) ? rx_streaming_ready : 1'b1; //47
     assign rx_streaming_valid = (rx_udp_counter > 41) && (rx_udp_counter <= rx_udp_total_length_shifted) ? internal_valid_rx : 1'b0;
     assign rx_streaming_data = (rx_udp_counter > 41) && (rx_udp_counter <= rx_udp_total_length_shifted) ? internal_data_rx : 1'b0;
     assign rx_streaming_last = internal_valid_rx && internal_ready_rx && (rx_udp_counter == rx_udp_total_length_shifted);

     always @(posedge clk) begin
        if(reset) begin
            rx_udp_length <= 1'b0;
            rx_udp_packet_size <= 1'b0;
            rx_udp_total_length_shifted <= 8'd41;
        end
        else begin
            if((rx_udp_counter == 38) && !error_rx_udp && internal_valid_rx && internal_ready_rx) begin
                rx_udp_length[15:8] <= internal_data_rx;
            end
            else if((rx_udp_counter == 39) && !error_rx_udp && internal_valid_rx && internal_ready_rx) begin
                rx_udp_length[7:0] <= internal_data_rx;
                rx_udp_total_length_shifted <= (16'd33 + {rx_udp_length[15:8], internal_data_rx}) > 16'd41 ? (16'd33 + {rx_udp_length[15:8], internal_data_rx}) : 16'd41; //28 33 
            end
            rx_udp_packet_size <= rx_udp_length - 16'd10;
        end
     end

    /*************************************** UDP End ****************************************************/

    always @(posedge clk) begin
       if (reset) begin
          header_checksum_temp1 <= 0;
          header_checksum_temp2 <= 0;
          header_checksum       <= 0;
       end
       else begin
          header_checksum_temp1 <= 16'h4500 + MAC_LENGTH[15:0] +  16'h0000 + 16'h4000 + 16'hff11 + SRC_IP[31:16] + SRC_IP[15:0] + DST_IP[31:16] + DST_IP[15:0];
          header_checksum_temp2 <= header_checksum_temp1[31:16] + header_checksum_temp1 [15:0];
          header_checksum       <= ~(header_checksum_temp2[31:16] + header_checksum_temp2 [15:0]);
        end
    end

    always @(posedge clk) begin
        if(reset) begin
            udp_total_length_divided <= 1'b0;
            tx_packet_length <= 1'b0;
        end
        else begin
            udp_total_length_divided <= tx_packet_length;//(tx_packet_length >> 2);
            tx_packet_length <= 16'd41 + PACKET_SIZE; //52
        end
    end

   /*************************************** Common ****************************************************/
    always @(posedge clk) begin
        if(reset) begin
            reply_arp_counter <= 1'b0;
            reply_tx_data     <= 1'b0;
            reply_tx_valid    <= 1'b0;
            reply_tx_last     <= 1'b0;
            tx_udp_counter    <= 1'b0;
        end
        else begin
            if(internal_ready_reply && reply_arp_requested && (reply_arp_counter < 6'd41) && (tx_udp_counter == 0)) begin //arp
                reply_arp_counter <= reply_arp_counter + 1'b1;
                reply_tx_valid <= 1'b1;
                reply_tx_last <= 1'b0;
                case(reply_arp_counter)
                    0  : reply_tx_data <= dest_mac_arp[47:40];
                    1  : reply_tx_data <= dest_mac_arp[39:32];
                    2  : reply_tx_data <= dest_mac_arp[31:24];
                    3  : reply_tx_data <= dest_mac_arp[23:16];
                    4  : reply_tx_data <= dest_mac_arp[15:8];
                    5  : reply_tx_data <= dest_mac_arp[7:0];
                    6  : reply_tx_data <= SRC_MAC[47:40];
                    7  : reply_tx_data <= SRC_MAC[39:32];
                    8  : reply_tx_data <= SRC_MAC[31:24];
                    9  : reply_tx_data <= SRC_MAC[23:16];
                    10 : reply_tx_data <= SRC_MAC[15:8];
                    11 : reply_tx_data <= SRC_MAC[7:0];
                    12 : reply_tx_data <= 8'h08;
                    13 : reply_tx_data <= 8'h06;
                    14 : reply_tx_data <= 8'h00;
                    15 : reply_tx_data <= 8'h01;
                    16 : reply_tx_data <= 8'h08;
                    17 : reply_tx_data <= 8'h00;
                    18 : reply_tx_data <= 8'h06;
                    19 : reply_tx_data <= 8'h04;
                    20 : reply_tx_data <= 8'h00;
                    21 : reply_tx_data <= 8'h02;
                    22 : reply_tx_data <= SRC_MAC[47:40];
                    23 : reply_tx_data <= SRC_MAC[39:32];
                    24 : reply_tx_data <= SRC_MAC[31:24];
                    25 : reply_tx_data <= SRC_MAC[23:16];
                    26 : reply_tx_data <= SRC_MAC[15:8];
                    27 : reply_tx_data <= SRC_MAC[7:0];
                    28 : reply_tx_data <= SRC_IP[31:24];
                    29 : reply_tx_data <= SRC_IP[23:16];
                    30 : reply_tx_data <= SRC_IP[15:8];
                    31 : reply_tx_data <= SRC_IP[7:0];
                    32 : reply_tx_data <= dest_mac_arp[47:40];
                    33 : reply_tx_data <= dest_mac_arp[39:32];
                    34 : reply_tx_data <= dest_mac_arp[31:24];
                    35 : reply_tx_data <= dest_mac_arp[23:16];
                    36 : reply_tx_data <= dest_mac_arp[15:8];
                    37 : reply_tx_data <= dest_mac_arp[7:0];
                    38 : reply_tx_data <= dest_ip_arp[31:24];
                    39 : reply_tx_data <= dest_ip_arp[23:16];
                    40 : reply_tx_data <= dest_ip_arp[15:8];
                    41 : reply_tx_data <= dest_ip_arp[7:0];
                    default: reply_tx_data <= 1'b0;
                endcase
            end
            else if(internal_ready_reply && reply_arp_requested && (reply_arp_counter == 6'd41) && (tx_udp_counter == 0)) begin //arp
                reply_arp_counter <= reply_arp_counter + 1'b1;
                reply_tx_data <= dest_ip_arp[7:0];
                reply_tx_valid <= 1'b1;
                reply_tx_last <= 1'b1;
            end
            else if(reply_arp_requested && (reply_arp_counter == 6'd42) && (tx_udp_counter == 0)) begin
                reply_arp_counter <= reply_arp_counter + 1'b1;
                reply_tx_data <= 8'h00;
                reply_tx_valid <= 1'b0;
                reply_tx_last <= 1'b0;
            end
            else if(reply_arp_requested && (reply_arp_counter == 6'd43) && (tx_udp_counter == 0)) begin
                reply_arp_counter <= reply_arp_counter + 1'b1;
                reply_tx_data <= 8'h00;
                reply_tx_valid <= 1'b0;
                reply_tx_last <= 1'b0;
            end
            else if(reply_arp_requested && (reply_arp_counter == 6'd44) && (tx_udp_counter == 0)) begin
                reply_arp_counter <= reply_arp_counter + 1'b1;
                reply_tx_data <= 8'h00;
                reply_tx_valid <= 1'b0;
                reply_tx_last <= 1'b0;
            end
            else if(reply_arp_requested && (reply_arp_counter == 6'd45) && (tx_udp_counter == 0)) begin
                reply_arp_counter <= 1'b0;
                reply_tx_data <= 8'h00;
                reply_tx_valid <= 1'b0;
                reply_tx_last <= 1'b0;
            end

            //udp
            else if((tx_udp_counter < 16'd42) && internal_ready_reply && streaming_started && (reply_arp_counter == 0)) begin
                tx_udp_counter <= tx_udp_counter + 1'b1;
                reply_tx_valid <= 1'b1;
                reply_tx_last <= 1'b0;
                case(tx_udp_counter)
                    0  : reply_tx_data <= DST_MAC[47:40];
                    1  : reply_tx_data <= DST_MAC[39:32];
                    2  : reply_tx_data <= DST_MAC[31:24];
                    3  : reply_tx_data <= DST_MAC[23:16];
                    4  : reply_tx_data <= DST_MAC[15:8];
                    5  : reply_tx_data <= DST_MAC[7:0];
                    6  : reply_tx_data <= SRC_MAC[47:40];
                    7  : reply_tx_data <= SRC_MAC[39:32];
                    8  : reply_tx_data <= SRC_MAC[31:24];
                    9  : reply_tx_data <= SRC_MAC[23:16];
                    10 : reply_tx_data <= SRC_MAC[15:8];
                    11 : reply_tx_data <= SRC_MAC[7:0];
                    12 : reply_tx_data <= 8'h08;
                    13 : reply_tx_data <= 8'h00;
                    14 : reply_tx_data <= 8'h45;
                    15 : reply_tx_data <= 8'h00;
                    16 : reply_tx_data <= MAC_LENGTH[15:8];
                    17 : reply_tx_data <= MAC_LENGTH[7:0];
                    18 : reply_tx_data <= 8'h00;
                    19 : reply_tx_data <= 8'h00;
                    20 : reply_tx_data <= 8'h40;
                    21 : reply_tx_data <= 8'h00;
                    22 : reply_tx_data <= 8'hFF;
                    23 : reply_tx_data <= 8'h11;
                    24 : reply_tx_data <= header_checksum[15:8];
                    25 : reply_tx_data <= header_checksum[7:0];
                    26 : reply_tx_data <= SRC_IP[31:24];
                    27 : reply_tx_data <= SRC_IP[23:16];
                    28 : reply_tx_data <= SRC_IP[15:8];
                    29 : reply_tx_data <= SRC_IP[7:0];
                    30 : reply_tx_data <= DST_IP[31:24];
                    31 : reply_tx_data <= DST_IP[23:16];
                    32 : reply_tx_data <= DST_IP[15:8];
                    33 : reply_tx_data <= DST_IP[7:0];
                    34 : reply_tx_data <= SRC_PORT[15:8];
                    35 : reply_tx_data <= SRC_PORT[7:0];
                    36 : reply_tx_data <= port_indicator ? DST_PORT2[15:8] : DST_PORT[15:8];
                    37 : reply_tx_data <= port_indicator ? DST_PORT2[7:0] : DST_PORT[7:0];
                    38 : reply_tx_data <= UDP_LENGTH[15:8];
                    39 : reply_tx_data <= UDP_LENGTH[7:0];
                    40 : reply_tx_data <= 8'h00;
                    41 : reply_tx_data <= 8'h00;
                    default: reply_tx_data <= 1'b0;
                endcase
            end
            else if((tx_udp_counter > 16'd41) && (tx_udp_counter < udp_total_length_divided) && internal_ready_reply && stream_valid_internal && stream_ready_internal && streaming_started && (reply_arp_counter == 0)) begin
                tx_udp_counter <= tx_udp_counter + 1'b1;
                reply_tx_valid <= 1'b1;
                reply_tx_last <= 1'b0;
                reply_tx_data <= stream_data_internal;
            end
            else if((tx_udp_counter == udp_total_length_divided) && internal_ready_reply && stream_valid_internal && stream_ready_internal && streaming_started && (reply_arp_counter == 0)) begin
                tx_udp_counter <= 16'b0;
                reply_tx_valid <= 1'b1;
                reply_tx_last  <= 1'b1;
                reply_tx_data  <= stream_data_internal;
            end
            else begin
                reply_tx_data  <= 1'b0;
                reply_tx_valid <= 1'b0;
                reply_tx_last  <= 1'b0;
            end
        end
    end

  assign internal_ready_reply = master_ready;
  assign master_data = reply_tx_data;
  assign master_valid = reply_tx_valid;
  assign master_last = reply_tx_last;

  assign tx_streaming_ready_internal = stream_ready_internal;
  assign stream_valid_internal = tx_streaming_valid && tx_streaming_ready;
  assign stream_data_internal = tx_streaming_data;
  assign stream_last_internal = tx_streaming_last;

  always @(posedge clk) begin
    if(reset)
        streaming_started <= 1'b0;
    else if(tx_streaming_valid)
        streaming_started <= 1'b1;
  end

  assign tx_streaming_ready = tx_streaming_ready_internal;
  assign stream_ready_internal = (tx_udp_counter > 16'd41) && internal_ready_reply;

  always @(posedge clk) begin
    if(reset) begin
        packet_counter <= 1'b0;
        port_indicator <= 1'b0;
    end
    else begin
        if((tx_udp_counter == 16'd41) && internal_ready_reply) begin
            if(((packet_counter == (dstPort1PacketNum - 1)) && !port_indicator) || ((packet_counter == (dstPort2PacketNum - 1)) && port_indicator)) begin
                packet_counter <= 1'b0;
                port_indicator <= !port_indicator;
            end
            else
                packet_counter <= packet_counter + 1'b1;
        end
    end
  end
endmodule
