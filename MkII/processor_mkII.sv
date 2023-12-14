module processor_MKII(input logic clk, reset, 
    input logic[31:0] machine_code);

    logic Reg_R_EN, Reg_W_EN, 
    ALU1_W_EN, ALU2_W_EN, ALU0_R_EN; // Enable Signals
    logic[4:0] ALU_fcn;
    logic[4:0] Reg_INDEX;
    
    logic[31:0] immediate;
    logic immediate_EN;

    datapath d0(
        .clk(clk), 
        .reset(reset), 

        .alu_function_sel(ALU_fcn), 
        .alu_store_1(ALU1_W_EN), 
        .alu_store_2(ALU2_W_EN), 
        .alu_broadcast(ALU0_R_EN), 

        .register_index(Reg_INDEX), 
        .register_read_enable(Reg_R_EN), 
        .register_write_enable(Reg_W_EN),
        
        .imm(immediate), 
        .imm_EN(immediate_EN)
    );

    controlpath c0(
        .clk(clk), 
        .reset(reset), 
        .machine_code(machine_code), 

        .alu_function_sel(ALU_fcn), 
        .alu_store_1(ALU1_W_EN), 
        .alu_store_2(ALU2_W_EN), 
        .alu_broadcast(ALU0_R_EN), 

        .register_index(Reg_INDEX), 
        .register_read_enable(Reg_R_EN), 
        .register_write_enable(Reg_W_EN),

        .imm(immediate), 
        .imm_EN(immediate_EN)
    );
endmodule