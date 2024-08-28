// Engineer: Yasser Mohamed
// Create Date: 5/8/2024 
// Module Name: Register File
// Project Name: RISC_v Processor

module register_file #(parameter N_Bits = 32)
(
	input logic clk,
	input logic [N_Bits-1:0]WD3,
	input logic [4:0]A1,A2,A3,
	input logic WE3,
	output logic [N_Bits-1:0]RD1,RD2
);
logic [N_Bits-1:0] registers [N_Bits-1:0];

always_ff @(posedge clk)
begin   
  if (WE3) 
    begin
    registers[A3] <= WD3;
    end 
  else 
    begin
    registers[A3] <= registers[A3];
    end
end
always_comb
begin
 RD1 = (A1 != 0) ? registers[A1] : 0;
 RD2 = (A2 != 0) ? registers[A2] : 0;
 end
endmodule

