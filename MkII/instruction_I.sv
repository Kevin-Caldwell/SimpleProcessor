typedef enum logic[5:0] { 
    I_NONE =    6'b000000,
    I_ONE =     6'b000001, 
    I_TWO =     6'b000010, 
    I_THREE =   6'b000100, 
    I_FOUR =    6'b001000,
    I_FIVE =    6'b010000, 
    I_SIX =     6'b100000
} INSTRUCTION_COUNT;

module Control_add(input logic add, 
    input logic[4:0] rd, rs1, rs2, 
    input logic[5:0] Function_CTR,
    output logic Reg_R_EN, Reg_W_EN, 
    ALU1_W_EN, ALU2_W_EN, ALU0_R_EN, 
    DONE, 
    output logic[2:0] alu_function_sel,
    output logic[4:0] Reg_INDEX);

    always_comb begin
        if(add) begin
            alu_function_sel = 3'b001;
            case (Function_CTR)
                I_ONE: begin
                    Reg_INDEX = rs1;
                    Reg_R_EN = 1'b1;
                    ALU1_W_EN = 1'b1;
                end 
                I_TWO: begin
                    Reg_INDEX = rs2;
                    Reg_R_EN = 1'b1;
                    ALU2_W_EN = 1'b1;
                end
                I_THREE: begin
                    Reg_INDEX = rd;
                    Reg_W_EN = 1'b1;
                    ALU0_R_EN = 1'b1;
                end
                I_FOUR: begin
                    DONE = 1'b1;
                end
                I_FIVE: begin
                    
                end
                default: DONE = 1'b0;
            endcase
        end else begin
            Reg_R_EN = 1'bZ;
            Reg_W_EN = 1'bZ;
            ALU1_W_EN = 1'bZ;
            ALU2_W_EN = 1'bZ;
            ALU0_R_EN = 1'bZ;
            DONE = 1'bZ;
            alu_function_sel = 3'bZ;
            Reg_INDEX = 5'bZ;
        end
    end

endmodule

module Control_addi(input logic addi, 
    input logic[4:0] rd, rs1, rs2, 
    input logic[5:0] Function_CTR,
    output logic imm_EN,
    output logic Reg_R_EN, Reg_W_EN, 
    ALU1_W_EN, ALU2_W_EN, ALU0_R_EN, 
    DONE, 
    output logic[2:0] alu_function_sel,
    output logic[4:0] Reg_INDEX);

    always_comb begin
        if(addi) begin
            alu_function_sel = 3'b001;
            case (Function_CTR)
                I_ONE: begin
                    Reg_INDEX = rs1;
                    Reg_R_EN = 1'b1;
                    ALU1_W_EN = 1'b1;
                end 
                I_TWO: begin
                    Reg_INDEX = rs2;
                    Reg_R_EN = 1'b1;
                    ALU2_W_EN = 1'b1;
                end
                I_THREE: begin
                    Reg_INDEX = rd;
                    Reg_W_EN = 1'b1;
                    ALU0_R_EN = 1'b1;
                end
                I_FOUR: begin
                    DONE = 1'b1;
                end
                I_FIVE: begin
                    
                end
                default: DONE = 1'b0;
            endcase
        end else begin
            imm_EN = 1'bZ;
            Reg_R_EN = 1'bZ;
            Reg_W_EN = 1'bZ;
            ALU1_W_EN = 1'bZ;
            ALU2_W_EN = 1'bZ;
            ALU0_R_EN = 1'bZ;
            DONE = 1'bZ;
            alu_function_sel = 3'bZ;
            Reg_INDEX = 5'bZ;
        end
    end

endmodule