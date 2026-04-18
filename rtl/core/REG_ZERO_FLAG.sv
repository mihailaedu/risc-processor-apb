module REG_ZERO_FLAG
    (
        input logic clk,
        input logic in,
        output logic out
    );

always_ff@(posedge clk) begin
    out <= in; //din motive de simulator 
end

endmodule