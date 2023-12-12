//------------------------------------------------------------------------------
// Company: 		 UIUC ECE Dept.
// Engineer:		 Stephen Kempf
//
// Create Date:    
// Design Name:    ECE 385 Lab 5 Given Code - SLC-3 top-level (Physical RAM)
// Module Name:    SLC3
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 09-22-2015 
//    Revised 06-09-2020
//	  Revised 03-02-2021
//------------------------------------------------------------------------------


module slc3(
	input logic [9:0] SW,
	input logic	Clk, Reset, Run, Continue,
	output logic [9:0] LED,
	input logic [15:0] Data_from_SRAM,
	output logic OE, WE,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3,
	output logic [15:0] ADDR,
	output logic [15:0] Data_to_SRAM
);


// An array of 4-bit wires to connect the hex_drivers efficiently to wherever we want
// For Lab 1, they will direclty be connected to the IR register through an always_comb circuit
// For Lab 2, they will be patched into the MEM2IO module so that Memory-mapped IO can take place

logic [3:0] hex_4[3:0]; 
HexDriver hex_drivers[3:0] (hex_4, {HEX3, HEX2, HEX1, HEX0});

// This works thanks to http://stackoverflow.com/questions/1378159/verilog-can-we-have-an-array-of-custom-modules




// Internal connections
logic LD_MAR, LD_MDR, LD_IR, LD_BEN, LD_CC, LD_REG, LD_PC, LD_LED;
logic GatePC, GateMDR, GateALU, GateMARMUX;
logic SR2MUX, ADDR1MUX, MARMUX;
logic BEN, MIO_EN, DRMUX, SR1MUX;
logic [1:0] PCMUX, ADDR2MUX, ALUK;
logic [15:0] MDR_In;
logic [15:0] MAR, MDR, IR, PC, ALU; /*I added PC and ALU*/


// My connections
logic [15:0] PC_Val;
logic [15:0] BusOut, PC_MuxOut, MIO_EN_Out;


// Connect MAR to ADDR, which is also connected as an input into MEM2IO
//	MEM2IO will determine what gets put onto Data_CPU (which serves as a potential
//	input into MDR)
assign ADDR = MAR; 
assign MIO_EN = OE;
// Connect everything to the data path (you have to figure out this part)
datapath d0 (.*);

// Our SRAM and I/O controller (note, this plugs into MDR/MAR)

Mem2IO memory_subsystem(
    .*, .Reset(Reset), .ADDR(ADDR), .Switches(SW),
    .HEX0(hex_4[0][3:0]), .HEX1(hex_4[1][3:0]), .HEX2(hex_4[2][3:0]), .HEX3(hex_4[3][3:0]),
//	 .HEX0(), .HEX1(), .HEX2(), .HEX3(),
    .Data_from_CPU(MDR), .Data_to_CPU(MDR_In),
    .Data_from_SRAM(Data_from_SRAM), .Data_to_SRAM(Data_to_SRAM)
);

// State machine, you need to fill in the code here as well
ISDU state_controller(
	.*, .Reset(Reset), .Run(Run), .Continue(Continue),
	.Opcode(IR[15:12]), .IR_5(IR[5]), .IR_11(IR[11]),
   .Mem_OE(OE), .Mem_WE(WE)
);


//Bus_Module Bus1(.inputPC(PC_Val),
//					 .inputMAR(MAR),
//					 .inputMDR(MDR),
//					 .inputALU(),
//					 .GatePC,
//					 .GateALU,
//					 .GateMDR,
//					 .GateMAR(GateMARMUX),
//					 .Bus_Out(BusOut));
//
//mux_3_1_16 PCMux(.A(PC_Val + 1'b1),
//					  .B(BusOut),
//					  .C(),
//					  .SelectBit(PCMUX),
//					  .Out(PC_MuxOut));
//
//					 
//reg_unit #(.N(16)) PC_Reg(.Clk,
//								  .Reset,
//								  .Load(LD_PC),
//								  .Din(PC_MuxOut),
//								  .Data_Out(PC_Val));
//				  
//reg_unit #(.N(16)) MAR_Reg(.Clk,
//								   .Reset,
//								   .Load(LD_MAR),
//								   .Din(BusOut),
//								   .Data_Out(MAR));
//					
//mux_2_1_16	#(.N(16)) MIO_MUX(.A(MDR_In),
//										.B(BusOut),
//										.SelectBit(MIO_EN),
//										.Out(MIO_EN_Out));
//					
//reg_unit #(.N(16)) MDR_Reg(.Clk,
//								   .Reset,
//								   .Load(LD_MDR),
//								   .Din(MIO_EN_Out),
//								   .Data_Out(MDR));
//					
//reg_unit #(.N(16)) IR_Reg(.Clk,
//								  .Reset,
//								  .Load(LD_IR),
//								  .Din(BusOut),
//								  .Data_Out(IR));
//					
//					
//HexDriver		IRHEX0 (.In0(IR[3:0]),  .Out0(HEX0));
//HexDriver		IRHEX1 (.In0(IR[7:4]),  .Out0(HEX1));
//HexDriver		IRHEX2 (.In0(IR[11:8]), .Out0(HEX2));
//HexDriver		IRHEX3 (.In0(IR[15:12]),.Out0(HEX3));

// SRAM WE register
//logic SRAM_WE_In, SRAM_WE;
//// SRAM WE synchronizer
//always_ff @(posedge Clk or posedge Reset_ah)
//begin
//	if (Reset_ah) SRAM_WE <= 1'b1; //resets to 1
//	else 
//		SRAM_WE <= SRAM_WE_In;
//end

	
endmodule
