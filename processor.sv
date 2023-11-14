module processor(input logic clock, reset, start, 
    input logic[11:0] machine_code, 
    input logic[7:0] dataIN,
    output logic data, done);

    logic[7:0] BUS_global;
    logic[4:0] function_counter;
    logic[3:0] ALU_function_select, display_enable;
    logic[2:0] enable_register_write, enable_register_read;
    logic[2:0] ALU_enable; // Enable order: 0:A, 1:B, 2:Out
    logic[2:0] opcode, p1, p2, p3; 

    assign opcode = machine_code[11:9];
    assign p1 = machine_code[8:6];
    assign p2 = machine_code[5:3];
    assign p3 = machine_code[2:0];

    ProgramCounter #(4) c0 (
        .clock(clock),
        .reset(reset),
        .enable(start),
        .out(function_counter)
    );

    register_bank r0(
        .CLK(clock),
        .RESET(reset),
        .enIn(enable_register_write),
        .enOut(enable_register_write),
        .IN(BUS_global),
        .OUT(BUS_global)
    );

    ALU a0(
        .clk(clock), 
        .async_reset(reset), 
        .bus(BUS_global), 
        .a_in(ALU_enable[0]), 
        .b_in(ALU_enable[1]), 
        .save_result(ALU_enable[2]),
        .func_sel(ALU_function_select), 
        .result(BUS_global)
    );

    function_register f0(
        .clock(clock), 
        .reset(reset), 
        .T(function_counter), 
        .opcode(opcode), 
        .p1(p1), 
        .p2(p2), 
        .p3(p3), 
        .data(data), 
        .done(done), 
        .display(display_enable), 
        .fcnOut(ALU_function_select), 
        .regIn(enable_register_write), 
        .regOut(enable_register_read), 
        .ALUout(ALU_enable)
    );

    always_comb begin
        if(data) begin
            BUS_global = dataIN;
        end
    end

endmodule

module control_FSM(input logic clock, reset, start,
    input logic[11:0] machine_code, 
    output logic dataEN, done, 
    output logic[3:0] displayIn, 
    output logic[2:0] regIn, regOut, ALUout, 
    output logic[3:0] fcnOut);

    logic[4:0] T;
    ProgramCounter #(4) pc (clock, reset, start, done, T);

    function_register fr(clock, reset, T, 
        machine_code[11:9], machine_code[8:6],
        machine_code[5:3], machine_code[2:0], 
        dataEN, done, displayIn, fcnOut,
        regIn, regOut, ALUout);
endmodule

module display_IO(input logic clock, input logic[3:0] displayIn, 
    output logic[6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    
endmodule