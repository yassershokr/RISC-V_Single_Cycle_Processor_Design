// Engineer: Yasser Mohamed
// Create Date: 6/8/2024 
// Module Name: Data Path
// Project Name: RISCv Processor

module datapath #(parameter N_Bits = 32)
(
	input logic clk,rst,stall,
	input logic [2:0]ImmSrc,
	input logic ALUSrcA,
	input logic ALUSrcB,
	input logic [1:0]ResultSrc,
	input logic RegWrite,
	input logic [2:0]Loadtype,
	input logic Jalr,
	input logic PCSrc,
	input logic MemWrite,
 	input logic [3:0] ALUControl,
 	input logic [N_Bits-1:0] Instr,
 	input logic [N_Bits-1:0] ReadData,
	output logic Zero,
	output logic Negflag,
	output logic Unsigned_less_than,
	output logic [N_Bits-1:0] PC,
	output logic [N_Bits-1:0] ALUResult,
	output logic [N_Bits-1:0] WriteData
);

logic [N_Bits-1:0]PCNext,PCNextafter,PCNextbefore,PCPlus4,ImmExt,PCtarget,Resultbefore,Resultafter,SrcA,SrcAbefore,SrcB,LUI;

mux2to1 #(.N_Bits(32)) mux1
(
  	.input0(PCPlus4),
  	.input1(PCtarget),
  	.sel(PCSrc),
 	.out(PCNext)
);

mux2to1 #(.N_Bits(32)) mux2
(
 	.input0(PCNext),
 	.input1({ALUResult[N_Bits-1:1],1'b0}),
  	.sel(Jalr),
 	.out(PCNextafter)
);

mux2to1 #(.N_Bits(32)) mux6
(
 	.input0(PCNextafter),
 	.input1(PC),
  	.sel(stall),
 	.out(PCNextbefore)
);

Program_Counter #(.N_Bits(32)) counter
(
	.clk(clk),
	.rst(rst),
	.PC_next(PCNextbefore),
	.PC(PC)
);

adder #(.N_Bits(32)) adding4
(
	.input1(PC),
	.input2(32'h00000004),
	.out(PCPlus4)
);

register_file #(.N_Bits(32)) Register_File
(
	.clk(clk),
	.WD3(Resultafter),
	.A1(Instr[19:15]),
	.A2(Instr[24:20]),
	.A3(Instr[11:7]),
	.WE3(RegWrite),
	.RD1(SrcAbefore),
	.RD2(WriteData)
);

mux2to1 #(.N_Bits(32)) mux3
(
 	.input0(SrcAbefore),
 	.input1(PC),
  	.sel(ALUSrcA),
 	.out(SrcA)
);

mux2to1 #(.N_Bits(32)) mux4
(
 	.input0(WriteData),
 	.input1(ImmExt),
  	.sel(ALUSrcB),
 	.out(SrcB)
);

alu #(.N_Bits(32)) ALU
(
	.SrcA(SrcA),
	.SrcB(SrcB),
	.ALUControl(ALUControl),
	.Zero(Zero),
	.Negflag(Negflag),
	.Unsigned_less_than(Unsigned_less_than),
	.ALUResult(ALUResult)
);

mux4to1 #(.N_Bits(32)) mux5
(
	.d0(ALUResult),
	.d1(ReadData),
	.d2(PCPlus4),
	.d3(ImmExt),
	.sel(ResultSrc),
	.out(Resultbefore)
);

extendB #(.N_Bits(32)) ExtendB
(
	.Result(Resultbefore),
	.Loadtype(Loadtype),
	.Resultafter(Resultafter)
);

adder #(.N_Bits(32))adder1
(
	.input1(PC),
	.input2(ImmExt),
	.out(PCtarget)
);

extend #(.N_Bits(32)) extend
(
	.Instr(Instr[31:7]),
	.ImmSrc(ImmSrc),
	.ImmExt(ImmExt)
);

endmodule

