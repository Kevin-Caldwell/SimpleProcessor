module CounterHigh #(parameter RESET_VAL) (
    input logic clock, reset, enable, output logic pulse
);
    parameter N = $clog2(RESET_VAL);
    logic[N:0] count;
    
    always_ff @( posedge clock, posedge reset ) begin
        if(reset) begin
            pulse <= 1'b0;
            count <= {N{1'b0}};
        end
        if(enable) begin
            count = count + 1;
            if(enable == RESET_VAL) begin
                pulse <= 1'b1;
            end
        end
    end
endmodule

module ProgramCounter #(parameter COUNT = 4) (
    input logic clock, reset, enable,
    output logic[COUNT:0] out
);
    always_ff @( posedge clock, posedge reset ) begin
        if(reset || enable) begin
            out <= {{COUNT{1'b0}}, 1'b1};
        end else begin
            out <= out << 1'b1;
        end
        $display("counter up, %d", out);
    end
endmodule