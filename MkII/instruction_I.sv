module Control_Calculate_Immediate(
    input logic[4:0] instruction_counter,
    input logic[4:0] rs2, rs1, rd, 
    input logic[6:0] funct7, opcode,
    input logic[2:0] funct3,
    output logic testing, 
    output logic[31:0] imm,
    output logic[4:0] register_index,
    output logic register_read_enable,
    register_write_enable, 
    alu_store_1, alu_store_2, 
    alu_broadcast,
    imm_EN, done

);
    always_comb begin
        testing = 1'b1;
        alu_store_1 = 1'b0;
        alu_store_2 = 1'b0;
        alu_broadcast = 1'b0;
        register_index = 5'b0;
        register_read_enable = 1'b0;
        register_write_enable = 1'b0;
        imm_EN = 1'b0;
        done = 1'b0;
        if(instruction_counter[0]) begin
            imm = {20'b0, funct7, rs2};
            register_index = rs1;
            register_read_enable = 1'b1;
            alu_store_1 = 1'b1;
        end
        if(instruction_counter[1]) begin
            imm_EN = 1'b1;
            alu_store_2 = 1'b1;
        end
        if(instruction_counter[2]) begin
            alu_broadcast = 1'b1;
            register_index = rd;
            register_write_enable = 1'b1;
            done = 1'b1;
        end
    end
endmodule

module Control_Calculate(
    input logic[4:0] instruction_counter,
    input logic[4:0] rs2, rs1, rd, 
    input logic[6:0] funct7, opcode,
    input logic[2:0] funct3,
    output logic testing, 
    output logic[31:0] imm,
    output logic[4:0] register_index,
    output logic register_read_enable,
    register_write_enable, 
    alu_store_1, alu_store_2, 
    alu_broadcast,
    imm_EN, done

);
    always_comb begin
        testing = 1'b0;
        alu_store_1 = 1'b0;
        alu_store_2 = 1'b0;
        alu_broadcast = 1'b0;
        register_index = 5'b0;
        register_read_enable = 1'b0;
        register_write_enable = 1'b0;
        imm_EN = 1'b0;
        done = 1'b0;

        if(instruction_counter[0]) begin
            register_index = rs1;
            register_read_enable = 1'b1;
            alu_store_1 = 1'b1;
        end
        if(instruction_counter[1]) begin
            register_index = rs2;
            register_read_enable = 1'b1;
            alu_store_2 = 1'b1;
        end
        if(instruction_counter[2]) begin
            alu_broadcast = 1'b1;
            register_index = rd;
            register_write_enable = 1'b1;
            done = 1'b1;
        end
    end
endmodule

module Control_lui(
    input logic[4:0] instruction_counter,
    input logic[4:0] rs2, rs1, rd, 
    input logic[6:0] funct7, opcode,
    input logic[2:0] funct3,
    output logic testing, 
    output logic[31:0] imm,
    output logic[4:0] register_index,
    output logic register_read_enable,
    register_write_enable, 
    alu_store_1, alu_store_2, 
    alu_broadcast,
    imm_EN, done);
    always_comb begin
        testing = 1'b0;
        alu_store_1 = 1'b0;
        alu_store_2 = 1'b0;
        alu_broadcast = 1'b0;
        register_index = 5'b0;
        register_read_enable = 1'b0;
        register_write_enable = 1'b0;
        done = 1'b0;
        imm = {funct7, rs2, rs1, funct3, 12'b0};
        // lui
        if(opcode == 7'b0110111) begin
            testing = 1'b1;

            if(instruction_counter[0]) begin
                imm_EN = 1'b1;
                register_index = rd;
                register_write_enable = 1'b1;
            end
            if(instruction_counter[1]) begin
                done = 1'b1;
            end
        end
    end
endmodule

module Control_branch(
    input logic[4:0] instruction_counter,
    input logic[4:0] rs2, rs1, rd, 
    input logic[6:0] funct7, opcode,
    input logic[2:0] funct3,
    output logic testing, 
    output logic[31:0] imm,
    output logic[4:0] register_index,
    output logic register_read_enable,
    register_write_enable, 
    alu_store_1, alu_store_2, 
    alu_broadcast,
    imm_EN, done);
    instruc
endmodule