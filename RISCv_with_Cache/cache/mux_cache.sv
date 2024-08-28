module mux2_1_cash (
  input  logic        sel,
  input  logic [127:0] input0,
  input  logic [127:0] input1,
  output logic [127:0] out
);

assign out = sel? input1:input0;
endmodule
