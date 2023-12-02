module function_register(input logic clock, reset, 
    input logic[4:0] T,
    input logic[2:0] opcode, p1, p2, p3,
    output logic data_enable, done, 
    output logic[3:0] display, fcnOut,
    output logic[2:0] regIn, regOut, 
    output logic reg_out_enable,
    output logic[2:0] ALUout);

    always_comb begin
        data_enable = 1'b0;
        done = 1'b0;
        display = 4'b0;
        fcnOut = 4'b0;
        regIn = 3'b0;
        //regOut = 3'b0;
        ALUout = 3'b0;
        reg_out_enable = 1'b0;

        case (opcode)
            3'b000: begin // Display
                if(T[0]) begin
                    regOut = p1;
                    reg_out_enable = 1'b1;
                    display = p2;
                end
                if(T[1]) begin
                    regOut = 3'b0;
                    display = 4'b0;
                    done = 1'b1;                    
                end
            end

            3'b001: begin // Load
                if(T[0]) begin
                    regIn = p1;
                    data_enable = 1'b1;                    
                end 
                if(T[1]) begin
                    data_enable = 1'b0;
                    done = 1'b1;              
                end
            end

            3'b010: begin // Move
                if(T[0]) begin
                    regIn = p2;
                    regOut = p1;
                    reg_out_enable = 1'b1;
                end 
                if(T[1]) begin
                    done = 1'b1;      
                end
            end

            3'b011: begin // Add
                fcnOut = 3'b001;
                if(T[0]) begin // Load First Operand
                    regOut = p2;
                    reg_out_enable = 1'b1;
                    ALUout = 3'b001;
                end 
                if(T[1]) begin // Load Second Operand
                    regOut = p3;
                    reg_out_enable = 1'b1;
                    ALUout = 3'b010;
                end 
                if(T[2]) begin // Store Result
                    ALUout = 3'b100;
                end 
                if(T[3]) begin
                    regIn = p1; // Result
                    done = 1'b1;
                end
            end

            3'b100: begin // Subtract
                fcnOut = 3'b010;
                if(T[0]) begin // Load First Operand
                    regOut = p2;
                    reg_out_enable = 1'b1;
                    ALUout = 3'b001;
                end 
                if(T[1]) begin // Load Second Operand
                    regOut = p3;
                    reg_out_enable = 1'b1;
                    ALUout = 3'b010;
                end 
                if(T[2]) begin // Store Result
                    ALUout = 3'b100;
                end 
                if(T[3]) begin
                    regIn = p1; // Result
                    done = 1'b1;
                end
            end

            3'b101: begin // Add Immediate
                fcnOut = 3'b001;
                if(T[0]) begin // Load First Operand
                    regOut = p2;
                    ALUout = 3'b001;
                end 
                if(T[1]) begin // Load Second Operand
                    regOut = p3;
                    ALUout = 3'b010;
                end 
                if(T[2]) begin // Store Result
                    ALUout = 3'b100;
                end
                if(T[3]) begin
                    regIn = p1; // Result
                    done = 1'b1;
                end
        end
        endcase
    end
    
endmodule