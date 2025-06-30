`timescale 1ns/1ps

module tb_riscv_top;

    logic clk;
    logic rst_n;

    // Instantiate Top-Level Processor
    riscv_top uut (
        .clk(clk),
        .rst_n(rst_n)
    );

    // Clock Generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        $display("----- RISC-V RV32I Processor Simulation -----");
        
        clk = 0;
        rst_n = 0;

        // Instruction Memory Initialization
        $readmemh("instr_mem.hex", uut.imem.mem);

        // Optional: Data Memory Initialization
        $readmemh("data_mem.hex", uut.dmem.mem);

        // Reset sequence
        #20;
        rst_n = 1;

        // Run simulation for fixed cycles
        repeat (50) @(posedge clk);

        $display("----- Simulation Completed -----");

        // Optional: Dump Registers
        dump_registers();

        $finish;
    end

    // Task to display register file contents
    task dump_registers();
        integer i;
        begin
            $display("--- Register File Contents ---");
            for (i = 0; i < 32; i = i + 1) begin
                $display("x%0d = 0x%08h", i, uut.rf.regs[i]);
            end
        end
    endtask

endmodule
