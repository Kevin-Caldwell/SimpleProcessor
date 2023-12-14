module mkII_tb();

    logic clk, reset;

    always #2 clk = ~clk;
    logic[31:0] machine_code;

    processor_MKII p1(clk, reset, machine_code);

    task RESET_HARD();
        clk = 1'b0;
        machine_code = 32'b0;
        reset = 1'b1; #10 reset = 1'b0; #10;
        
    endtask

    task RESET_SOFT();
        reset = 1'b1; #10 reset = 1'b0;
    endtask

    task PUSH_MACHINE_CODE(logic[31:0] binary_code);
        machine_code = binary_code; #30;
    endtask

    initial begin
        RESET_HARD();
        PUSH_MACHINE_CODE(32'b00000000000100000000010000010011);
        PUSH_MACHINE_CODE(32'b00000000000101000001010010010011);
        PUSH_MACHINE_CODE(32'b00000000111111111111100110110111);
        PUSH_MACHINE_CODE(32'b00000000101010011000100110010011);
    end

    logic[31:0][31:0] regs_tb;
    assign regs_tb = p1.d0.registers;
    logic[31:0] bus_tb;
    assign bus_tb = p1.d0.bus;
    logic ALU_fcn_tb, Reg_R_EN_tb, Reg_W_EN_tb;
 
    logic[4:0] T, rd_tb, rs1_tb, rs2_tb;
    logic[6:0] opcode;
    logic[2:0] funct3_tb;
    assign opcode = p1.c0.opcode;
    assign T = p1.c0.instruction_counter;
    assign rd_tb = p1.c0.rd;
    assign rs1_tb = p1.c0.rs1;
    assign rs2_tb = p1.c0.rs2;

    assign funct3_tb = p1.c0.funct3;
    logic operation;
    assign operation = p1.c0.testing;

    assign ALU_fcn_tb = p1.ALU_fcn;
    assign Reg_R_EN_tb = p1.Reg_R_EN;
    assign Reg_W_EN_tb = p1.Reg_W_EN;

    logic[31:0] register_read_tb;
    assign register_read_tb = p1.d0.registers_read;
    logic[4:0] register_index_tb;
    assign register_index_tb = p1.Reg_INDEX;

    logic alu_1en_tb, alu_2en_tb, alu_outen_tb;
    assign alu_1en_tb = p1.ALU1_W_EN;
    assign alu_2en_tb = p1.ALU2_W_EN;
    assign alu_outen_tb = p1.ALU0_R_EN;

    logic[31:0] alu_1_tb, alu_2_tb, alu_out_tb;
    assign alu_1_tb = p1.d0.alu_1;
    assign alu_2_tb = p1.d0.alu_2;
    assign alu_out_tb = p1.d0.alu_out;

    logic[1:0] instruction_type_tb;
    assign instruction_type_tb = p1.c0.instruction_type;
endmodule

/*
Memory: 
*/
module memory_io(
    input logic clock, reset, 

    input logic[31:0] Din, 
    output logic[31:0] Dout,

    input logic[11:0] Address,
    input logic R, W
);

    
    initial begin
        
    end
endmodule