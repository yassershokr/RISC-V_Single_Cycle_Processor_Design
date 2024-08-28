// Engineer: Yasser Mohamed
// Create Date: 5/8/2024 
// Module Name: Program Counter
// Project Name: RISC_v Processor

module Program_Counter #(parameter N_Bits=32)
(
  input logic clk,rst,
  input logic [N_Bits-1:0] PC_next,
  output logic [N_Bits-1:0] PC
);
logic [N_Bits-1:0] Q_reg;

always_ff @(posedge clk or negedge rst) 
begin
if (~rst) 
	begin
  	   Q_reg <= 'b0;
	end 
else
	begin
  	   Q_reg <= PC_next;
	end
end

assign PC = Q_reg;

endmodule


