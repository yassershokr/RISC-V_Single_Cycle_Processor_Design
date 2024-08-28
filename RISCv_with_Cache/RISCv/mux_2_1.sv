
// Engineer: Yasser Mohamed
// Create Date: 5/8/2024 
// Module Name: Mux 2 to 1
// Project Name: RISC_v Processor

module mux2to1 #(parameter N_Bits=32) 
(
  input logic [N_Bits-1:0] input0,input1,
  input logic sel,
  output logic [N_Bits-1:0] out
);
assign out = sel? input1:input0;
endmodule 
