`timescale 1ns/1ps

module tb_reg_file;

    logic clk;
    logic rst_n;
    logic reg_write;
    logic [4:0] rs1_addr;
    logic [4:0] rs2_addr;
    logic [4:0] rd_addr;
    logic [31:0] rd_data;
    logic [31:0] rs1_data;
    logic [31:0] rs2_data;

    // Instantiate register file
    reg_file uut (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting Register File Test...");

        clk = 0;
        rst_n = 0;
        reg_write = 0;
        rs1_addr = 0;
        rs2_addr = 0;
        rd_addr = 0;
        rd_data = 0;

        // Apply reset
        #10;
        rst_n = 1;

        // Write value to x1
        reg_write = 1;
        rd_addr = 5'd1;
        rd_data = 32'hAAAA_BBBB;
        #10;

        // Write value to x2
        rd_addr = 5'd2;
        rd_data = 32'h1234_5678;
        #10;

        // Attempt to write to x0 (should be ignored)
        rd_addr = 5'd0;
        rd_data = 32'hDEAD_BEEF;
        #10;
        reg_write = 0;

        // Read back x1 and x2
        rs1_addr = 5'd1;
        rs2_addr = 5'd2;
        #1;
        $display("Read x1 = %h (Expect: AAAABBBB), x2 = %h (Expect: 12345678)", rs1_data, rs2_data);

        // Read x0 (should always be zero)
        rs1_addr = 5'd0;
        rs2_addr = 5'd0;
        #1;
        $display("Read x0 = %h, x0 = %h (Expect: 0)", rs1_data, rs2_data);

        $finish;
    end

endmodule
