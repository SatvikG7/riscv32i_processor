module instr_mem #(
    parameter MEM_DEPTH = 4    // Number of instructions (can be adjusted)
) (
    input  logic [31:0] addr,    // Instruction address (byte address)
    output logic [31:0] instr    // Fetched instruction
);

    logic [31:0] mem [0:MEM_DEPTH-1];   // Instruction memory array

    // Initialization using readmemh, compatible with Quartus simulation
    initial begin
        $readmemh("instr_mem.hex", mem);
    end

    // Fetch instruction, address divided by 4 for word indexing
    assign instr = mem[addr[31:2]];

endmodule
