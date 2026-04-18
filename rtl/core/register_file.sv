module register_file(
        input logic clk,
        input logic [3:0] addr_operand0,
        input logic [3:0] addr_operand1,
        output logic [15:0] operand0,
        output logic [15:0] operand1,
        input logic w_en,
        input logic [3:0] addr_result,
        input logic [15:0] data_write
    );
    
logic [15:0] registre [0:2**4-1];

always_ff @(posedge clk) begin
    if(w_en == 1)
        registre[addr_result] <= data_write;
    
end

always_comb begin
    operand0 = registre[addr_operand0];
    operand1 = registre[addr_operand1];
end
endmodule
