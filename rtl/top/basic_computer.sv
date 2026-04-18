module basic_computer(
    input logic clk,
    input logic rst    
    );

logic [15:0] procesor0_X_data_mem_addr_read;
logic [15:0] procesor0_X_data_mem_addr_write;
logic [15:0] procesor0_X_data_mem_data_write;
logic procesor0_X_data_mem_w_en;
logic [15:0] data_mem0_X_data_read;
logic [7:0] procesor0_X_instr_mem_addr_read;
logic [31:0] instr_mem0_X_data_read;

   
procesor procesor0(
        .clk(clk),
        .reset(rst),
        .instr_mem_data_read(instr_mem0_X_data_read),
        .data_mem_data_read(data_mem0_X_data_read),
        .data_mem_addr_read(procesor0_X_data_mem_addr_read),
        .data_mem_addr_write(procesor0_X_data_mem_addr_write),
        .data_mem_data_write(procesor0_X_data_mem_data_write),
        .instr_mem_addr_read(procesor0_X_instr_mem_addr_read),
        .data_mem_w_en(procesor0_X_data_mem_w_en)
);
  
data_mem data_mem0(
    .clk(clk),
    .addr_read(procesor0_X_data_mem_addr_read),
    .addr_write(procesor0_X_data_mem_addr_write),
    .data_write(procesor0_X_data_mem_data_write),
    .w_en(procesor0_X_data_mem_w_en),
    .data_read(data_mem0_X_data_read)
);  

instr_mem instr_mem0(
    .addr_read(procesor0_X_instr_mem_addr_read),
    .data_read(instr_mem0_X_data_read)    
);
 
    
    
endmodule

