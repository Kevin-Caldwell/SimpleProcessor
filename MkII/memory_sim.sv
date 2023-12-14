module mem_IO(
    input logic clk, reset, 
    input logic[31:0] Din, 
    input logic R, W, 
    input logic[31:0] address, 
    output logic[31:0] Dout
);
    parameter size = 32767;
    logic[1:0][size:0][31:0] RAM;
    int top;

    always_ff @( posedge clk, posedge reset ) begin
        if(reset) begin
            RAM <= {2*size{32'b0}};
            top = 0;
        end

        if(R) begin
            for(int i = 0; i < top; i++) begin
                if(address == RAM[0][i]) begin
                    Dout = RAM[1][i];
                    break;
                end
            end
        end else begin
            Dout = 32'b0;
        end

        if(W) begin
            int i, overflow;
            overflow = 1;
            for(i = 0; i < top; i++) begin
                if(address == RAM[0][i]) begin
                    overflow = 0;
                    break;
                end
            end
            RAM[0][i] <= address;
            RAM[1][i] <= Din;
            if(overflow) begin
                top = top+1;
            end
        end
    end
endmodule

module test_mem();
    logic clk, reset;

    always #2 clk = ~clk;

    logic[31:0] Din, address, Dout;
    logic R, W;

    mem_IO m0(clk, reset, Din, R, W, address, Dout);

    task RESET_HARD();
        clk = 1'b0;
        reset = 1'b1; #4 reset = 1'b0;
        Din = 32'b0;
        address = 32'b0;
        Dout = 32'b0;
        R = 1'b0;
        W = 1'b0;
        
    endtask

    task RESET_SOFT();
        address = 32'b0;
        R = 1'b0;
        W = 1'b0;
    endtask

    task READ_ADDRESS(logic[31:0] a);
        address = a;
        R = 1'b1;
        W = 1'b0; #4;
        RESET_SOFT(); #4;
    endtask

    task WRITE_ADDRESS(logic[31:0] a, logic[31:0] val);
        address = a;
        R = 1'b0;
        W = 1'b1;
        Din = val; #4;
        RESET_SOFT(); #4;
    endtask

    initial begin
        RESET_HARD();

        WRITE_ADDRESS(32'h00400000, 32'b00000000000100000000010000010011);

        READ_ADDRESS(32'h00400000);
        READ_ADDRESS(32'h00100000);
        
        WRITE_ADDRESS(32'h00400001, 32'b00000000000100000000010000010011);
        WRITE_ADDRESS(32'h00400002, 32'b00000000000100000000010000010011);
        WRITE_ADDRESS(32'h00400003, 32'b00000000000100000000010000010011);
        WRITE_ADDRESS(32'h00400004, 32'b00000000000100000000010000010011);

    end
endmodule