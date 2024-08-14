// Engineer: Yasser Mohamed
// Create Date: 5/8/2024 
// Module Name: ALU Decoder
// Project Name: RISC_v Processor

module alu_decoder
(
	input logic [2:0] funct3,
	input logic funct7,
	input logic op,
	input logic [1:0] ALUOp,
  	output logic [3:0] ALUControl
);

always_comb
begin
  ALUControl=4'b0;
  casex ({ALUOp,funct3,op,funct7})

    7'b00_xxx_x_x,7'b10_000_x_x,7'b11_000_x_0:
	begin
      	   ALUControl = 4'b0000;
    	end 
    7'b01_000_x_x,7'b01_001_x_x,7'b11_000_x_1:
	begin
      	   ALUControl = 4'b0001;
    	end
    7'b01_100_x_x,7'b01_101_x_x,7'b10_010_x_x,7'b11_010_x_x:
	begin
      	   ALUControl = 4'b0101;
   	end
    7'b01_110_x_x,7'b01_111_x_x,7'b10_011_x_x,7'b11_011_x_x:
	begin
      	   ALUControl = 4'b0111;
    	end
    7'b10_100_x_x,7'b11_100_x_x:
	begin
      	   ALUControl = 4'b1100;
    	end
    7'b10_110_x_x,7'b11_110_x_x:
	begin
      	   ALUControl = 4'b0011;
    	end
    7'b10_111_x_x,7'b11_111_x_x:
	begin
      	   ALUControl = 4'b0010;
    	end
    7'b10_001_x_x,7'b11_001_x_x:
	begin
      	   ALUControl = 4'b1110;
    	end
    7'b10_101_x_0,7'b11_101_x_0:
	begin
      	   ALUControl = 4'b1101;
    	end
    7'b10_101_x_1,7'b11_101_x_1:
	begin
      	   ALUControl = 4'b1001;
    	end
    default: 
	begin
      	ALUControl = 4'bxxxx;
    	end
  endcase
end
endmodule

