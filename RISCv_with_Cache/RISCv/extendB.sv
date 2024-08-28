// Engineer: Yasser Mohamed
// Create Date: 5/8/2024
// Module Name: ExtendB
// Project Name: RISC_v Processor

module extendB #(parameter N_Bits = 32)
(
	input logic [N_Bits-1:0]Result,
	input logic [2:0]Loadtype,
	output logic [N_Bits-1:0]Resultafter
);

always_comb
begin
case(Loadtype)
	3'b010:
		Resultafter = {{24{Result[31]}},Result[7:0]};
	3'b001:
		Resultafter = {{16{Result[31]}},Result[15:0]};
	3'b000:
		Resultafter = Result;
	3'b100:
		Resultafter =  {{24{1'b0}},Result[7:0]};
	3'b011:
		Resultafter =  {{16{1'b0}},Result[15:0]};
	default:
		Resultafter = Result;
endcase
end
endmodule

