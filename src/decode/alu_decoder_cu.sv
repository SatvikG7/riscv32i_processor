module alu_decoder (
    input  logic [1:0] alu_op,
    input  logic [2:0] funct3,
    input  logic       funct7_5,
    output logic [2:0] alu_control
);

    always_comb begin
        case (alu_op)
            2'b00: alu_control = 3'b000; // ADD (used for load/store, addi)
            2'b01: alu_control = 3'b001; // SUB (used for branch comparisons)
            2'b10: begin // R-type specific
                case (funct3)
                    3'b000: alu_control = (funct7_5) ? 3'b001 : 3'b000; // SUB : ADD
                    3'b111: alu_control = 3'b010; // AND
                    3'b110: alu_control = 3'b011; // OR
                    default: alu_control = 3'b000;
                endcase
            end
            default: alu_control = 3'b000;
        endcase
    end

endmodule
