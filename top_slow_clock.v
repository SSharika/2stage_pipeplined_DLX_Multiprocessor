`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2022 20:25:29
// Design Name: 
// Module Name: top_slow_clock
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


module top_slow_clock(
    reset,wr_a,clock_in, 
    clock_slow
    ,finaloutput);
    
    input wr_a,clock_in; 
    output clock_slow;
    output reg reset;
    output [15:0] finaloutput;
    fetch_controller top(.foutput(finaloutput),.clock(clock_slow),.wr_a(wr_a),.reset(reset));
    
    reg clock_out = 0; 
    reg [25:0] counter = 0; 

    always @(posedge clock_in) 
    begin 
        reset=1;
        counter <= counter + 1;
        
        if(counter == 2)
        begin 
           counter <= 0;  
           clock_out <= ~clock_out ;
        end 
    
    end  
    
    assign clock_slow = clock_out ;
    
    
endmodule
