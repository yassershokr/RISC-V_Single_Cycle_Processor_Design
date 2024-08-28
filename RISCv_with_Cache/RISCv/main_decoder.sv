// Engineer: Yasser Mohamed
// Create Date: 4/8/2024
// Module Name: Main Decoder
// Project Name: RISC_v Processor

module main_decoder
(
	input logic [6:0]Opcode,
	input logic [2:0]funct3,
	input logic Zero,
	input logic Negflag,
	input logic Unsigned_less_than,
	output logic [2:0]ImmSrc,
	output logic ALUSrcA,
	output logic ALUSrcB,
	output logic [1:0]ResultSrc,
	output logic RegWrite,
	output logic [1:0]ALUOp,
	output logic [2:0]Loadtype,
	output logic [1:0]Storetype,
	output logic Jalr,
	output logic PCSrc,
	output logic MemWrite,
	output logic MemRead
);

localparam Load=7'b000_0011,Store=7'b010_0011,Rtype=7'b011_0011,ItypeALU=7'b001_0011,Btype=7'b110_0011,Jal=7'b110_1111,JALR=7'b110_0111,Lui=7'b011_0111,Auipc=7'b001_0111;
always_comb
begin
	case(Opcode)
		Load:
		begin
			ImmSrc=3'b000;
			ALUSrcA=0;
			ALUSrcB=1;
			ResultSrc=2'b01;
			RegWrite=1;
			ALUOp=2'b00;
			Jalr=0;
			Storetype=2'b10;
			PCSrc=0;
			MemWrite=0;
			MemRead=1;
			case(funct3)
				3'b000:
					Loadtype=3'b010;
				3'b001:
					Loadtype=3'b001;
				3'b010:
					Loadtype=3'b000;
				3'b100:
					Loadtype=3'b100;
				3'b101:
					Loadtype=3'b011;
			endcase
		end
		Store:
		begin
			ImmSrc=3'b001;
			ALUSrcA=0;
			ALUSrcB=1;
			ResultSrc=2'bxx;
			RegWrite=0;
			ALUOp=2'b00;
			Loadtype=3'b000;
			Jalr=0;
			PCSrc=0;
			MemWrite=1;
			MemRead=0;
			case(funct3)
				3'b000:
					Storetype=2'b00;
				3'b001:
					Storetype=2'b01;
				3'b010:
					Storetype=2'b10;

			endcase
		end
		Rtype:
		begin
			ImmSrc=3'bxxx;
			ALUSrcA=0;
			ALUSrcB=0;
			ResultSrc=2'b00;
			RegWrite=1;
			ALUOp=2'b11;
			Loadtype=3'b000;
			Storetype=2'b10;
			Jalr=0;
			PCSrc=0;
			MemWrite=0;
			MemRead=0;
		end
		ItypeALU:
		begin
			ImmSrc=3'b000;
			ALUSrcA=0;
			ALUSrcB=1;
			ResultSrc=2'b00;
			RegWrite=1;
			ALUOp=2'b10;
			Loadtype=3'b000;
			Storetype=2'b10;
			Jalr=0;
			PCSrc=0;
			MemWrite=0;
			MemRead=0;
		end
		Btype:
		begin
			ImmSrc=3'b010;
			ALUSrcA=0;
			ALUSrcB=0;
			ResultSrc=2'bxx;
			RegWrite=0;
			ALUOp=2'b01;
			Loadtype=3'bxxx;
			Storetype=2'b10;
			Jalr=0;
			MemWrite=0;
			MemRead=0;
			case(funct3)
				3'b000:
					PCSrc=Zero;
				3'b001:
					PCSrc=~Zero;
				3'b100:
					PCSrc=Negflag;
				3'b101:
					PCSrc=~Negflag;
				3'b110:
					PCSrc=Unsigned_less_than;
				3'b111:
					PCSrc=~Unsigned_less_than;
			endcase
		end
		Jal:
		begin
			ImmSrc=3'b011;
			ALUSrcA = 'bx;
			ALUSrcB = 'bx;
			ResultSrc=2'b10;
			RegWrite=1;
			ALUOp=2'b10;
			Loadtype=3'b000;
			Storetype=2'b10;
			Jalr=0;
			PCSrc=1;
			MemWrite=0;
			MemRead=0;
		end
		JALR:
		begin
			ImmSrc=3'b000;
			ALUSrcA=0;
			ALUSrcB=1;
			ResultSrc=2'b10;
			RegWrite=1;
			ALUOp=2'b00;
			Loadtype=3'b000;
			Storetype=2'b10;
			Jalr=1;
			PCSrc='bx;
			MemWrite=0;
			MemRead=0;
		end
		Lui:
		begin
			ImmSrc=3'b100;
			ALUSrcA='bx;
			ALUSrcB='bx;
			ResultSrc=2'b11;
			RegWrite=1;
			ALUOp=2'bxx;
			Loadtype=3'b000;
			Storetype=2'b10;
			Jalr=0;
			PCSrc=0;
			MemWrite=0;
			MemRead=0;
		end
		Auipc:
		begin
			ImmSrc=3'b100;
			ALUSrcA=1;
			ALUSrcB=1;
			ResultSrc=2'b00;
			RegWrite=1;
			ALUOp=2'b00;
			Loadtype=3'b000;
			Storetype=2'b10;
			Jalr=0;
			PCSrc=0;
			MemWrite=0;
			MemRead=0;
		end
		default:
		begin
			ImmSrc=3'bxxx;
			ALUSrcA='bx;
			ALUSrcB='bx;
			ResultSrc=2'bxx;
			RegWrite='bx;
			ALUOp=2'bxx;
			Loadtype=3'bxxx;
			Storetype=2'bxx;
			Jalr='bx;
			PCSrc='bx;
			MemWrite='bx;
			MemRead='bx;
		end
endcase

end
endmodule

