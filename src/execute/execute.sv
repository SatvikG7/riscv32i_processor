module execute (
    input  logic         clk,
    input  logic         rst_n,
    input  logic         reg_write_en,
    input  logic [1:0]   imm_src,
    input  logic         alu_src,       // 0: register, 1: immediate
    input  logic [3:0]   alu_control,   // From ALU decoder
    input  logic [4:0]   rs1_addr,
    input  logic [4:0]   rs2_addr,
    input  logic [4:0]   rd_addr,
    input  logic [31:0]  rd_data_in,    // Data to write to reg file
    input  logic [31:0]  instr,         // Full instruction

    output logic [31:0]  alu_result,
    output logic         zero_flag,
    output logic [31:0]  rs2_data_out   // Forward to store instructions
);

    logic [31:0] rs1_data, rs2_data, imm, alu_b;

    // Instantiate Register File
    reg_file rf (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write_en),
        .rs1_addr(rs1_addr),
        .rs2_addr(rs2_addr),
        .rd_addr(rd_addr),
        .rd_data(rd_data_in),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    // Immediate Generator
    imm_gen ig (
        .instr(instr),
        .imm_out(imm)
    );

    // ALU input selection
    assign alu_b = (alu_src) ? imm : rs2_data;

    // ALU
    alu alu_unit (
        .a(rs1_data),
        .b(alu_b),
        .ALUControl(alu_control),
        .result(alu_result),
        .zero(zero_flag)
    );

    // Output rs2_data for SW instructions
    assign rs2_data_out = rs2_data;

endmodule
