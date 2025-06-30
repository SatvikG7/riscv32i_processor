module riscv_top (
    input  logic clk,
    input  logic rst_n
);

    // Program Counter
    logic [31:0] pc, pc_next, pc_plus4, branch_target;
    
    // Instruction & Data Signals
    logic [31:0] instr, imm, rs1_data, rs2_data, alu_result, mem_data, rd_data;
    logic [31:0] mem_read_data;
    logic        zero_flag;

    // Control Signals
    logic [1:0]  result_src, imm_src;
    logic        reg_write_en, alu_src, mem_write, branch;
    logic [3:0]  alu_control;
    logic        pc_src;
	 logic [1:0] alu_op;

    // FETCH STAGE
    assign pc_plus4 = pc + 4;

    instr_mem imem (
        .addr(pc),
        .instr(instr)
    );
	 
	 logic [6:0]  opcode;
	 logic [4:0]  rd;
	 logic [2:0]  funct3;
	 logic [4:0]  rs1;
	 logic [4:0]  rs2;
	 logic [6:0]  funct7;
	 assign funct7_5 = funct7[5];


	  // Instantiation with proper port connections
	 decode instr_decoder (
		  .instr(instr),
		  .opcode(opcode),
		  .rd(rd),
		  .funct3(funct3),
		  .rs1(rs1),
		  .rs2(rs2),
		  .funct7(funct7)
	 );
	 	
    // DECODE STAGE
    main_decoder decoder (
        .opcode(opcode),
        .reg_write(reg_write_en),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .branch(branch),
        .result_src(result_src),
        .imm_src(imm_src),
        .alu_op(alu_op)
    );
	 
	 alu_decoder alu_decoder_unit (
        .alu_op(alu_op),
        .funct3(funct3),
        .funct7_5(funct7_5),
        .alu_control(alu_control)
	 );


    reg_file rf (
        .clk(clk),
        .rst_n(rst_n),
        .reg_write(reg_write_en),
        .rs1_addr(instr[19:15]),
        .rs2_addr(instr[24:20]),
        .rd_addr(instr[11:7]),
        .rd_data(rd_data),
        .rs1_data(rs1_data),
        .rs2_data(rs2_data)
    );

    imm_gen ig (
        .instr(instr),
        .imm_out(imm)
    );

    // EXECUTE STAGE
    logic [31:0] alu_b;
    assign alu_b = (alu_src) ? imm : rs2_data;

    alu alu_unit (
        .a(rs1_data),
        .b(alu_b),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero_flag)
    );

    assign branch_target = pc + imm;
    assign pc_src = branch & zero_flag;

    // MEMORY STAGE
    data_mem dmem (
        .clk(clk),
        .mem_write(mem_write),
        .mem_size(2'b10),   // Word access for now (can expand)
        .addr(alu_result),
        .write_data(rs2_data),
        .read_data(mem_read_data)
    );

    // WRITE-BACK STAGE
    wb writeback (
        .result_src(result_src),
        .alu_result(alu_result),
        .mem_data(mem_read_data),
        .pc_plus4(pc_plus4),
        .rd_data(rd_data)
    );

    // PROGRAM COUNTER UPDATE
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc <= 0;
        else
            pc <= (pc_src) ? branch_target : pc_plus4;
    end

endmodule
