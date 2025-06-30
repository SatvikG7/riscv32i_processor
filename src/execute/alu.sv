module alu (
    input  logic [31:0] a,         // Operand 1
    input  logic [31:0] b,         // Operand 2
    input  logic [3:0]  alu_control, // ALU operation select
    output logic [31:0] result,    // ALU result
    output logic        zero       // Zero flag (result == 0)
);

    always_comb begin
        case (alu_control)
            4'b000: result = a + b;                         // ADD
            4'b001: result = a - b;                         // SUB
            4'b010: result = a & b;                         // AND
            4'b011: result = a | b;                         // OR
            4'b100: result = a ^ b;                         // XOR
            4'b101: result = a << b[4:0];                   // SLL
            4'b110: result = a >> b[4:0];                   // SRL
            4'b111: result = $signed(a) >>> b[4:0];         // SRA
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 0);

endmodule
