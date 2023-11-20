module register(input logic CLK, EN, RESET, 
    input logic IN,
    output logic OUT);
    always_ff @( posedge CLK, posedge RESET ) begin
        if(RESET) begin
            OUT <= 1'b0;
        end else begin
            if(EN) begin
                OUT <= IN;
            end
        end
    end
endmodule

module register8(input logic CLK, EN, RESET, 
    input logic[7:0] in, output logic[7:0] out);
    
    always_ff @( posedge CLK, posedge RESET ) begin
        if(RESET) begin
            out <= 8'b0;
        end else begin
            if(EN) begin
                out <= in;
            end
        end
    end
endmodule

module register_bank(input logic CLK, RESET, 
    input logic[2:0] enIn, enOut,
    input logic[7:0] IN, 
    output logic[7:0] OUT, output logic[63:0] test_out);
    logic[7:0] outBuff0, outBuff1,
        outBuff2, outBuff3, 
        outBuff4, outBuff5, 
        outBuff6, outBuff7;
    
    logic[7:0] enInX;

    Decoder3to8 d0(enIn, enInX);
   
    register8 r0(CLK, 1'b0, RESET, 8'b0, outBuff0);
    register8 r1(CLK, enInX[1], RESET, IN, outBuff1);
    register8 r2(CLK, enInX[2], RESET, IN, outBuff2);
    register8 r3(CLK, enInX[3], RESET, IN, outBuff3);
    register8 r4(CLK, enInX[4], RESET, IN, outBuff4);
    register8 r5(CLK, enInX[5], RESET, IN, outBuff5);
    register8 r6(CLK, enInX[6], RESET, IN, outBuff6);
    register8 r7(CLK, enInX[7], RESET, IN, outBuff7);

    mux8to1 m0(outBuff0, outBuff1, 
        outBuff2, outBuff3, 
        outBuff4, outBuff5, 
        outBuff6, outBuff7, enOut, OUT);  

    always_comb begin
        test_out[7:0] = outBuff0;
        test_out[15:8] = outBuff1;
        test_out[23:16] = outBuff2;
        test_out[31:24] = outBuff3;
        test_out[39:32] = outBuff4;
        test_out[47:40] = outBuff5;
        test_out[55:48] = outBuff6;
        test_out[63:56] = outBuff7;
    end
    

endmodule