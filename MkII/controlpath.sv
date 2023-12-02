module controlpath(
    input logic clk, reset, 

    input logic[31:0] machine_code,
    output logic[2:0] alu_function_sel,
    output tri alu_store_1, alu_store_2, alu_broadcast,
    
    output tri[4:0] register_index,
    output tri register_read_enable, register_write_enable, 
    output logic[31:0] imm, output tri imm_EN
);

    logic[4:0] instruction_counter;

    // Update Instruction Counter every clock cycle
    logic[4:0] rs2, rs1, rd;
    logic[2:0] funct3;
    logic[6:0] funct7;
    typedef enum logic[2:0] { R = 1, I, S, SB, U, UJ } FMT;
    FMT instruction_type;

    assign opcode = machine_code[6:0];

    logic f_add, f_sub, f_sll;
    logic f_addi; 


    always_comb begin // Instruction Classification
        f_add = 1'b1;
        f_addi = 1'b0;


        // Add I_Format branches
        case (opcode)
            7'b0000011: instruction_type = I;
            7'b0001111: instruction_type = I;
            7'b0010011: instruction_type = I;
            7'b0010111: instruction_type = U;
            7'b0011011: instruction_type = I;
            7'b0100011: instruction_type = S;
            7'b0110011: instruction_type = R;
            7'b0110111: instruction_type = U;
            7'b0111011: instruction_type = R;
            7'b1100111: instruction_type = SB;
            7'b1100111: instruction_type = I;
            7'b1110011: instruction_type = I;
        endcase
        
        case (instruction_type)
            I: begin
                imm = {20'b0, funct7, rs2};
                if(funct3 == 3'b000 && funct7 == 7'b0010011) begin
                    f_addi = 1'b1;
                end 
            end
            U: begin
                imm = {12'b0, funct7, rs2, rs1, funct3};
            end
            S: begin
                imm = {20'b0, funct7, rd};
                
            end
            R: begin
                if(funct3 == 3'b000 && funct7 == 7'b0000000) begin
                    f_add = 1'b1;
                end 
                if(funct3 == 3'b000 && funct7 == 7'b0100000) begin
                    f_sub = 1'b1;
                end
                if(funct3 == 3'b001 && funct7 == 7'b0000000) begin
                    f_sll = 1'b1;
                end
            end

            SB: begin
                
            end
            UJ: begin
                
            end
        endcase

    end

logic[5:0] Function_CTR;

Control_add ca(
    .add(f_add), 
    .rd(rd), 
    .rs1(rs1), 
    .rs2(rs2),
    .Function_CTR(Function_CTR), 

    .Reg_R_EN(register_read_enable), 
    .Reg_W_EN(register_write_enable), 
    .ALU1_W_EN(alu_store_1), 
    .ALU2_W_EN(alu_store_2), 
    .ALU0_R_EN(alu_broadcast), 
    .DONE(DONE), 

    .alu_function_sel(alu_function_sel), 
    .Reg_INDEX(register_index));


Control_addi cai(
    .addi(f_addi), 
    .rd(rd), 
    .rs1(rs1), 
    .rs2(rs2),
    .Function_CTR(Function_CTR), 

    .imm_EN(imm_EN),
    .Reg_R_EN(register_read_enable), 
    .Reg_W_EN(register_write_enable), 
    .ALU1_W_EN(alu_store_1), 
    .ALU2_W_EN(alu_store_2), 
    .ALU0_R_EN(alu_broadcast), 
    .DONE(DONE), 

    .alu_function_sel(alu_function_sel), 
    .Reg_INDEX(register_index)
);
    
    
endmodule

