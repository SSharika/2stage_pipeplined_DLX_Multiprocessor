# 2stage_pipeplined_DLX_Multiprocessor

What is a DLX Multiprocessor?

The DUT consists of a two stages pipeline that consists of an Execute pre-processor and an ALU based on a modification to the DLX ISA.

The preprocessor performs the function of the preparation of the design inputs and controls for the ALU using the information seen at the input.

Each unit is globaly clocked and reset.


Fetch Controller:

The fetch controller is the main module of our design which controls the data exchange between the memory and the processor unit

Sends the values from the memory block, from the respective addresses, to the executable preprocessor for functioning operations at the appropriate time

Involves multiple always blocks for simultaneous functioning of various actions


The Stage 1 is the Execute Preprocessor

There is a control_in which is 7 bit signal which consists of - 
Operation(3 bits)
OpSelect(3 bits)
immp_regn(1 bit)

The ALU Stage is divided into 2: Arithmetic ALU and Shift ALU

Arithmwtic ALU is further divided into - 
ARITH_LOGIC
MEM_READ

ARITH_LOGIC

It comprises various operations such as-

ADD - signed addition of aluin1 and aluin2
HADD - addition of 7 bits of aluin1 and aluin2
SUB - subtraction of aluin2 from aluin1
NOT - Bitwise NOT of aluin2
AND - Bitwise AND of aluin1 and aluin2
OR - Bitwise OR of aluin1 and aluin2
XOR - Bitwise XOR of aluin1 and aluin2
LHG - It copies the first 7 bits of aluin2 to the [14:8] of aluout and pad the first 8 bits of aluout to 0 and also set carry equals to 0 which is the last bit of aluout.

MEM_READ

It comprises of various shifting functions
LOADBYTE 
LOADBYTEU 
LOADHALF 
LOADHALFU 
LOADWORD 
Others 

SHIFT_ALU

The shift unit is a part of the ALU stage of the processor. It performs the shifting operation on the 15 bit input number. 

The shift_op input has 4 states -.
SHLEFTLOG  
SHLEFTARITH 
SHRGHTLOG 
SHRGHTARITH 

The 16th carry bit is 0 for SHLEFTLOG, SHRGHTLOG and SHRGHTARITH.











