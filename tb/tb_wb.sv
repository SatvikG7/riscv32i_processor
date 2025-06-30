`timescale 1ns/1ps

module tb_wb;

    logic [1:0]  result_src;
    logic [31:0] alu_result;
    logic [31:0] mem_data;
    logic [31:0] pc_plus4;
    logic [31:0] rd_data;

    wb uut (
        .result_src(result_src),
        .alu_result(alu_result),
        .mem_data(mem_data),
        .pc_plus4(pc_plus4),
        .rd_data(rd_data)
    );

    initial begin
        $display("Starting Write-Back Stage Test...");

        alu_result = 32'hAAAA_BBBB;
        mem_data   = 32'h1234_5678;
        pc_plus4   = 32'h0000_0100;

        // Select ALU Result
        result_src = 2'b00;
        #1;
        $display("ALU Result selected: rd_data = %h", rd_data);

        // Select Memory Data
        result_src = 2'b01;
        #1;
        $display("Memory Data selected: rd_data = %h", rd_data);

        // Select PC + 4
        result_src = 2'b10;
        #1;
        $display("PC + 4 selected: rd_data = %h", rd_data);

        $finish;
    end

endmodule
