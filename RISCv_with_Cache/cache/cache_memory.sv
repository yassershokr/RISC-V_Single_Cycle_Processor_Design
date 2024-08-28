module cache_memory(
    input  logic        clk,
    input  logic        rst,
    input  logic [9:0]  address,
    input  logic [127:0] data_in,
    input  logic        hit_or_miss,
    input  logic        control_mem_write,
    input  logic        control_cache_read,
    input  logic        ok,
    output logic [31:0] read_data,
    output logic [3:0]  Tag_v
);

    // Memory with 4 bits extra for tag and valid bit
    logic [131:0] mem [0:31]; 
    logic [4:0] stored;
    int i;       

    assign Tag_v = mem[address[6:2]][131:128];
    assign stored = address[6:2];

    // Synchronous logic for memory operations
    always_ff @(posedge clk or negedge rst) begin
        if (~rst) begin
            for (i = 0; i < 32; i = i + 1) begin
                mem[i][131:128] <= 4'b0;  // Reset all tag and valid bits
            end
        end else begin
            // Write operation
            if (control_mem_write & hit_or_miss) begin  // Hit condition
                case (address[1:0])
                    2'b00: mem[stored][31:0]   <= data_in[31:0];
                    2'b01: mem[stored][63:32]  <= data_in[31:0];
                    2'b10: mem[stored][95:64]  <= data_in[31:0];
                    2'b11: mem[stored][127:96] <= data_in[31:0];
                endcase
            end
            // Reading and updating cache on miss
            else if (control_cache_read & hit_or_miss==0) begin
                mem[stored][127:0]   <= data_in;  // Store block in cache
                mem[stored][128]     <= 1'b1;     // Set valid bit
                mem[stored][131:129] <= address[9:7];  // Update tag
            end
        end
    end

    // Combinational logic for reading data from cache
    always_comb begin
        if (control_cache_read) begin
            case (address[1:0])
                2'b00: read_data = mem[stored][31:0];
                2'b01: read_data = mem[stored][63:32];
                2'b10: read_data = mem[stored][95:64];
                2'b11: read_data = mem[stored][127:96];
            endcase
        end else begin
            read_data = 32'b0;  // Default value when not reading
        end
    end

endmodule
