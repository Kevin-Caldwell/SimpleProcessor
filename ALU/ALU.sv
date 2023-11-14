
module ALU(input logic clk, input logic async_reset, 
    input logic[7:0] bus,
    input logic a_in, b_in, save_result, 
    input logic[3:0] func_sel, 
    output logic[7:0] result);

    logic[7:0] a_i, b_i, r_i;

    // Instantiate Sub-Modules for each function
    always_ff @( posedge clk, posedge async_reset ) begin
        if(async_reset) begin
            a_i <= 8'b0;
            b_i <= 8'b0;
            result <= 8'b0;
        end
        else begin
            if(a_in) begin
                a_i <= bus; 
            end
            if(b_in) begin
                b_i <= bus;
            end
            if(save_result) begin
                result <= r_i;
            end
        end
    end

    always_comb begin
        case (func_sel)
            'b0000: r_i = 8'b0;
            'b0001: r_i = a_i + b_i;
            'b0010: r_i = a_i - b_i;
            'b0011: r_i = a_i ^ b_i;
            'b1000: r_i = 8'b0;
            'b1001: r_i = a_i + b_i;
            'b1010: r_i = a_i - b_i;
            'b1011: r_i = a_i ^ b_i;
            default: r_i = 8'b0;
        endcase
    end
endmodule
