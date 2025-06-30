module data_mem (
    input  logic        clk,
    input  logic        mem_write,
    input  logic [1:0]  mem_size,    // 00 = Byte, 01 = Half, 10 = Word
    input  logic [31:0] addr,
    input  logic [31:0] write_data,
    output logic [31:0] read_data
);

    logic [7:0] mem [0:255];  // 256 bytes = 64 words memory (expandable)

    // Read operation - asynchronous
    always_comb begin
        case (mem_size)
            2'b00: read_data = {{24{mem[addr][7]}}, mem[addr]}; // Load Byte, sign-extended
            2'b01: read_data = {{16{mem[addr + 1][7]}}, mem[addr + 1], mem[addr]}; // Load Halfword, sign-extended
            2'b10: read_data = {mem[addr + 3], mem[addr + 2], mem[addr + 1], mem[addr]}; // Load Word
            default: read_data = 32'b0;
        endcase
    end

    // Write operation - synchronous
    always_ff @(posedge clk) begin
        if (mem_write) begin
            case (mem_size)
                2'b00: mem[addr] <= write_data[7:0];                    // Store Byte
                2'b01: begin                                           // Store Halfword
                    mem[addr]     <= write_data[7:0];
                    mem[addr + 1] <= write_data[15:8];
                end
                2'b10: begin                                           // Store Word
                    mem[addr]     <= write_data[7:0];
                    mem[addr + 1] <= write_data[15:8];
                    mem[addr + 2] <= write_data[23:16];
                    mem[addr + 3] <= write_data[31:24];
                end
            endcase
        end
    end

    // Memory initialization for simulation
    initial begin
        $readmemh("data_image.hex", mem);
    end

endmodule
