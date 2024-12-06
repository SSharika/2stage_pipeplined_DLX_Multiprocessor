`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/18/2022 01:46:02 AM
// Design Name: 
// Module Name: fetch_controller
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

module fetch_controller(foutput,operation,opselect,enable_arith,enable_shift,shift_number,aluin1,aluin2,wr_a, mem_data_read_in1,mem_data_read_in2,reset,control_in,datain_a,addr_a, clock, src1, src2,imm);
//module fetch_controller(memfill,foutput,operation,opselect,enable_arith,enable_shift,shift_number,aluin1,aluin2,wr_a,wr_b, mem_data_read_in1,mem_data_read_in2,reset,control_in,datain_a,datain_b,addr_a,addr_b, clock, src1, src2,imm);
parameter n = 16;
wire [n-1:0] dataout_a;//input from dram at corresponding to given address(dataout)
output reg [12:0] addr_a;//reading1 address given to dram
input  wr_a,reset;
output reg [n-1:0]datain_a,mem_data_read_in1,mem_data_read_in2;//output to dram at corresponding to given address(datain)
output  [n-1:0] aluin1,aluin2;
output  [4:0] shift_number;
reg En;
input clock;
output reg [6:0]control_in; 
output reg [n-1:0]src1;
output reg [n-1:0]src2;
output reg [n-1:0]imm;

reg enable_ex;



reg [n-1:0] control_in2;// temporary storages
reg [n-1:0] src12;
reg [n-1:0] src22;
reg [n-1:0] imm2;
reg [n-1:0] mem_data_read_in12;

output  [n-1:0] foutput;
reg [12:0] i1;
reg [12:0] j1;
reg [12:0] k1;
reg [12:0] c1;
integer c=0;
integer i=-1;
integer j=0;
integer k=31;



output   enable_arith,enable_shift;
output [2:0] operation,opselect;
//dual_ports_ram1 ram(.datain_a(datain_a),.datain_b(datain_b),.addr_a(addr_a[12:0]),.addr_b(addr_b[12:0]),.wr_a(wr_a),.wr_b(wr_b),.reset(reset),.clock(clock),.dataout_a(dataout_a),.dataout_b(dataout_b));
new_process np(.enable_arith(enable_arith),.enable_shift(enable_shift),.operation(operation),.opselect(opselect),.shift_number(shift_number),.aluin1(aluin1),.aluin2(aluin2),.clock(clock),.reset(reset),.enable_ex(enable_ex),.imm(imm),.mem_data_read_in1(mem_data_read_in1),.mem_data_read_in2(mem_data_read_in2),.control_in(control_in),.aluoutfinal(foutput));
bram_wrapper
   tb(.BRAM_PORTA_0_addr(addr_a),
    .BRAM_PORTA_0_clk(clock),
    .BRAM_PORTA_0_din(datain_a),
    .BRAM_PORTA_0_dout(dataout_a),
    .BRAM_PORTA_0_en(En),
    .BRAM_PORTA_0_we(wr_a));
//always@(memfill, wr_a)//initially filling memory
//begin
//if(wr_a)
//    begin
//    c1 = c;
//    addr_a<=c1;
//    datain_a<= memfill;
//    if (c<8195)
//    c=c+1;
//    else 
//    c=0;
//    end
//    else begin
//    c=0; end
// c1 = c;
//end

always@(posedge clock)//
   
    begin
   En = 1;
   datain_a = 0;
    if(!wr_a)
    begin
        if(i<8195)
            begin
            
            i=i+1;
                  
            end
        else  
                i=0;    
      end
    else
       begin 
           i=i;
       end 
       i1 = i;        
    end 

 
  

always@(posedge clock)
begin
    if(!wr_a&i>2)
        begin
            if(j<5)
                j=j+1;
               
            else
                j=0;
        end
    else
    begin 
        j=j;
    end
    j1 = j;
end


//read
always@(posedge clock)
begin
if(!wr_a)
    begin
case(j)

//final
//0: begin addr_a<=i;  mem_data_read_in1 <= dataout_a;  end 
//1: begin addr_a<=i; mem_data_read_in2 <= dataout_a;end
//2: begin addr_a<=i; control_in<=dataout_a[6:0];end
//3: begin addr_a<=i;src1<=dataout_a;  end //control_in<=control_in2; src1 <= src12; src2 <= src22; imm<=imm2; end
//4: begin addr_a<= src1;src2<=dataout_a;  end
//5: begin addr_a <= src2;imm<=dataout_a; end
//ek saath bheja
//16 -bit kliye kaam karnewala
//2: begin addr_a<=i;  mem_data_read_in12 <= dataout_a;  end 
//3: begin addr_a<=i;enable_ex=1; mem_data_read_in2 <= dataout_a; control_in<=control_in2[6:0]; src1 <= src12; src2 <= src22; imm<=imm2;mem_data_read_in1 <= mem_data_read_in12; end
//4: begin addr_a<=i; control_in2<=1;end
//5: begin addr_a<=i;src12<=dataout_a;  end //control_in<=control_in2; src1 <= src12; src2 <= src22; imm<=imm2; end
//0: begin addr_a<= src12;src22<=dataout_a;  end
//1: begin addr_a<= src22;imm2<=dataout_a; end
//default:addr_a <= 12'bxxxxxxxxxxxx;
//33-bit kliye 
//0: begin addr_a<=i;  mem_data_read_in12 <= dataout_a;  end 
//1: begin addr_a<=i;enable_ex=1; mem_data_read_in2 <= dataout_a; control_in<=control_in2[6:0]; src1 <= src12; src2 <= src22; imm<=imm2;mem_data_read_in1 <= mem_data_read_in12; end
//2: begin addr_a<=i; control_in2<=dataout_a;end
//3: begin addr_a<=i;src12<=dataout_a;  end //control_in<=control_in2; src1 <= src12; src2 <= src22; imm<=imm2; end
//4: begin addr_a<= src12;src22<=dataout_a;  end
//5: begin addr_a<= src22;imm2<=dataout_a; end
//default:addr_a <= 12'bxxxxxxxxxxxx;

//trial
//1: begin     addr_a<=i;  src12<=dataout_a;  end 
//2: begin     addr_a<=i;  src22<= dataout_a;end
//3: begin addr_a<= src12; imm2<=dataout_a;end
//4: begin   addr_a<= src22;mem_data_read_in12<=dataout_a; end //control_in<=control_in2; src1 <= src12; src2 <= src22; imm<=imm2; end
//5: begin    addr_a<=i;   enable_ex=1; mem_data_read_in2<=dataout_a;mem_data_read_in1<=mem_data_read_in12;  control_in<=control_in2; src1 <= src12; src2 <= src22; imm<=imm2; end
//0: begin     addr_a<=i;   control_in2<=dataout_a;end
//default: addr_a <= 89;
2: begin     addr_a<=i;  src12<=dataout_a;  end 
3: begin     addr_a<=i;  src22<= dataout_a;end
4: begin addr_a<= src12; imm2<=dataout_a;end
5: begin   addr_a<= src22;mem_data_read_in12<=dataout_a; end //control_in<=control_in2; src1 <= src12; src2 <= src22; imm<=imm2; end
0: begin    addr_a<=i;   enable_ex=1; mem_data_read_in2<=dataout_a;mem_data_read_in1<=mem_data_read_in12;  control_in<=control_in2[6:0]; src1 <= src12; src2 <= src22; imm<=imm2; end
1: begin     addr_a<=i;   control_in2<=dataout_a;end
default:begin addr_a <= 89; end 

endcase
    end
else
    begin
//    addr_a= i;
//    datain_a<= dataout_a;
//    if (i<2500)
//    i=i+1;
//    else 
//    i=0;   
    end
end
//always@(foutput)//aluout
//begin
//    addr_b=k;
//    datain_b= foutput;
//        if (k>0)
//        k=k-1;
//        else 
//        begin
//            k=8195;
//        end
//        k1 = k;
//end


endmodule

