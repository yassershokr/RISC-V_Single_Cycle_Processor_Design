module Cache_mem_sys (
  input logic clk,
  input logic rst,
  input logic mem_read,
  input logic mem_write,
  input logic [1:0]storetype,
  input logic [9:0] Address,
  input logic [31:0] DataIn,
  output logic stall,
  output logic [31:0] DataOut
);

  logic [127:0] Read_help, data_in;
  logic [3:0] Tag_v;
  logic hit_or_miss, control_mem_write, control_cache_read;
  logic done,wiring,ok;

  // Instantiate mux2_1_cash
  mux2_1_cash Mux1 (
    .input0(Read_help),
    .input1({96'b0, DataIn}),
    .sel(hit_or_miss),
    .out(data_in)
  );

  // Instantiate cache_memory
  cache_memory Cache_Memory (
    .clk(clk),
    .rst(rst),
    .ok(ok),
    .address(Address),
    .data_in(data_in),
    .hit_or_miss(hit_or_miss),
    .control_mem_write(control_mem_write),
    .control_cache_read(control_cache_read),
    .read_data(DataOut),
    .Tag_v(Tag_v)
  );

  // Instantiate main_memory
  main_memory Main_Memory(
    .clk(clk),
    .data_in(DataIn),
    .address(Address),
    .control_mem_write(mem_write),
    .waring(wiring),
    .storetype(storetype),
    .read_value(Read_help),
    .done(done)
  );

  // Instantiate controller
  cache_controller Cache_Control (
    .clk(clk),
    .rst(rst),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(Address),
    .ok(ok),
    .Tag_v(Tag_v),
    .done(done),
    .hit_or_miss(hit_or_miss),
    .stall(stall),
    .wiring(wiring),
    .control_mem_write(control_mem_write),
    .control_cache_read(control_cache_read)
  );

endmodule