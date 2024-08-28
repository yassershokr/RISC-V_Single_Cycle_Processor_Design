// Engineer: Yasser Mohamed
// Create Date: 5/8/2024 
// Module Name: Instruction Memory
// Project Name: RISC_v Processor

module instrution_memory #(parameter N_Bits = 32)
(
	input logic [N_Bits-1:0]A,
	output logic [N_Bits-1:0]RD
);
logic [N_Bits-1:0] ROM [0:255]; 
integer i;

initial 
begin
  ROM[0] =32'h00500113 ;
  ROM[1] =32'h00C00193 ;
  ROM[2] =32'hFF718393 ;
  ROM[3] =32'h0023E233 ;
  ROM[4] =32'h0041F2B3 ;
  ROM[5] =32'h004282B3 ;
  ROM[6] =32'h02728863 ;
  ROM[7] =32'h0041A233 ;
  ROM[8] =32'h00020463 ;
  ROM[9] =32'h00000293 ;
  ROM[10] =32'h0023A233 ;
  ROM[11] =32'h005203B3 ;
  ROM[12] =32'h402383B3 ;
  ROM[13] =32'h0471AA23 ;
  ROM[14] =32'h06002103 ;
  ROM[15] =32'h005104B3 ;
  ROM[16] =32'h008001EF ;
  ROM[17] =32'h00100113 ;
  ROM[18] =32'h00910133 ;
  ROM[19] =32'h0221A023 ;
  ROM[20] =32'h00210063 ;
  for (i =21 ;i<256 ;i=i+1 ) 
	begin
    	  ROM[i]=32'b0;
  	end
end
 
  assign  RD = ROM[A>>2];

endmodule



