module instr_mem(
    input logic [7:0] addr_read,
    output logic [31:0] data_read    
    );

logic [31:0] mem_instr [0:2**8-1];

assign data_read = mem_instr[addr_read];  
    
endmodule
