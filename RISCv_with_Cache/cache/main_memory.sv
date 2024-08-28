module main_memory(
    input  logic        clk,
    input  logic [31:0] data_in,
    input  logic [9:0]  address,
    input  logic        control_mem_write,
    input  logic        waring,
    input  logic [1:0]  storetype,   // 00: byte, 01: halfword, 10: word
    output logic [127:0] read_value,
    output logic        done
);

    logic [31:0] memory [0:1023];  // Memory array
    int countOFMem = 0;            // Counter for memory operations

    // Read memory values based on address
    assign read_value[31:0]   = memory[{address[9:2], 2'b00}];
    assign read_value[63:32]  = memory[{address[9:2], 2'b01}];
    assign read_value[95:64]  = memory[{address[9:2], 2'b10}];
    assign read_value[127:96] = memory[{address[9:2], 2'b11}];

    // Sequential logic block
    always_ff @(posedge clk) begin
        done <= 0;
        
        if (control_mem_write) begin
            case (storetype)
                2'b00: begin
                    // Byte store
                    memory[address][7:0] <= data_in[7:0];
                end
                2'b01: begin
                    // Halfword store
                    memory[address][15:0] <= data_in[15:0];
                end
                2'b10: begin
                    // Word store
                    memory[address] <= data_in;
                end
                default: begin
                    // No operation
                end
            endcase
            countOFMem <= countOFMem + 1;
            done <= 0;
            
            if (countOFMem == 3) begin
                countOFMem <= 0;
                done <= 1;
            end
            else if (done) begin
                countOFMem <= 0;
            end
        end
        
        if (waring) begin
            countOFMem <= countOFMem + 1;
            done <= 0;
            
            if (countOFMem == 3) begin
                countOFMem <= 0;
                done <= 1;
            end
            else if (done) begin
                countOFMem <= 0;
            end
        end
    end

endmodule

