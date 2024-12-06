`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2022 02:06:11 AM
// Design Name: 
// Module Name: TB_newprocss
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module TB_newprocss();

parameter n = 16;
reg wr_a,clock;
//input from dram at corresponding to given address(dataout)


wire [n-1:0] foutput;






top_slow_clock tut(.wr_a(wr_a),.clock_in(clock));
    
    initial 
    clock = 0;
    always #10 clock = ~clock;
//control_in
//src1
//src2
//imm
//src1val
//src2val
initial begin
//operation(add,shleftlog)--cin--opselect(arithlogic_memered,shiftreg)

wr_a=0;
#2000


$finish;

end
endmodule
    