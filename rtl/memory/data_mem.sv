module data_mem(
    input logic clk,
    input logic [15:0] addr_read,
    input logic [15:0] addr_write,
    input logic [15:0] data_write,
    input logic w_en,
    output logic [15:0] data_read
);
    
    logic [15:0] mem[0:2**16-1];
    
    always_ff@(posedge clk)
    begin
        if(w_en)
        begin
            mem[addr_write] <= data_write;
        end
        
    end
    
    assign data_read = mem[addr_read];
    
endmodule
