`timescale 1ns/1ps

module tb_execute;

    logic clk;
    logic rst_n;
    logic reg_write_en;
    logic [1:0] imm_src;
    logic alu_src;
    logic [3:0] alu_control;
    logic [4:0] rs1_addr, rs2_addr, rd_addr;
    logic [31:0] rd_data_in, instr;
    logic [31:0] alu_result;
    logic zero_flag;
    logic [31:0] rs2_data_out;

    execute uut (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write_en(reg_write_en),
        .imm_src(imm_src),
        .alu_src(alu_src),
        .alu_control(alu_control),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data_in(rd_data_in),
        .instr(instr),
        .alu_result(alu_result),
        .zero_flag(zero_flag),
        .rs2_data_out(rs2_data_out)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting Execute Stage Test...");
        clk = 0;
        rst_n = 0;
        reg_write_en = 0;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        rd_data_in = 0;
        instr = 0;
        imm_src = 2'b00;
        alu_src = 0;
        alu_control = 4'b0000;

        // Reset
        #10;
        rst_n = 1;

        // Write to x1 and x2
        reg_write_en = 1;
        rd_addr = 5'd1;
        rd_data_in = 32'h0000_0005;
        #10;
        rd_addr = 5'd2;
        rd_data_in = 32'h0000_0003;
        #10;
        reg_write_en = 0;

        // ADD x1 + x2
        rs1_addr = 5'd1;
        rs2_addr = 5'd2;
        alu_src = 0;
        alu_control = 4'b0000; // ADD
        #1;
        $display("ADD: rs1 + rs2 = %d", alu_result);

        // ADD Immediate (ADDI) rs1 + imm (imm = 4)
        instr = 32'b000000000100_00001_000_00011_0010011;  // ADDI x3, x1, 4
        rs1_addr = 5'd1;
        alu_src = 1;
        alu_control = 4'b0000;
        #1;
        $display("ADDI: rs1 + imm = %d", alu_result);

        // SUB x1 - x2
        rs1_addr = 5'd1;
        rs2_addr = 5'd2;
        alu_src = 0;
        alu_control = 4'b0001;
        #1;
        $display("SUB: rs1 - rs2 = %d, Zero = %b", alu_result, zero_flag);

        $finish;
    end

endmodule
