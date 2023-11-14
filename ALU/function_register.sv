module function_register(input logic clock, reset, 
    input logic[4:0] T,
    input logic[2:0] opcode, p1, p2, p3,
    output logic data, done, 
    output logic[3:0] display, fcnOut,
    output logic[2:0] regIn, regOut, ALUout);

    always_comb begin
        data = 1'b0;
        done = 1'b0;
        display = 4'b0;
        fcnOut = 4'b0;
        regIn = 3'b0;
        regOut = 3'b0;
        ALUout = 3'b0;

        case (opcode)
            3'b000: begin // Display
                if(T[1]) begin
                    regOut = p1;
                    display = p2;
                end else if(T[2]) begin
                    regOut = 3'b0;
                    display = 4'b0;
                    done = 1;                    
                end else begin
                    regOut = 3'b0;
                    display = 3'b0;
                    done = 0;
                end
            end

            3'b001: begin // Load
                if(T[1]) begin
                    regIn = p1;
                    data = 1'b1;                    
                end else if(T[2]) begin
                    regOut = 3'b0;
                    data = 1'b0;                    
                end else begin
                    regOut = 3'b0;
                    data = 1'b0;                    
                end
            end

            3'b010: begin // Move
                if(T[1]) begin
                    regIn = p2;
                    regOut = p1;
                end else if(T[2]) begin
                    regIn = 1'b0;
                    regOut = 1'b0;
                    done = 1'b1;                    
                end else begin
                    regIn = 1'b0;
                    regOut = 1'b0;                 
                end
            end

            3'b011: begin // Add
                if(T[1]) begin
                    regOut = p2;
                    ALUout[0] = 1'b1;
                end else if(T[2]) begin
                    regOut = p3;
                    ALUout[1] = 1'b1;
                    ALUout[0] = 1'b0;
                    fcnOut = 3'b001;
                end else if(T[3]) begin
                    regIn = p1;
                    ALUout[1] = 3'b0;
                    ALUout[2] = 3'b1;
                end else if(T[4]) begin
                    ALUout[2] = 3'b0;
                    regIn = 3'b0;
                    done = 1'b1;
                end else begin
                    ALUout = 3'b000;
                    regIn = 3'b0;
                    regOut = 3'b0;
                end            
            end

            3'b100: begin //Subtract
                if(T[1]) begin
                    regOut = p2;
                    ALUout[0] = 1'b1;
                end else if(T[2]) begin
                    regOut = p3;
                    ALUout[1] = 1'b1;
                    ALUout[0] = 1'b0;
                    fcnOut = 3'b010;
                end else if(T[3]) begin
                    regIn = p1;
                    ALUout[1] = 3'b0;
                    ALUout[2] = 3'b1;
                end else if(T[4]) begin
                    ALUout[2] = 3'b0;
                    regIn = 3'b0;
                    done = 1'b1;
                end else begin
                    ALUout = 3'b000;
                    regIn = 3'b0;
                    regOut = 3'b0;
                end
            end
        endcase
    end
    
endmodule