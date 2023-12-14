module controlpath(
    input logic clk, reset, 

    input logic[31:0] machine_code,
    output logic[4:0] alu_function_sel,
    output logic alu_store_1, alu_store_2, alu_broadcast,
    
    output logic[4:0] register_index,
    output logic register_read_enable, register_write_enable, 
    output logic[31:0] imm, output logic imm_EN
);

    logic done;
    logic[4:0] instruction_counter;

    logic[4:0] rs2, rs1, rd;
    logic[2:0] funct3;
    logic[6:0] funct7, opcode;
    typedef enum logic[2:0] { R = 1, I, S, SB, U, UJ } FMT;
    logic[1:0] instruction_type;

    logic start;
    logic[31:0] prev_machine;

    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            start <= 1'b1;
            prev_machine <= 32'b0;
        end

        if(machine_code != prev_machine) begin
            start <= 1'b1;
        end else begin
            start <= 1'b0;
        end
        prev_machine <= machine_code;
    end

    assign opcode   = machine_code[6:0];
    assign rd       = machine_code[11:7];
    assign funct3   = machine_code[14:12];
    assign rs1      = machine_code[19:15];
    assign rs2      = machine_code[24:20];
    assign funct7   = machine_code[31:25];

    logic testing;

    // Update Instruction Counter every clock cycle
    always_ff @( posedge clk, posedge reset ) begin
        if(reset) begin
            instruction_counter <= 5'b0;
        end else if(start)begin
            instruction_counter <= 5'b00001;
        end else begin
            instruction_counter <= instruction_counter << 1;
        end
    end

    always_comb begin // Instruction Classification
        alu_function_sel = 5'b0;

        // Load Byte lb
        if(opcode == 7'b0000011 && funct3 == 3'b000) begin
            
        end 

        // Load Half Word lh
        if(opcode == 7'b0000011 && funct3 == 3'b001) begin
            
        end 

        // Load Word
        if(opcode == 7'b0000011 && funct3 == 3'b010) begin
            
        end 
        // Load Double Word NOT APPLICABLE
        if(opcode == 7'b0000011 && funct3 == 3'b011) begin
            
        end 
        // Load Byte Unsigned lbu
        if(opcode == 7'b0000011 && funct3 == 3'b100) begin
            
        end 

        // Load Half Word Unsigned lhw
        if(opcode == 7'b0000011 && funct3 == 3'b101) begin
            
        end 

        // Load Word Unsigned lwu
        if(opcode == 7'b0000011 && funct3 == 3'b110) begin
            
        end 

        // fence
        if(opcode == 7'b0001111 && funct3 == 3'b000) begin
            
        end 

        // fence.i
        if(opcode == 7'b0001111 && funct3 == 3'b001) begin
            
        end 

        // Add Immediate addi
        if(opcode == 7'b0010011 && funct3 == 3'b000) begin
            alu_function_sel = 5'd12;
            instruction_type = 2'b01;
        end 

        // Shift Left Logical Immediate slli
        if(opcode == 7'b0010011 && funct3 == 3'b001 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd4;
            instruction_type = 2'b01;
        end 

        // slti
        if(opcode == 7'b0010011 && funct3 == 3'b010) begin
            alu_function_sel = 5'd7;
            instruction_type = 2'b01;
        end 

        // sltiu
        if(opcode == 7'b0010011 && funct3 == 3'b011) begin
            alu_function_sel = 5'd7;
            instruction_type = 2'b01;
        end 
        // xori
        if(opcode == 7'b0010011 && funct3 == 3'b100) begin
            alu_function_sel = 5'd3;
            instruction_type = 2'b01;
        end 
        // srli
        if(opcode == 7'b0010011 && funct3 == 3'b101 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd5;
            instruction_type = 2'b01;
        end
        // srai
        if(opcode == 7'b0010011 && funct3 == 3'b101 && funct7 == 7'b0100000) begin
            alu_function_sel = 5'd6;
            instruction_type = 2'b01;
        end
        // ori
        if(opcode == 7'b0010011 && funct3 == 3'b110) begin
            alu_function_sel = 5'd1;
            instruction_type = 2'b01;
        end
        // andi
        if(opcode == 7'b0010011 && funct3 == 3'b111) begin
            alu_function_sel = 5'd2;
            instruction_type = 2'b01;
        end
        // auipc
        if(opcode == 7'b0010011) begin
            
        end
        // addiw
        if(opcode == 7'b0010011 && funct3 == 3'b000) begin
            alu_function_sel = 5'd12;
            instruction_type = 2'b01;
        end
        // slliw
        if(opcode == 7'b0010011 && funct3 == 3'b001 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd4;
            instruction_type = 2'b01;
        end

        // srliw
        if(opcode == 7'b0010011 && funct3 == 3'b101 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd5;
            instruction_type = 2'b01;
        end
        // sraiw
        if(opcode == 7'b0010011 && funct3 == 3'b101 && funct7 == 7'b0100000) begin
            alu_function_sel = 5'd6;
            instruction_type = 2'b01;
        end
        // sb
        if(opcode == 7'b0100011 && funct3 == 3'b000) begin
            
        end

        // sh
        if(opcode == 7'b0100011 && funct3 == 3'b001) begin
            
        end

        // sw
        if(opcode == 7'b0100011 && funct3 == 3'b010) begin
            
        end

        // sd
        if(opcode == 7'b0100011 && funct3 == 3'b011) begin
            
        end

        // add
        if(opcode == 7'b0110011 && funct3 == 3'b000 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd12;
            instruction_type = 2'b10;
        end

        // sub
        if(opcode == 7'b0110011 && funct3 == 3'b000 && funct7 == 7'b0100000) begin
            alu_function_sel = 5'd13;
            instruction_type = 2'b10;
        end

        // sll
        if(opcode == 7'b0110011 && funct3 == 3'b100 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd4;
            instruction_type = 2'b10;
        end

        // slt
        if(opcode == 7'b0110011 && funct3 == 3'b010 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd7;
            instruction_type = 2'b10;
        end

        // sltu
        if(opcode == 7'b0110011 && funct3 == 3'b011 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd7;
            instruction_type = 2'b10;
        end

        // xor
        if(opcode == 7'b0110011 && funct3 == 3'b100 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd3;
            instruction_type = 2'b10;
        end

        // srl
        if(opcode == 7'b0110011 && funct3 == 3'b101 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd5;
            instruction_type = 2'b10;
        end

        // sra
        if(opcode == 7'b0110011 && funct3 == 3'b10 && funct7 == 7'b0100000) begin
            alu_function_sel = 5'd6;
            instruction_type = 2'b10;
        end

        // or
        if(opcode == 7'b0110011 && funct3 == 3'b110 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd1;
            instruction_type = 2'b10;
        end

        // and
        if(opcode == 7'b0110011 && funct3 == 3'b111 && funct7 == 7'b0100000) begin
            alu_function_sel = 5'd2;
            instruction_type = 2'b10;
        end

        // lui
        if(opcode == 7'b0110111) begin
            alu_function_sel = 5'd2;
            instruction_type = 2'b11;
        end

        // addw
        if(opcode == 7'b0111011 && funct3 == 3'b100 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd12;
            instruction_type = 2'b10;
        end

        // subw
        if(opcode == 7'b0111011 && funct3 == 3'b000 && funct7 == 7'b0100000) begin
            alu_function_sel = 5'd12;
            instruction_type = 2'b10;
        end

        // sllw
        if(opcode == 7'b0111011 && funct3 == 3'b001 && funct7 == 7'b0000000) begin
            alu_function_sel = 5'd12;
            instruction_type = 2'b10;
        end

        // srlw
        if(opcode == 7'b0111011 && funct3 == 3'b101 && funct7 == 7'b0000000) begin
            instruction_type = 2'b10;
        end

        // sraw
        if(opcode == 7'b0111011 && funct3 == 3'b101 && funct7 == 7'b0100000) begin
            alu_function_sel = 5'd12;
            instruction_type = 2'b10;
        end

        // beq
        if(opcode == 7'b1100011 && funct3 == 3'b000) begin
            alu_function_sel = 5'd9;
        end

        // bne
        if(opcode == 7'b1100011 && funct3 == 3'b001) begin
            
        end

        // blt
        if(opcode == 7'b1100011 && funct3 == 3'b100) begin
            
        end

        // bge
        if(opcode == 7'b1100011 && funct3 == 3'b101) begin
            
        end

        // bltu
        if(opcode == 7'b1100011 && funct3 == 3'b110) begin
            
        end

        // bgeu
        if(opcode == 7'b1100011 && funct3 == 3'b111) begin
            
        end

        // jalr
        if(opcode == 7'b1100111 && funct3 == 3'b000) begin
            
        end

        // jal
        if(opcode == 7'b1101111) begin
            
        end

        // ecall
        if(opcode == 7'b1110011 && funct3 == 3'b000 && {funct7, rs2} == 12'b000000000000) begin
            
        end

        // ebreak
        if(opcode == 7'b1110011 && funct3 == 3'b000 && {funct7, rs2} == 12'b000000000001) begin
            
        end

        // CSRRW
        if(opcode == 7'b1110011 && funct3 == 3'b001) begin
            
        end

        // CSRRS
        if(opcode == 7'b1110011 && funct3 == 3'b010) begin
            
        end

        // CSRRC
        if(opcode == 7'b1110011 && funct3 == 3'b011) begin
            
        end

        // CSRRWI
        if(opcode == 7'b1110011 && funct3 == 3'b101) begin
            
        end

        // CSRRSI
        if(opcode == 7'b1110011 && funct3 == 3'b110) begin
            
        end
        
        // CSRRCI
        if(opcode == 7'b1110011 && funct3 == 3'b111) begin
            
        end
    end
    
    logic[5:0] testing_sel, register_read_enable_sel, register_write_enable_sel, 
    alu_store_1_sel, alu_store_2_sel, alu_broadcast_sel, imm_EN_sel, done_sel;
    logic[5:0][31:0] imm_out_sel;
    logic[5:0][4:0] register_index_out;

    Control_Calculate_Immediate cci0(
        .instruction_counter(instruction_counter),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .funct7(funct7),
        .opcode(opcode),
        .funct3(funct3),
        .testing(testing_sel[0]),
        .imm(imm_out_sel[0]),
        .register_index(register_index_out[0]),
        .register_read_enable(register_read_enable_sel[0]),
        .register_write_enable(register_write_enable_sel[0]),
        .alu_store_1(alu_store_1_sel[0]),
        .alu_store_2(alu_store_2_sel[0]),
        .alu_broadcast(alu_broadcast_sel[0]),
        .imm_EN(imm_EN_sel[0]),
        .done(done_sel[0])
    );

    Control_Calculate cc0(
        .instruction_counter(instruction_counter),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .funct7(funct7),
        .opcode(opcode),
        .funct3(funct3),
        .testing(testing_sel[1]),
        .imm(imm_out_sel[1]),
        .register_index(register_index_out[1]),
        .register_read_enable(register_read_enable_sel[1]),
        .register_write_enable(register_write_enable_sel[1]),
        .alu_store_1(alu_store_1_sel[1]),
        .alu_store_2(alu_store_2_sel[1]),
        .alu_broadcast(alu_broadcast_sel[1]),
        .imm_EN(imm_EN_sel[1]),
        .done(done_sel[1])
    );

    Control_lui clui(
        .instruction_counter(instruction_counter),
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .funct7(funct7),
        .opcode(opcode),
        .funct3(funct3),
        .testing(testing_sel[2]),
        .imm(imm_out_sel[2]),
        .register_index(register_index_out[2]),
        .register_read_enable(register_read_enable_sel[2]),
        .register_write_enable(register_write_enable_sel[2]),
        .alu_store_1(alu_store_1_sel[2]),
        .alu_store_2(alu_store_2_sel[2]),
        .alu_broadcast(alu_broadcast_sel[2]),
        .imm_EN(imm_EN_sel[2]),
        .done(done_sel[2])
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

        if(instruction_type == 2'b01) begin
            testing = testing_sel[0];
            imm = imm_out_sel[0];
            register_index = register_index_out[0];
            register_read_enable = register_read_enable_sel[0];
            register_write_enable = register_write_enable_sel[0];
            alu_store_1 = alu_store_1_sel[0];
            alu_store_2 = alu_store_2_sel[0];
            alu_broadcast = alu_broadcast_sel[0];
            imm_EN = imm_EN_sel[0];
            done = done_sel[0];

        end else if(instruction_type == 2'b10) begin
            testing = testing_sel[1];
            imm = imm_out_sel[1];
            register_index = register_index_out[1];
            register_read_enable = register_read_enable_sel[1];
            register_write_enable = register_write_enable_sel[1];
            alu_store_1 = alu_store_1_sel[1];
            alu_store_2 = alu_store_2_sel[1];
            alu_broadcast = alu_broadcast_sel[1];
            imm_EN = imm_EN_sel[1];
            done = done_sel[1];
        end else if(instruction_type == 2'b11) begin
            testing = testing_sel[2];
            imm = imm_out_sel[2];
            register_index = register_index_out[2];
            register_read_enable = register_read_enable_sel[2];
            register_write_enable = register_write_enable_sel[2];
            alu_store_1 = alu_store_1_sel[2];
            alu_store_2 = alu_store_2_sel[2];
            alu_broadcast = alu_broadcast_sel[2];
            imm_EN = imm_EN_sel[2];
            done = done_sel[2];
        end

    end
endmodule