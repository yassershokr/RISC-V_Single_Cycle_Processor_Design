// Engineer: Yasser Mohamed
// Create Date: 6/8/2024 
// Module Name: Control_Unit
// Project Name: RISCv Processor

module control_unit
(
	input logic [31:0]Instr,
	input logic Zero,
	input logic Negflag,
	input logic Unsigned_less_than,
	output logic [2:0]ImmSrc,
	output logic ALUSrcA,
	output logic ALUSrcB,
	output logic [1:0]ResultSrc,
	output logic RegWrite,
	output logic [2:0]Loadtype,
	output logic [1:0]Storetype,
	output logic Jalr,
	output logic PCSrc,
	output logic MemWrite,
	output logic MemRead,
  	output logic [3:0] ALUControl
);

logic [1:0]ALUOp;

main_decoder Main_decoder
(
	.Opcode(Instr[6:0]),
	.funct3(Instr[14:12]),
	.Zero(Zero),
	.Negflag(Negflag),
	.Unsigned_less_than(Unsigned_less_than),
	.ImmSrc(ImmSrc),
	.ALUSrcA(ALUSrcA),
	.ALUSrcB(ALUSrcB),
	.ResultSrc(ResultSrc),
	.RegWrite(RegWrite),
	.ALUOp(ALUOp),
	.Loadtype(Loadtype),
	.Storetype(Storetype),
	.Jalr(Jalr),
	.PCSrc(PCSrc),
	.MemWrite(MemWrite),
	.MemRead(MemRead)
);
alu_decoder ALU_decoder
(
	.funct3(Instr[14:12]),
	.funct7(Instr[30]),
	.op(Instr[5]),
	.ALUOp(ALUOp),
 	.ALUControl(ALUControl)
);
endmodule

