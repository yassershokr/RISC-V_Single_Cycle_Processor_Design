// Engineer: Yasser Mohamed
// Create Date: 7/8/2024
// Module Name: RISC_v top
// Project Name: RISC_v Processor

module Single_Cycle_Top(
			input logic clk,rst
			);
   logic [31:0] WriteData,ALUResult;
   logic MemWrite,MemRead;
   logic [31:0] PC, Instr, ReadData;
   logic [1:0] Storetype;
   logic stall;
   RISCv_core core (
			       .clk(clk),
			       .rst(rst),
			       .stall(stall),
			       .Instr(Instr),
			       .ReadData(ReadData),
			       .PC(PC),
			       .MemWrite(MemWrite),
			       .Storetype(Storetype),
			       .ALUResult(ALUResult),
			       .WriteData(WriteData),
			       .MemRead(MemRead));

   instrution_memory #(.N_Bits(32)) Instr_Memory 
   ( 
				     .A(PC),
				     .RD(Instr));

  /* Data_Memory  #(.N_Bits(32)) Data_Memory 
   (
			    .clk(clk), 
			    .WE(MemWrite),
			    .Storetype(Storetype), 
			    .A(ALUResult), 
			    .WD(WriteData),
			    .RD(ReadData) );
*/

Cache_mem_sys cache(
  				.clk(clk),
  				.rst(rst),
  				.mem_read(MemRead),
 				.mem_write(MemWrite),
			        .storetype(Storetype), 
  				.Address(ALUResult[9:0]),
  				.DataIn(WriteData),
  				.stall(stall),
  				.DataOut(ReadData)
);
endmodule

