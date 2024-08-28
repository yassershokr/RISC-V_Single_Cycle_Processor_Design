module Single_Cycle_TB();

logic clk = 0, rst;

always #5 clk = ~clk;

Single_Cycle_Top DUT(
	.clk(clk),
	.rst(rst)
);
  
initial begin
    #20; rst = 1; 
    #20; rst = 0; 
	#20; rst = 1;
end

endmodule

