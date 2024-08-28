module cache_controller(
    input logic clk,
    input logic mem_read,
    input logic mem_write,
    input logic rst,
    input logic [9:0] address,
    input logic done,
    input logic [3:0] Tag_v,
    output logic hit_or_miss,
    output logic stall,
    output logic wiring,
    output logic control_mem_write,
    output logic control_cache_read,
    output logic ok
);

    // State definition using typedef enum
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        READ = 2'b01,
        WRITING = 2'b10
    } state_t;

    // State registers
    state_t present_state, next_state;
    logic hits;

    // State transition on clock edge and reset
    always_ff @(posedge clk or negedge rst) begin
        if (~rst) begin
            present_state <= IDLE;
            stall <= 1'b0;
            ok <= 1'b1;
        end else begin
            present_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = present_state;  // Default to stay in current state

        case (present_state)
            IDLE: begin
                if (mem_read)
                    next_state = READ;
                else if (mem_write)
                    next_state = WRITING;
            end

            WRITING: begin
                if (mem_read)
                    next_state = READ;
                else if (mem_write)
                    next_state = WRITING;
                else
                    next_state = IDLE;
            end

            READ: begin
                if (mem_read)
                    next_state = READ;
                else if (mem_write)
                    next_state = WRITING;
                else
                    next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always_comb begin
        // Default values for outputs
        hit_or_miss = 1'b0;
        control_mem_write = 1'b0;
        control_cache_read = 1'b0;
        wiring = 1'b0;

        case (present_state)
            IDLE: begin
                // Outputs remain as default
            end

            WRITING: begin
                control_mem_write = 1'b1;
                if (Tag_v[0] == 1'b1 && Tag_v[3:1] == address[9:7]) begin
                    hit_or_miss = 1'b1;
                end
            end

            READ: begin
                control_cache_read = 1'b1;
                if (Tag_v[0] == 1'b1 && Tag_v[3:1] == address[9:7] && ok == 1'b1) begin
                    hit_or_miss = 1'b1;
                    wiring = 1'b0;
                end else begin
                    wiring = 1'b1;
                end
            end
        endcase
    end

    // Stall and ok signal update logic
    always_ff @(posedge clk) begin
        case (next_state)
            IDLE: begin
                ok <= 1'b1;
                stall <= 1'b0;
            end

            WRITING: begin
                stall <= 1'b1;
                if (done)
                    stall <= 1'b0;
            end

            READ: begin
                if (Tag_v[0] == 1'b1 && Tag_v[3:1] == address[9:7] && ok == 1'b1) begin
                    stall <= 1'b0;
                    ok <= 1'b1;
                end else begin
                    stall <= 1'b1;
                    ok <= 1'b0;
                    if (done) begin
                        stall <= 1'b0;
                        ok <= 1'b1;
                    end
                end
            end
        endcase
    end

endmodule
