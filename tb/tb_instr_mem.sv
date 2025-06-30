`timescale 1ns/1ps

module tb_instr_mem;

    logic [31:0] addr;
    logic [31:0] instr;

    // Instantiate instruction memory
    instr_mem uut (
        .addr(addr),
        .instr(instr)
    );

    initial begin
        $display("Starting Instruction Memory Test...");

        // Test fetching instructions at various addresses
        addr = 0;
        #5;
        $display("Address = %h, Instruction = %h", addr, instr);

        addr = 4;
        #5;
        $display("Address = %h, Instruction = %h", addr, instr);

        addr = 8;
        #5;
        $display("Address = %h, Instruction = %h", addr, instr);

        addr = 12;
        #5;
        $display("Address = %h, Instruction = %h", addr, instr);

        $finish;
    end

endmodule
