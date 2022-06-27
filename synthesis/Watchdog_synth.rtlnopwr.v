module Watchdog (restart, enable, clk, timeout);

input restart;
input enable;
input clk;
output timeout;

wire vdd = 1'b1;
wire gnd = 1'b0;

NAND2X1 NAND2X1_1 ( .A(counter_tff3_out), .B(counter_tff2_out), .Y(_0_) );
NAND2X1 NAND2X1_2 ( .A(counter_tff1_out), .B(counter_tff0_out), .Y(_1_) );
NOR2X1 NOR2X1_1 ( .A(_0_), .B(_1_), .Y(_5_) );
INVX1 INVX1_1 ( .A(enable), .Y(_2_) );
OR2X2 OR2X2_1 ( .A(_2_), .B(restart), .Y(counter_clear) );
AND2X2 AND2X2_1 ( .A(counter_tff2_out), .B(counter_tff1_out), .Y(_3_) );
AND2X2 AND2X2_2 ( .A(counter_tff3_out), .B(counter_tff0_out), .Y(_4_) );
AOI21X1 AOI21X1_1 ( .A(_3_), .B(_4_), .C(_2_), .Y(counter_enable) );
BUFX2 BUFX2_1 ( .A(_5_), .Y(timeout) );
AND2X2 AND2X2_3 ( .A(counter_enable), .B(counter_tff0_out), .Y(counter_tff1_t) );
NAND3X1 NAND3X1_1 ( .A(counter_enable), .B(counter_tff0_out), .C(counter_tff1_out), .Y(_7_) );
INVX1 INVX1_2 ( .A(_7_), .Y(counter_tff2_t) );
INVX1 INVX1_3 ( .A(counter_tff2_out), .Y(_6_) );
NOR2X1 NOR2X1_2 ( .A(_6_), .B(_7_), .Y(counter_tff3_t) );
OR2X2 OR2X2_2 ( .A(counter_enable), .B(counter_tff0_out), .Y(_9_) );
AOI21X1 AOI21X1_2 ( .A(counter_enable), .B(counter_tff0_out), .C(counter_clear), .Y(_10_) );
AND2X2 AND2X2_4 ( .A(_9_), .B(_10_), .Y(_8_) );
DFFPOSX1 DFFPOSX1_1 ( .CLK(clk), .D(_8_), .Q(counter_tff0_out) );
OR2X2 OR2X2_3 ( .A(counter_tff1_t), .B(counter_tff1_out), .Y(_12_) );
AOI21X1 AOI21X1_3 ( .A(counter_tff1_t), .B(counter_tff1_out), .C(counter_clear), .Y(_13_) );
AND2X2 AND2X2_5 ( .A(_12_), .B(_13_), .Y(_11_) );
DFFPOSX1 DFFPOSX1_2 ( .CLK(clk), .D(_11_), .Q(counter_tff1_out) );
OR2X2 OR2X2_4 ( .A(counter_tff2_t), .B(counter_tff2_out), .Y(_15_) );
AOI21X1 AOI21X1_4 ( .A(counter_tff2_t), .B(counter_tff2_out), .C(counter_clear), .Y(_16_) );
AND2X2 AND2X2_6 ( .A(_15_), .B(_16_), .Y(_14_) );
DFFPOSX1 DFFPOSX1_3 ( .CLK(clk), .D(_14_), .Q(counter_tff2_out) );
OR2X2 OR2X2_5 ( .A(counter_tff3_t), .B(counter_tff3_out), .Y(_18_) );
AOI21X1 AOI21X1_5 ( .A(counter_tff3_t), .B(counter_tff3_out), .C(counter_clear), .Y(_19_) );
AND2X2 AND2X2_7 ( .A(_18_), .B(_19_), .Y(_17_) );
DFFPOSX1 DFFPOSX1_4 ( .CLK(clk), .D(_17_), .Q(counter_tff3_out) );
endmodule
