module Decoder3to8(input logic[2:0] UNSIGNED, 
    output logic[7:0] ONE_HOT);
    always_comb begin
        case (UNSIGNED)
            3'b000: ONE_HOT = 8'b00000001;
            3'b001: ONE_HOT = 8'b00000010;
            3'b010: ONE_HOT = 8'b00000100;
            3'b011: ONE_HOT = 8'b00001000;
            3'b100: ONE_HOT = 8'b00010000;
            3'b101: ONE_HOT = 8'b00100000;
            3'b110: ONE_HOT = 8'b01000000;
            3'b111: ONE_HOT = 8'b10000000;
            default: ONE_HOT = 8'b0;
        endcase
    end
endmodule

module decoder8to1(
    input logic[7:0] in,
    input logic[2:0] outSel,
    output logic[7:0] out0, out1, out2, out3, out4, out5, out6, out7
);
    always_comb begin
        case (outSel)
            3'b000: out0 = in;
            3'b001: out1 = in;
            3'b010: out2 = in;
            3'b011: out3 = in;
            3'b100: out4 = in;
            3'b101: out5 = in;
            3'b110: out6 = in;
            3'b111: out7 = in;
            default: begin
                out0 = 8'b0;
                out1 = 8'b0;
                out2 = 8'b0;
                out3 = 8'b0;
                out4 = 8'b0;
                out5 = 8'b0;
                out6 = 8'b0;
                out7 = 8'b0;
            end
        endcase
    end
endmodule

module mux8to1(
    input logic[7:0] in0, in1, in2, in3, in4, in5, in6, in7,
    input logic[2:0] sel, 
    output logic[7:0] out
);
    always_comb begin
        case (sel)
            3'b000: out = in0;
            3'b001: out = in1;
            3'b010: out = in2;
            3'b011: out = in3;
            3'b100: out = in4;
            3'b101: out = in5;
            3'b110: out = in6;
            3'b111: out = in7; 
            default: out = 8'b0;
        endcase
    end
endmodule