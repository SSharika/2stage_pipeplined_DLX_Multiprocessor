`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2022 01:29:35 AM
// Design Name: 
// Module Name: complete_alu
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


module complete_alu(input clock,reset,enable_arith,enable_shift,input signed [15:0] aluin1,aluin2,input [2:0] operation,opselect,input [4:0] shift_number,output  reg [15:0] aluoutfinal);
reg [15:0] aluoutarith,aluoutshift;
parameter MEM_READ = 3'b101; 
parameter MEM_WRITE=3'b100; 
parameter ARITH_LOGIC = 3'b001;
parameter SHIFT_REG=3'b000; 
// ARITHMETIC 
parameter ADD=3'b000; 
parameter HADD=3'b001; 
parameter SUB=3'b010; 
parameter NOT=3'b011; 
parameter AND=3'b100; 
parameter OR=3'b101; 
parameter XOR=3'b110;
parameter LHG=3'b111; 
// SHIFTING 
parameter SHLEFTLOG = 3'b000; 
parameter SHLEFTART = 3'b001;
parameter SHRGHTLOG = 3'b010;
parameter SHRGHTART = 3'b011;
// DATA TRANSFER 
parameter LOADBYTE = 3'b000; 
parameter LOADBYTEU =3'b100;
parameter LOADHALF = 3'b001; 
parameter LOADHALFU = 3'b101; 
parameter LOADWORD=3'b011;


//ShiftModule alusft(.enable(enable_shift),.clock(clock),.reset(reset),.in(aluin1),.shiftnum(shift_number),.shift_operation(opselect),.aluout(aluoutarith));
//ARITH_ALU b4(.clock(clock),.reset(reset),.enable_arith(enable_arith),.aluin1(aluin1),.aluin2(aluin2),.operation(operation),.opselect(opselect),.aluout(aluoutshift));
//always@(posedge clock) 
//begin
//if(enable_arith==1)
//aluoutfinal=aluoutarith;
//else if(enable_shift==1)
//aluoutfinal=aluoutshift;
//end
//module ARITH_ALU(input clock,reset,enable_arith,input [31:0] aluin1,aluin2,input [2:0] operation,opselect, input [4:0] shift_number,output reg [32:0] aluout,output reg carry);




always@(posedge clock)
begin//

//carry=aluoutfinal[15];
if(!reset)
begin
aluoutfinal <= 0;
aluoutarith<=0;
aluoutshift<=0;
end
else
begin//
if(enable_arith)//
     begin
     aluoutfinal<=aluoutarith;
    
      if(opselect == ARITH_LOGIC)
       begin
            if(operation == ADD)
            begin
            aluoutarith=aluin1+aluin2;
            end
 
            else if(operation == HADD)
            begin
            {aluoutarith[15],aluoutarith[6:0]}=aluin1[6:0]+aluin2[6:0];
            end
            else if(operation == SUB)
            aluoutarith=aluin1-aluin2;
            else if(operation == NOT)
            begin
            aluoutarith=~aluin2;
            aluoutarith[15]=0;
            end
            else if(operation == AND)
            aluoutarith=aluin1 & aluin2;
            else if(operation == OR)
            aluoutarith=aluin1 | aluin2;
            else if(operation == XOR)
            aluoutarith=aluin1 ^ aluin2;
            else if(operation == LHG)
            begin
            aluoutarith[14:6]<= aluin2[6:0];
            aluoutarith[6:0]<= 0;
            

            end
      end

//else if(enable_arith)
//begin
else
if(opselect == MEM_READ)
    begin
            if (operation == LOADBYTE)
            begin
            aluoutarith<={{7{aluin2[7]}},{aluin2[7:0]}};
            
            end
            else if (operation == LOADBYTEU)
            begin
            
            aluoutarith<={{7{aluoutarith[15]}},{aluin2[7:0]}};
            end

            else if (operation == LOADHALF)
            begin
            aluoutarith<={{8{aluin2[6]}},{aluin2[6:0]}};
           
            end
            else if (operation == LOADHALFU)
            begin
            
            aluoutarith<={{8{aluoutarith[15]}},{aluin2[6:0]}}; 
            end
            else if (operation == LOADWORD)
            begin
           
            //aluoutarith<={{1{aluoutarith[32]}},{aluin2}};
            aluoutarith<={{1{aluoutarith[15]}},{aluin2}};
            end
    end
    end
 
  
 else 
  if(enable_shift)
      begin
      aluoutshift[15]<=0;
      
      begin
      if(operation==SHLEFTLOG)
      aluoutshift[14:0] <= aluin1<<shift_number;
      else if(operation==SHLEFTART)
      begin 
      aluoutshift[15]<=aluin1[14];
      aluoutshift[14:0] <= aluin1<<<shift_number;
      end
      else if(operation==SHRGHTLOG)
      aluoutshift[14:0] <= aluin1>>shift_number;
      else if(operation==SHRGHTART)
      aluoutshift[14:0]<=aluin1>>>shift_number;
      
      end
      aluoutfinal<=aluoutshift;
      end

   //begin
  
//   case(operation)
//   SHLEFTLOG: aluoutshift[14:0] <= aluin1<<shift_number;
//   SHLEFTART: begin aluoutshift[15]<=aluin1[14];aluoutshift[14:0] <= aluin1<<<shift_number;end
//   SHRGHTLOG: aluoutshift[14:0] <= aluin1>>shift_number;
//   SHRGHTART: aluoutshift[14:0]<=aluin1>>>shift_number;               
             
   
//   endcase
  // end


end //after reset
end //main begin
endmodule
