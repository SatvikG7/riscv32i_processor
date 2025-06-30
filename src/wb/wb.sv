module wb (
    input  logic [1:0]   result_src,   // Select signal
    input  logic [31:0]  alu_result,   // ALU output
    input  logic [31:0]  mem_data,     // Data from memory
    input  logic [31:0]  pc_plus4,     // PC + 4
    output logic [31:0]  rd_data       // Data to write to Register File
);

    always_comb begin
        case (result_src)
            2'b00: rd_data = alu_result;
            2'b01: rd_data = mem_data;
            2'b10: rd_data = pc_plus4;
            default: rd_data = 32'b0;
        endcase
    end

endmodule
