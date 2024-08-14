// Engineer: Yasser Mohamed
// Create Date: 28/9/2023 
// Module Name: Adder
// Project Name: RISC_v Processor

module adder #(parameter N_Bits = 32)
(
	input logic [N_Bits-1:0]input1,input2,
	output logic [N_Bits-1:0]out
);

assign out = input1+input2;
endmodule
