// Engineer: Yasser Mohamed
// Create Date: 2/8/2024 
// Module Name: ALU
// Project Name: RISC_v Processor

module alu #(parameter N_Bits =32)
(
	input logic [N_Bits-1:0] SrcA,SrcB,
	input logic [3:0] ALUControl,
	output logic Zero,
	output logic Negflag,
	output logic Unsigned_less_than,
	output logic [N_Bits-1:0]ALUResult	
);
logic [N_Bits-1:0]ALUResultreg;
always_comb
begin
ALUResultreg='b0;
Unsigned_less_than=0;
case(ALUControl)
	4'b0000:
		begin
		ALUResultreg = SrcA + SrcB;
		end
	4'b0001:
		begin
		ALUResultreg = SrcA - SrcB;
		end
	4'b0010:
		begin
		ALUResultreg = SrcA & SrcB;
		end
	4'b0011:
		begin
		ALUResultreg = SrcA | SrcB;
		end
	4'b1100:
		begin
		ALUResultreg = SrcA ^ SrcB;
		end
	4'b0111:
		begin
		ALUResultreg = (SrcA<SrcB)?1:0;
		Unsigned_less_than = 1;
		end
	4'b0101:
		begin
		ALUResultreg = (SrcA<SrcB)?1:0;
		Unsigned_less_than = 0;
		end
	4'b1110:
		begin
		ALUResultreg = SrcA << SrcB;
		end
	4'b1101:
		begin
		ALUResultreg = SrcA >> SrcB;
		end
	4'b1001:
		begin
		ALUResultreg = SrcA >>> SrcB;
		end
	default:
		begin
		ALUResultreg = 'bx;
		Unsigned_less_than = 0;
		end
endcase
end
assign Zero = (ALUResultreg == 32'b0);
assign ALUResult = ALUResultreg;
endmodule

