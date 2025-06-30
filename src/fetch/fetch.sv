module fetch (
    input  logic        clk,
    input  logic        rst_n,          // Active-low reset
    input  logic        branch_taken,   // High if branch taken
    input  logic [31:0] branch_target,  // Target address for branch
    output logic [31:0] pc_out,         // Current PC value
    output logic [31:0] instr_addr      // Instruction address output
);

    // Program Counter register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc_out <= 32'h0000_0000;
        else if (branch_taken)
            pc_out <= branch_target;
        else
            pc_out <= pc_out + 4;
    end

    // Instruction address output
    assign instr_addr = pc_out;

endmodule
