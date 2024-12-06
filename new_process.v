`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2022 01:34:16 AM
// Design Name: 
// Module Name: new_process
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


module new_process(input clock,reset,enable_ex,input [15:0]imm,mem_data_read_in1,mem_data_read_in2,input [6:0]control_in,output  reg enable_arith,enable_shift,output reg [4:0]  shift_number,output reg [2:0] operation,opselect,output reg [15:0]aluin1,aluin2,output  [15:0] aluoutfinal);
//reg immp_regn,opselect,operation;
complete_alu b3(.clock(clock),.reset(reset),.enable_arith(enable_arith),.enable_shift(enable_shift),.aluin1(aluin1),.aluin2(aluin2),.operation(operation),.opselect(opselect),.shift_number(shift_number),.aluoutfinal(aluoutfinal));


parameter MEM_READ = 3'b101; 
parameter ARITH_LOGIC = 3'b001;
parameter SHIFT_REG=3'b000; 


always@(posedge clock)
begin
if(!reset)
    begin
   enable_arith=0;
   enable_shift=0;
//mem_data_wr_en=0;
    shift_number=0;
//mem_data_write_out=0;
    aluin1<=0;
    aluin2<=0;
    end
else
    begin
    opselect<={control_in[2:0]};
    
    operation<={control_in[6:4]};
    if(enable_ex)// aluin1 selection
        begin
        aluin1<=mem_data_read_in1;//memdatareadin
        
 
        if(opselect== ARITH_LOGIC && control_in[3]==1)
            begin
            aluin2<=imm;
            enable_arith<=1;
            enable_shift<=0;
            end
        else if(opselect== ARITH_LOGIC && control_in[3]==0)
            begin
            aluin2<=mem_data_read_in2;//from src1_address
            enable_arith<=1;
            enable_shift<=0;
            end
        else if(opselect== MEM_READ && control_in[3]==0)
        begin
            aluin2<=aluin2;
            enable_arith<=0;
            enable_shift<=0;
            end

        else if(opselect== MEM_READ && control_in[3]==1)
            begin
            aluin2<=mem_data_read_in2;//from src2_address
            enable_arith<=1;
            enable_shift<=0;
            end
        else if(opselect== SHIFT_REG  && imm[2]==0)
            begin
            shift_number<=imm[10:6];
            enable_shift<=1;
            enable_arith<=0;
            end
        else if(opselect== SHIFT_REG  && imm[2]==1)
            begin
            shift_number<=mem_data_read_in2[4:0];
            enable_shift<=1;
            enable_arith<=0;
            end
       end
     else
            begin
          aluin1<=aluin1;
          aluin2<=aluin2;
          enable_arith<=enable_arith;
          shift_number<=shift_number;
          enable_shift<=enable_shift;
            end
        end
end
endmodule
