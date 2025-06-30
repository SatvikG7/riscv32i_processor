`timescale 1ns/1ps

module tb_imm_gen;

    logic [31:0] instr;
    logic [31:0] imm_out;

    // Instantiate Immediate Generator
    imm_gen uut (
        .instr(instr),
        .imm_out(imm_out)
    );

    initial begin
        $display("Starting Immediate Generator Test...");

        // I-type example: ADDI x1, x2, -4
        instr = 32'b111111111100_00010_000_00001_0010011;
        #1;
        $display("I-type ADDI, imm_out = %0d (hex: %h)", imm_out, imm_out);

        // S-type example: SW x1, -8(x2)
        instr = 32'b1111111_00001_00010_010_11100_0100011;
        #1;
        $display("S-type SW, imm_out = %0d (hex: %h)", imm_out, imm_out);

        // B-type example: BEQ x1, x2, offset = 16
        instr = 32'b000000_00010_00001_000_00010_1100011;
        #1;
        $display("B-type BEQ, imm_out = %0d (hex: %h)", imm_out, imm_out);

        // U-type example: LUI x1, 0x00012
        instr = 32'b000000000001_0010_00001_0110111;
        #1;
        $display("U-type LUI, imm_out = %0d (hex: %h)", imm_out, imm_out);

        // J-type example: JAL x1, offset = 2048
        instr = 32'b000000001_00000000000_00001_1101111;
        #1;
        $display("J-type JAL, imm_out = %0d (hex: %h)", imm_out, imm_out);

        $finish;
    end

endmodule
