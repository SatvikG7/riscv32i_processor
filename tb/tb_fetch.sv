`timescale 1ns/1ps

module tb_fetch;

    logic clk;
    logic rst_n;
    logic branch_taken;
    logic [31:0] branch_target;
    logic [31:0] pc_out;
    logic [31:0] instr_addr;

    // Instantiate fetch module
    fetch uut (
        .clk(clk),
        .rst_n(rst_n),
        .branch_taken(branch_taken),
        .branch_target(branch_target),
        .pc_out(pc_out),
        .instr_addr(instr_addr)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        $display("Starting Instruction Fetch Test...");
        clk = 0;
        rst_n = 0;
        branch_taken = 0;
        branch_target = 0;

        // Apply Reset
        #10;
        rst_n = 1;

        // Observe PC increments
        #10;
        $display("PC = %0h", pc_out);
        #10;
        $display("PC = %0h", pc_out);

        // Trigger branch
        branch_taken = 1;
        branch_target = 32'h0000_0020;
        #10;
        $display("Branch Taken, PC = %0h", pc_out);

        // After branch, PC should increment normally again
        branch_taken = 0;
        #10;
        $display("PC = %0h", pc_out);
        #10;
        $display("PC = %0h", pc_out);

        $finish;
    end

endmodule
