module mkII_tb();

    logic clk, reset;

    always #2 clk = ~clk;
    logic[31:0] machine_code;

    processor_MKII p1(clk, reset, machine_code);

    task RESET_HARD();
        clk = 1'b0;
        reset = 1'b1; #10 reset = 1'b0;
    endtask

    task RESET_SOFT();
        reset = 1'b1; #10 reset = 1'b0;
    endtask

    task PUSH_MACHINE_CODE(logic[31:0] binary_code);
        machine_code = binary_code;
    endtask

    initial begin
        RESET_HARD();
        PUSH_MACHINE_CODE(32'b00000000000001000000010000010011);
    end

    logic[31:0] bus_tb;
    assign bus_tb = p1.d0.bus;
    


endmodule