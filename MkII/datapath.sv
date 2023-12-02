module datapath(
    input logic clk, reset,
    
    input logic[2:0] alu_function_sel,
    input logic alu_store_1, alu_store_2, alu_broadcast,
    
    input logic[4:0] register_index,
    input logic register_read_enable, register_write_enable,

    input logic[31:0] imm,
    input logic imm_EN
);
    logic[31:0] bus;

    logic[31:0] registers_read;
    logic [31:0][31:0] registers;

    logic[31:0] alu_1, alu_2, alu_out;

    assign registers_read = registers[register_index];

    always_comb begin
        if(register_read_enable) begin
            bus = registers_read;
        end else begin
            bus = 32'bZ;
        end

        if(alu_broadcast) begin
            bus = alu_out;
        end else begin
            bus = 32'bZ;
        end

        if(imm_EN) begin
            bus = imm;
        end else begin
            bus = 32'bZ;
        end
    end

    always_ff @( posedge clk, posedge reset ) begin
        if(reset) begin
            registers <= 1024'b0;
            alu_1 <= 32'b0;
            alu_2 <= 32'b0;
        end
        
        if(alu_store_1) begin
            alu_1 <= bus;
        end

        if(alu_store_2) begin
            alu_2 <= bus;
        end

        if(register_write_enable) begin
            registers[register_index] <= bus;
        end
    end

    always_comb begin // ALU
        case (alu_function_sel)
            3'd0: alu_out = 32'b0;
            3'd1: alu_out = alu_1 + alu_2;
            3'd2: alu_out = alu_1 - alu_2;
            default: alu_out = 32'b0;
        endcase
    end


endmodule