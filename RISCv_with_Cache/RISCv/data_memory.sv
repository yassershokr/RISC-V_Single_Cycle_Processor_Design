// Engineer: Yasser Mohamed
// Create Date: 5/8/2024 
// Module Name: Data Memory
// Project Name: RISC_v Processor

module Data_Memory #(parameter N_Bits = 32)
(
    input  logic clk,
    input  logic WE,   // Memory write enable
    input  logic [1:0] Storetype,    // Memory access size: 00-byte, 01-half, 10-word
    input  logic [N_Bits-1:0] A,        // Memory address
    input  logic [N_Bits-1:0] WD,  // Data to write
    output logic [N_Bits-1:0] RD    // Data read from memory
);

    logic [N_Bits-1:0] memory [63:0];

    // Memory read operation
    always_comb begin
        RD = memory[A[31:2]];
    end

    // Memory write operation
    always_ff @(posedge clk) begin
        if (WE) begin
            case (Storetype)
                2'b00: // Byte write
                    memory[A[31:2]] <= (A[1:0] == 2'b00) ? {memory[A[31:2]][31:8], WD[7:0]} :
                                       (A[1:0] == 2'b01) ? {memory[A[31:2]][31:16], WD[7:0], memory[A[31:2]][7:0]} :
                                       (A[1:0] == 2'b10) ? {memory[A[31:2]][31:24], WD[7:0], memory[A[31:2]][15:0]} :
                                       {WD[7:0], memory[A[31:2]][23:0]};
                2'b01: // Half-word write
                    memory[A[31:2]] <= (A[1] == 1'b0) ? {memory[A[31:2]][31:16], WD[15:0]} :
                                         {WD[15:0], memory[A[31:2]][15:0]};
                2'b10: // Word write
                    memory[A[31:2]] <= WD;
                default: memory[A[31:2]] <= memory[A[31:2]];
            endcase
        end
    end

endmodule

