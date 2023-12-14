module IO_controller(
    input logic clk, reset, 
    input logic[31:0] address,
    input logic[31:0] Din, 
    output logic[31:0] Dout
    input logic R, W
);
    mem_IO mIO(
        .clk(clk),
        .reset(reset), 
        .Din(Din), 
        .R(R), 
        .W(W), 
        .address(address), 
        .Dout(Dout)
    );
endmodule