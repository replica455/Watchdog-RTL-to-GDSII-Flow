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