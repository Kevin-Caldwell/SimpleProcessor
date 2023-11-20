`timescale 1ps/1ps

module processor_tb ();
    logic[11:0] machine_code;
    logic[7:0] data_in, BUS_global;
    logic[63:0] reg_test;
    logic clock, reset, start, done, data_enable;

    always #1 clock = ~clock;

    processor p0(
        .clock(clock), 
        .reset(reset), 
        .start(start), 
        .machine_code(machine_code), 
        .dataIN(data_in), 
        .data_enable(data_enable),
        .done(done), 
        .reg_test(reg_test), 
        .BUS_global(BUS_global)
    );

    logic[4:0] function_counter;
    assign function_counter = p0.function_counter;

    logic[2:0] reg_write_enable, reg_read_enable, ALU_enable, enOut;
    assign reg_write_enable = p0.enable_register_write;
    assign reg_read_enable = p0.enable_register_read;
    assign ALU_enable = p0.ALU_enable;
    assign enOut = p0.r0.enOut;

    logic[7:0] a_i, b_i, r_i, reg_out, r_out_1, alu_res;
    assign a_i = p0.a0.a_i;
    assign b_i = p0.a0.b_i;
    assign r_i = p0.a0.r_i;
    assign reg_out = p0.r0.OUT;
    assign r_out_1 = p0.r0.outBuff1;
    assign alu_res = p0.a0.result;
    

    typedef enum logic[2:0] { DISP = 3'b0, LOAD, MOVE, ADD, SUB, ADDI } OPCODE;
    task full_reset();
        start = 1'b0;
        clock = 1'b0;
        machine_code = 12'b0;
        data_in = 8'b0;
        reset = 1'b1; #2;
        reset = 1'b0; #2;
    endtask

    task apply_reset();
        start = 1'b0;
        reset = 1'b1; #2;
        reset = 1'b0; #2;
    endtask

    task assemble_machine_code(input OPCODE operation,
         input logic[2:0] arg0, arg1, arg2);
        case (operation)
            DISP: machine_code =  {{3'b000},   {arg0}, {arg1}, {arg2}};
            LOAD: machine_code =  {{3'b001},   {arg0}, {arg1}, {arg2}};
            MOVE: machine_code =  {{3'b010},   {arg0}, {arg1}, {arg2}};
            ADD: machine_code =   {{3'b011},   {arg0}, {arg1}, {arg2}};
            SUB: machine_code =   {{3'b100},   {arg0}, {arg1}, {arg2}};
            ADDI: machine_code =  {{3'b101},   {arg0}, {arg1}, {arg2}};
            default: machine_code = 12'b0;
        endcase
    endtask

    task execute(input OPCODE operation, 
        input logic[2:0] arg0, arg1, arg2, 
        input logic[7:0] new_data_in = 8'd0);

        assemble_machine_code(operation, arg0, arg1, arg2);
        if(operation == LOAD) begin
            data_in = new_data_in;
        end
        start = 1'b1; #2; start = 1'b0;
        #1;
        for(int i = 0; i < 20; i++) begin
            if(done) begin
                #2 break;
            end
            #2;
        end
    endtask

    task post_system_status();
        $display("Machine Code: %0h\n", {machine_code});
        for (int i = 0; i < 8; i++) begin
            
        end
    endtask
    
    initial begin
        full_reset();
        post_system_status();
        execute(DISP, 3'd0, 3'b0, 3'b0);
        post_system_status();
        execute(LOAD, 3'd1, 3'd0, 3'd0, 8'h21);
        post_system_status();
        execute(LOAD, 3'd2, 3'd0, 3'd0, 8'd1);
        post_system_status();
        execute(ADD, 3'd1, 3'd1, 3'd2, 8'd0);
        post_system_status();
        execute(SUB, 3'd1, 3'd1, 3'd2, 8'd0);
        post_system_status();
        //execute(LOAD, 3'd1, 3'b111, 3'b0);
        //post_system_status();
    end
endmodule