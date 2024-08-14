// Engineer: Yasser Mohamed
// Create Date: 5/8/2024
// Module Name: Extend
// Project Name: RISC_v Processor

module extend #(parameter N_Bits = 32)
(
	input logic [N_Bits-1:7]Instr,
	input logic [2:0]ImmSrc,
	output logic [N_Bits-1:0]ImmExt
);

always_comb
begin
case(ImmSrc)
	3'b000:
		ImmExt = {{20{Instr[31]}},Instr[31:20]};
	3'b001:
		ImmExt = {{20{Instr[31]}},Instr[31:25],Instr[11:7]};
	3'b010:
		ImmExt = {{20{Instr[31]}},Instr[7],Instr[30:25],Instr[11:8],1'b0};
	3'b011:
		ImmExt =  {{12{Instr[31]}},Instr[19:12],Instr[20],Instr[30:21],1'b0};
	3'b100:
		ImmExt =  {Instr[31:12],{12{1'b0}}};
	default:
	  ImmExt =  32'bx;
endcase
end
endmodule
