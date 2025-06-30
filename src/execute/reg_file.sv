module reg_file (
    input  logic        clk,
    input  logic        rst_n,      // Active-low reset
    input  logic        reg_write,  // Enable register write
    input  logic [4:0]  rs1_addr,   // Read address 1
    input  logic [4:0]  rs2_addr,   // Read address 2
    input  logic [4:0]  rd_addr,    // Write address
    input  logic [31:0] rd_data,    // Data to write
    output logic [31:0] rs1_data,   // Read data 1
    output logic [31:0] rs2_data    // Read data 2
);

    logic [31:0] regs [0:31];  // 32 registers

    // Write logic: synchronous write on positive edge
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            regs <= '{default: 32'b0};
        end
        else if (reg_write && (rd_addr != 0)) begin
            regs[rd_addr] <= rd_data;
        end
    end

    // Read logic: combinational reads
    always_comb begin
        rs1_data = (rs1_addr == 0) ? 32'b0 : regs[rs1_addr];
        rs2_data = (rs2_addr == 0) ? 32'b0 : regs[rs2_addr];
    end

endmodule
