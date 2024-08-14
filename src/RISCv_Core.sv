// Engineer: Yasser Mohamed
// Create Date: 7/8/2024
// Module Name: RISC_v core
// Project Name: RISC_v Processor

module RISCv_core
(
	input clk,rst,
	input logic [31:0] Instr,
 	input logic [31:0] ReadData,
	output logic [31:0] PC,
	output logic [31:0] ALUResult,
	output logic [31:0] WriteData,
	output logic MemWrite,
	output logic [1:0]Storetype
);

	 logic [2:0]ImmSrc;
	 logic ALUSrcA;
	 logic ALUSrcB;
	 logic [1:0]ResultSrc;
	 logic RegWrite;
	 logic [2:0]Loadtype;
	 logic Jalr;
	 logic PCSrc;
	 logic [3:0] ALUControl;
	 logic Zero;
	 logic Negflag;
	 logic Unsigned_less_than;

datapath #(.N_Bits(32)) DataPath
(
	.clk(clk),
	.rst(rst),
	.ImmSrc(ImmSrc),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.ResultSrc(ResultSrc),
	.RegWrite(RegWrite),
	.Loadtype(Loadtype),
	.Jalr(Jalr),
	.PCSrc(PCSrc),
	.MemWrite(MemWrite),
 	.ALUControl(ALUControl),
  .Instr(Instr),
 	.ReadData(ReadData),
	.Zero(Zero),
	.Negflag(Negflag),
	.Unsigned_less_than(Unsigned_less_than),
	.PC(PC),
	.ALUResult(ALUResult),
	.WriteData(WriteData)
);

control_unit Control_Unit
(
	.Instr(Instr),
	.Zero(Zero),
	.Negflag(Negflag),
	.Unsigned_less_than(Unsigned_less_than),
	.ImmSrc(ImmSrc),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.ResultSrc(ResultSrc),
	.RegWrite(RegWrite),
	.Loadtype(Loadtype),
	.Storetype(Storetype),
	.Jalr(Jalr),
	.PCSrc(PCSrc),
	.MemWrite(MemWrite),
 	.ALUControl(ALUControl)
);

endmodule