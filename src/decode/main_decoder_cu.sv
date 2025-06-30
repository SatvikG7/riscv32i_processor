module main_decoder (
    input  logic [6:0] opcode,
    output logic       reg_write,
    output logic [1:0] imm_src,
    output logic       alu_src,
    output logic       mem_write,
    output logic       result_src,
    output logic       branch,
    output logic [1:0] alu_op
);

    always_comb begin
        // Default values
        reg_write  = 0;
        imm_src    = 2'b00;
        alu_src    = 0;
        mem_write  = 0;
        result_src = 0;
        branch     = 0;
        alu_op     = 2'b00;

        case (opcode)
            7'b0110011: begin // R-type
                reg_write  = 1;
                alu_src    = 0;
                result_src = 0;
                alu_op     = 2'b10;
            end
            7'b0010011: begin // I-type (ADDI, etc.)
                reg_write  = 1;
                alu_src    = 1;
                imm_src    = 2'b00;
                result_src = 0;
                alu_op     = 2'b00;
            end
            7'b0000011: begin // Load (LW)
                reg_write  = 1;
                alu_src    = 1;
                imm_src    = 2'b00;
                result_src = 1;
                alu_op     = 2'b00;
            end
            7'b0100011: begin // Store (SW)
                alu_src    = 1;
                imm_src    = 2'b01;
                mem_write  = 1;
                alu_op     = 2'b00;
            end
            7'b1100011: begin // Branch (BEQ)
                alu_src    = 0;
                imm_src    = 2'b10;
                branch     = 1;
                alu_op     = 2'b01;
            end
            default: begin
                // Keep defaults
            end
        endcase
    end

endmodule
