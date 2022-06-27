



# Abstract:
A watchdog timer is an electronic circuit that initiates corrective action in response to a computer hardware malfunction or program error. It is an essential component of systems that are difficult or impossible to physically access because it provides a way to automatically recover from transient faults. 
Every watchdog timer, however simple or sophisticated, must initiate two corrective actions. First, it must set the computer’s control outputs to safe levels so that potentially dangerous devices such as motors and heaters will not pose threats to people or equipment. This is a high priority action that must occur as soon as a fault is detected. After setting the outputs to safe levels, the next order of business is to restore normal system operation. This can be as simple as restarting the computer, as if a human operator has pressed the computer’s reset pushbutton, or it may involve a sequence of actions that ultimately ends with a computer restart. Also, a watchdog timer can respond to faults more quickly than a human operator, making it invaluable in cases where a human operator would be too slow to react to a fault condition. Watchdog timers are widely used in embedded and remote systems, in equipment ranging from microwave ovens to Mars rovers.

# Block Diagram
![New Doc 2022-06-27 22 47 04_1](https://user-images.githubusercontent.com/55652905/176007065-580b3792-6f51-4b27-a2f5-3da48cceb801.jpg)

# Circuit Diagram 
 ![New Doc 2022-06-27 22 47 04_2](https://user-images.githubusercontent.com/55652905/176007162-bbe251a4-fe13-4098-810d-ca48d8425e9f.jpg)

So based upon the circuit diagram we can easily start to write the RTL coding. Readers are requested to Write their own RTL coding because I’ve not shown the intermediate signal, wire or gate output like w1 w2 w3 w4 and many more just to avoid clumsiness in the circuit diagram.
In the circuit diagram restart enable clock are the 3 inputs and timeout is the single output.
When Restart = 1 then the counter is cleared and counting state is “0000”. Now in this state when we make Enable = 1 then the counting proceeds till “1111”. In from 0000 and till 1110 state the timeout is at low logic i.e., timeout = 0 . As soon as counting hits state 1111 the timeout goes to high logic i.e., timeout = 1 which in tern makes the enable signal to 0 (because of feedback mechanism) and the counting state retains to “1111” and timeout also retains to logic 1 until Restart is again made logic 1. 
So quite obviously if a periodic high pulse is received in the Restart pin before the counter reaches to 1111 state, then the timeout will remain low logic. If due to any internal disruption in system the Restart pin fail to receive any high pulse, then counter will reach to state 1111 and timeout will go high which gives us a signal that some internal fault has occurred in the system and a protocol should be followed to overcome the fault state of the machine 
# RTL Coding - 
Through Xilinx ISE design suit 14.7 we completed the Verilog coding of our design and analyzed or performed the functional synthesis of our design. The Verilog code is as follows - 

`timescale 1s / 1s

module Watchdog (output timeout, input restart , enable, clk);

  wire w_restart , w_enable, not_enable,not_timeout; 
  
  wire [3:0] d_out;
  
  wire w1,w2,w3,w4;
  
  reg [3:0] t_value = 4'b1111;
  
  not (not_enable, enable);
  
  not (not_timeout, timeout);
  
  or (w_reset, restart,not_enable);
  
  and (w_enable, enable, not_timeout);
  
  up_counter counter(d_out,w_enable,w_reset,clk);
  
  xnor g1 (w1,d_out[0],t_value[0]);
  
  xnor g2 (w2,d_out[1],t_value[1]);
  
  xnor g3 (w3,d_out[2],t_value[2]);
  
  xnor g4 (w4,d_out[3],t_value[3]);
  
  and g5 (timeout,w1,w2,w3,w4);
  
  endmodule 


module up_counter(d_out,enable,clear,clk);

input enable,clear,clk;

output [3:0] d_out;

wire w11 , w22 , w33 ;

T_FF tff0 (d_out[0],enable,clear,clk);

and count_and_1 (w11,d_out[0],enable);

T_FF tff1 (d_out[1],w11,clear,clk);

and count_and_2 (w22,d_out[1], w11);

T_FF tff2 (d_out[2],w22,clear,clk);

and count_and_3 (w33,d_out[2],w22);

T_FF tff3 (d_out[3],w33,clear,clk);

endmodule 


module T_FF (out,t,clear,clk);  

output reg out;

input t,clk,clear;

always @ (posedge clk) begin 
  
if (clear) 
    
out <= 0; 
      
else  
    
if (t)  
        
out <= ~out;
            
else  
       
out <= out;  
            
end  
  
endmodule    




# The waveform can be visualized like –
Let us concentrate on clk, restart, enable, d_out[3:0]
Observe in between 0 to 30 sec , restart = 1 , enable = 0 then corresponding count i.e d_out[3:0] is 0000 and obviously the timeout signal is low
 ![0 to 30 sec](https://user-images.githubusercontent.com/55652905/176010125-68f6f7e8-c28a-4146-a62a-51c111daaa99.JPG)



Again in between 30 to 40 sec , I made restart signal to 0 and enable still to 0 , so in this case the count again remains 0000 and timeout signal to low
 ![30 to 40 sec](https://user-images.githubusercontent.com/55652905/176010160-ca96d633-9b6d-4f9b-ab17-9dccbcdc244c.JPG)


In between 40 to 190 sec we now made restart to 0 , enable to 1 so this time onwards the counting begins form 0000 (time 40 sec) to 1111 (time 190 sec)
 
 
![40 to 75 to 190](https://user-images.githubusercontent.com/55652905/176010231-fca86871-4193-48fa-8ef0-19d8fd4fa4dc.JPG)
![40 to 110 to 190](https://user-images.githubusercontent.com/55652905/176010237-61b3a1b2-59cb-4230-b1d9-03a1359641a0.JPG)
![40 to 145 to 190](https://user-images.githubusercontent.com/55652905/176010242-70eae94a-e7db-4f63-ad8c-7bc5ca2a2884.JPG)
![40 to 180 to 190](https://user-images.githubusercontent.com/55652905/176010247-8e2e0251-5494-4412-820f-9b44b11853cd.JPG)
![40 to 190](https://user-images.githubusercontent.com/55652905/176010221-fd43dfca-0412-4cac-a805-81a9f17e83e1.JPG)
 
 
 

Now observe in time between 190 to 215 , as soon as timer hits 1111 this makes the timeout to go high (1), this high signal travels back to input and makes enable to 0, so the counter halts i.e. stays and continues to count 1111.


![190 to 215](https://user-images.githubusercontent.com/55652905/176010949-1422e1e7-dca0-4468-8eab-a8474c51edd7.JPG)



Now its time to restart the timer, for that observe in time 215 to 235 sec we made the restart to 1 and enable was already made 0, so with this the timeout signal again comes to low level and count is reset to 0000, again we can enable the signal to 1 so as to perform more experiments. 
 
![215 to 235](https://user-images.githubusercontent.com/55652905/176010983-cdfde4c9-8752-47e0-831b-ddca1e6c4aa5.JPG)





The overall complete waveform can be visualized like this –
 ![total waveform](https://user-images.githubusercontent.com/55652905/176011011-de608ed2-141d-45a8-85c5-b5619e2ddd08.JPG)


So for now we have completed the RTL Description phase of our flow using Verilog 

For the remainder of part we take the help of Qflow

# Qflow 
is a complete tool chain for synthesizing digital circuits starting from verilog source and ending in physical layout for a specific target fabrication process.
The qflow package contains all the scripts and most of the tools necessary for the open-source digital synthesis flow. It also comes with some of the files from the OSU (Oklahoma State University)  standard cell library, to provide a default technology.
The qflow GUI is written in python3, so it will be necessary to install python3 on your system if it is not already installed.

# Synthesis -tool name Yosys                  
[Copyright (C) 2012 - 2016  Clifford Wolf clifford@clifford.at]      
Yosys is an open-source framework for Verilog synthesis and verification
Yosys reads the verilog source file or files, performs synthesis, optimizations, and writes a netlist in BLIF format. We provide the technology parameter OSU018 or 180 nm technology. The technology library file gets elaborated and gets bonded with our Verilog file to generate the Netlist file. In our case the Netlist file can be viewed like- 
 
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

All the body part of the netlist file is actually the hardware which has been mapped to our Verilog file from the standard cell library file. Such file can be also used for post synthesis verification but not been discussed in this project.
It can be also seen from the corresponding log file the number of gates wire etc. required in our netlist 
Analyzing design hierarchy..
Top module:  \Watchdog
Used module:     \up_counter
Used module:         \T_FF
Printing statistics.
=== T_FF ===
Number of wires:                  6
Number of wire bits:              6
Number of public wires:           4
Number of public wire bits:       4
Number of memories:               0
Number of memory bits:            0
Number of processes:              0
Number of cells:                  3
$_DFF_P_                        1
$_NOR_                          1
$_XNOR_                         1
=== Watchdog ===
Number of wires:                 10
Number of wire bits:             13
Number of public wires:           7
Number of public wire bits:      10
Number of memories:               0
Number of memory bits:            0
Number of processes:              0
Number of cells:                  7
$_AND_                          3
$_AOI3_                         1
$_NOT_                          1
$_OR_                           1
up_counter                      1
=== design hierarchy ===
Watchdog                          1
up_counter                      1
T_FF                          4
Number of wires:                 41
Number of wire bits:             47
Number of public wires:          30
Number of public wire bits:      36
Number of memories:               0
Number of memory bits:            0
Number of processes:              0
Number of cells:                 21
$_AND_                          6
$_AOI3_                         1
$_DFF_P_                        4
$_NOR_                          4
$_NOT_                          1
$_OR_                           1
$_XNOR_                         4
# Placement- tool name Graywolf 
Graywolf is used for placement in VLSI design. It's mainly used together with qflow. It is based on some code from the early 90s and it is one of the building blocks  of  the  open  source  qflow digital design flow. Note that in our case the aspect ratio (W/L) is made 1.

Corresponding to it’s log fille it can be seen some description like 
6 routing layers
metal1: 32 vertical tracks from 0um with 1um pitch
metal2: 57 vertical tracks from -3.2um with 0.8um pitch
metal3: 32 vertical tracks from 0um with 1um pitch
metal4: 57 vertical tracks from -3.2um with 0.8um pitch
metal5: 32 vertical tracks from 0um with 1um pitch
metal6: 29 vertical tracks from -3.2um with 1.6um pitch
point to be noted from this is the 180 nm technology employs 6 metal layers.
# Display- tool name Magic view
After the placement we can invoke the Magic tool for visual graphics on the project till now after placement 
After the placement phase we get our standard cells as mention before from netlist to get placed and the chip looks like this - 
 ![after placement](https://user-images.githubusercontent.com/55652905/176011582-d3b21084-4c94-4d39-8d0f-a38b46a76034.JPG)

 Note other than the gates and power strips nothing else has been done.

# STA - tool name OpenSTA 
OpenSTA is a gate level static timing verifier. As a stand-alone executable it can be used to verify the timing of a design using standard file formats. OpenSTA uses a TCL command interpreter to read the design, specify timing constraints and print timing reports.
So after the placement its high time to check if our design meets the timing constraints by analyzing the Setup time violation , Hold time violation by analyzing different paths in our design. Most importantly It provides the maximum clock which can be provided or implemented in our design in our case we see –
Maximum clock frequency (zero margin) – 866.166 MHz
Of course, after the routing the clock frequency will decrease.
# Routing - tool name Qrouter
Qrouter is a tool to generate metal layers and vias to physically connect together a netlist in a VLSI fabrication technology. It is a maze router, otherwise known as an "over-the-cell" router or "sea-of-gates" router. That is, unlike a channel router, it begins with a description of placed standard cells, usually packed together at minimum spacing, and places metal routes over the standard cells.
After the process you can again invoke the Magic Viewer to see if the routing has been done or not
 ![after routing](https://user-images.githubusercontent.com/55652905/176011689-86bb4be9-8e40-4f18-9fa6-9e2eb157e183.JPG)
After the whole process the output port has been connected to the design and the gates are been appropriately connected.

# Post Routing STA – OpenSTA
After routing the clock frequency will decrease because every element gate or wire will have their own delay.
Maximum clock frequency (Zero Margin) = 853.252 MHz.

Now after the Migrate , DRC, LVS, GDS stage we will get final outcome as design layout.

# The final Layout on Magic View is given as -  
 ![final output](https://user-images.githubusercontent.com/55652905/176011860-88318696-d80b-41c3-809d-d5b9937fbda1.JPG)

After all stages completed successfully, we have achieved the GDSII file which can be send to foundry. 

P.S : ❗ I will auload the remaining detail Description after Post routing Sta in near future ❗ 
