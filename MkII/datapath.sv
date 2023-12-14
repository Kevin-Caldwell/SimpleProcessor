module datapath(
    input logic clk, reset,
    
    input logic[4:0] alu_function_sel,
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

    always_ff @( posedge clk, posedge reset ) begin // Register Read from Bus
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

        if(register_write_enable && register_index) begin
            registers[register_index] <= bus;
        end
    end


    always_comb begin // ALU
        case (alu_function_sel)
            5'd0: alu_out = 32'b0;

            5'd1: alu_out = alu_1 | alu_2;
            5'd2: alu_out = alu_1 & alu_2;
            5'd3: alu_out = alu_1 ^ alu_2;

            5'd4: alu_out = alu_1 << alu_2;
            5'd5: alu_out = alu_1 >> alu_2; // Logical
            5'd6: alu_out = alu_1 >> alu_2; // Arithmetic (placeholder)

            5'd7: alu_out = alu_1 < alu_2;
            5'd8: alu_out = alu_1 <= alu_2;
            5'd9: alu_out = alu_1 == alu_2;
            5'd10: alu_out = alu_1 > alu_2;
            5'd11: alu_out = alu_1 >= alu_2;

            5'd12: alu_out = alu_1 + alu_2;
            5'd13: alu_out = alu_1 - alu_2;
            default: alu_out = 32'b0;
        endcase
    end

    
    always_comb begin // Bus Logic
        if(alu_broadcast) begin
            bus = alu_out;
        end else if(register_read_enable) begin
            bus = registers_read;
        end else if(imm_EN) begin
            bus = imm;
        end else begin
            bus = 32'bZ;
        end
    end


endmodule