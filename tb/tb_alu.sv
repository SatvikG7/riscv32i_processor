`timescale 1ns/1ps

module tb_alu;

    logic [31:0] a;
    logic [31:0] b;
    logic [3:0]  ALUControl;
    logic [31:0] result;
    logic        zero;

    // Instantiate ALU
    alu uut (
        .a(a),
        .b(b),
        .ALUControl(ALUControl),
        .result(result),
        .zero(zero)
    );

    initial begin
        $display("Starting ALU Test...");

        // ADD
        a = 32'h0000_0005; b = 32'h0000_0003; ALUControl = 4'b0000; #1;
        $display("ADD: %d + %d = %d", a, b, result);

        // SUB
        a = 32'h0000_0005; b = 32'h0000_0005; ALUControl = 4'b0001; #1;
        $display("SUB: %d - %d = %d (Zero = %b)", a, b, result, zero);

        // AND
        a = 32'hFFFF_0000; b = 32'h00FF_00FF; ALUControl = 4'b0010; #1;
        $display("AND: %h & %h = %h", a, b, result);

        // OR
        ALUControl = 4'b0011; #1;
        $display("OR: %h | %h = %h", a, b, result);

        // XOR
        ALUControl = 4'b0100; #1;
        $display("XOR: %h ^ %h = %h", a, b, result);

        // SLL
        a = 32'h0000_0001; b = 32'h0000_0008; ALUControl = 4'b0101; #1;
        $display("SLL: %h << %d = %h", a, b[4:0], result);

        // SRL
        a = 32'h0000_00F0; b = 32'h0000_0004; ALUControl = 4'b0110; #1;
        $display("SRL: %h >> %d = %h", a, b[4:0], result);

        // SRA
        a = 32'hFFFF_FFF0; b = 32'h0000_0004; ALUControl = 4'b0111; #1;
        $display("SRA: %h >>> %d = %h", a, b[4:0], result);

        // SLT (signed)
        a = -5; b = 3; ALUControl = 4'b1000; #1;
        $display("SLT: %d < %d = %d", a, b, result);

        // SLTU (unsigned)
        a = 32'hFFFF_FFFF; b = 32'h0000_0001; ALUControl = 4'b1001; #1;
        $display("SLTU: %h < %h = %d", a, b, result);

        $finish;
    end

endmodule
