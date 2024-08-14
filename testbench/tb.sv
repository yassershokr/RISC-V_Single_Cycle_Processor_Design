module Single_Cycle_TB();

logic clk = 0, rst;
logic [31:0] WriteData, ALUResult;
logic MemWrite;

always #5 clk = ~clk;

Single_Cycle_Top DUT(
	.clk(clk),
	.rst(rst),
	.WriteData(WriteData),
	.ALUResult(ALUResult),
	.MemWrite(MemWrite)
);
  
initial begin
    #20; rst = 1; 
    #20; rst = 0; 
	#20; rst = 1;
end


always@(posedge clk)  begin
    if(MemWrite) begin
      if(ALUResult == 100 & WriteData == 25) begin
        $display("PASSED: Data 25 written when Data Address is 100");
        $stop;
      end else if (ALUResult != 96) begin
        $display("FAILED");
        $stop;
      end
    end
end

endmodule
