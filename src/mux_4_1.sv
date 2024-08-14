// Engineer: Yasser Mohamed
// Create Date: 6/8/2024
// Module Name: mux4to1
// Project Name: RISC_v Processor

module mux4to1 #(parameter N_Bits=32)
(
  input logic [N_Bits-1:0] d0,d1,d2,d3,
  input logic [1:0]sel,
  output logic [N_Bits-1:0] out
);

 assign out = sel[1] ? (sel[0] ? d3 : d2) : (sel[0] ? d1 : d0);
 endmodule
