module decode (
    input  logic [31:0] instr,     // Full 32-bit instruction
    output logic [6:0]  opcode,    // Instruction opcode
    output logic [4:0]  rd,        // Destination register
    output logic [2:0]  funct3,    // funct3 field
    output logic [4:0]  rs1,       // Source register 1
    output logic [4:0]  rs2,       // Source register 2
    output logic [6:0]  funct7     // funct7 field
);

    assign opcode = instr[6:0];
    assign rd     = instr[11:7];
    assign funct3 = instr[14:12];
    assign rs1    = instr[19:15];
    assign rs2    = instr[24:20];
    assign funct7 = instr[31:25];

endmodule
