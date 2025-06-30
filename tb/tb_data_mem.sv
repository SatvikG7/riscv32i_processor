`timescale 1ns/1ps

module tb_data_mem;

    logic clk;
    logic mem_write;
    logic [1:0] mem_size;
    logic [31:0] addr;
    logic [31:0] write_data;
    logic [31:0] read_data;

    // Instantiate data memory
    data_mem uut (
        .clk(clk),
        .mem_write(mem_write),
        .mem_size(mem_size),
        .addr(addr),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock Generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting Data Memory Test...");
        clk = 0;
        mem_write = 0;
        addr = 0;
        write_data = 0;
        mem_size = 2'b00;

        // Store Byte
        #10;
        addr = 8;
        write_data = 32'h0000_00AA;
        mem_size = 2'b00;
        mem_write = 1;
        #10;
        mem_write = 0;
        #1;
        $display("LB Read: %h", read_data);

        // Store Halfword
        addr = 12;
        write_data = 32'h0000_BBBB;
        mem_size = 2'b01;
        mem_write = 1;
        #10;
        mem_write = 0;
        #1;
        $display("LH Read: %h", read_data);

        // Store Word
        addr = 16;
        write_data = 32'hDEAD_BEEF;
        mem_size = 2'b10;
        mem_write = 1;
        #10;
        mem_write = 0;
        #1;
        $display("LW Read: %h", read_data);

        $finish;
    end

endmodule
