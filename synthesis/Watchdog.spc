*SPICE netlist created from BLIF module Watchdog by blif2BSpice
.include /usr/local/share/qflow/tech/osu018/osu018_stdcells.sp
.subckt Watchdog vdd gnd restart enable clk timeout 
XNAND2X1_1 vdd _0_ gnd counter.tff3.out counter.tff2.out NAND2X1
XNAND2X1_2 vdd _1_ gnd counter.tff1.out counter.tff0.out NAND2X1
XNOR2X1_1 vdd _1_ gnd _5_ _0_ NOR2X1
XINVX1_1 enable _2_ vdd gnd INVX1
XOR2X2_1 counter.clear restart vdd gnd _2_ OR2X2
XAND2X2_1 vdd gnd counter.tff2.out counter.tff1.out _3_ AND2X2
XAND2X2_2 vdd gnd counter.tff3.out counter.tff0.out _4_ AND2X2
XAOI21X1_1 gnd vdd _3_ _4_ counter.enable _2_ AOI21X1
XBUFX2_1 vdd gnd _5_ timeout BUFX2
XAND2X2_3 vdd gnd counter.enable counter.tff0.out counter.tff1.t AND2X2
XNAND3X1_1 counter.tff0.out vdd gnd counter.enable counter.tff1.out _7_ NAND3X1
XINVX1_2 _7_ counter.tff2.t vdd gnd INVX1
XINVX1_3 counter.tff2.out _6_ vdd gnd INVX1
XNOR2X1_2 vdd _7_ gnd counter.tff3.t _6_ NOR2X1
XOR2X2_2 _9_ counter.tff0.out vdd gnd counter.enable OR2X2
XAOI21X1_2 gnd vdd counter.enable counter.tff0.out _10_ counter.clear AOI21X1
XAND2X2_4 vdd gnd _9_ _10_ _8_ AND2X2
XDFFPOSX1_1 vdd _8_ gnd counter.tff0.out clk DFFPOSX1
XOR2X2_3 _12_ counter.tff1.out vdd gnd counter.tff1.t OR2X2
XAOI21X1_3 gnd vdd counter.tff1.t counter.tff1.out _13_ counter.clear AOI21X1
XAND2X2_5 vdd gnd _12_ _13_ _11_ AND2X2
XDFFPOSX1_2 vdd _11_ gnd counter.tff1.out clk DFFPOSX1
XOR2X2_4 _15_ counter.tff2.out vdd gnd counter.tff2.t OR2X2
XAOI21X1_4 gnd vdd counter.tff2.t counter.tff2.out _16_ counter.clear AOI21X1
XAND2X2_6 vdd gnd _15_ _16_ _14_ AND2X2
XDFFPOSX1_3 vdd _14_ gnd counter.tff2.out clk DFFPOSX1
XOR2X2_5 _18_ counter.tff3.out vdd gnd counter.tff3.t OR2X2
XAOI21X1_5 gnd vdd counter.tff3.t counter.tff3.out _19_ counter.clear AOI21X1
XAND2X2_7 vdd gnd _18_ _19_ _17_ AND2X2
XDFFPOSX1_4 vdd _17_ gnd counter.tff3.out clk DFFPOSX1
XFILL_0_0_0 vdd gnd FILL
XFILL_0_0_1 vdd gnd FILL
XFILL_0_1_0 vdd gnd FILL
XFILL_0_1_1 vdd gnd FILL
XFILL_1_1 vdd gnd FILL
XFILL_1_0_0 vdd gnd FILL
XFILL_1_0_1 vdd gnd FILL
XFILL_1_1_0 vdd gnd FILL
XFILL_1_1_1 vdd gnd FILL
XFILL_2_1 vdd gnd FILL
XFILL_2_2 vdd gnd FILL
XFILL_2_0_0 vdd gnd FILL
XFILL_2_0_1 vdd gnd FILL
XFILL_2_1_0 vdd gnd FILL
XFILL_2_1_1 vdd gnd FILL
.ends Watchdog
 
