module procesor(
        input logic clk,
        input logic reset,
        input logic [31:0] instr_mem_data_read,
        input logic [15:0] data_mem_data_read,
        output logic [15:0] data_mem_addr_read,
        output logic [15:0] data_mem_addr_write,
        output logic [15:0] data_mem_data_write,
        output logic [7:0] instr_mem_addr_read,
        output logic data_mem_w_en
    );
logic ralu_zero_flag, control_block_ralu_w_en, control_block_pc_en, control_block_do_jump ;
   
control_block control_block_0
    (
        .opcode(instr_mem_data_read [31:28]),
        .zero_flag(ralu_zero_flag),
        .ralu_w_en(control_block_ralu_w_en),
        .pc_en(control_block_pc_en),
        .do_jump(control_block_do_jump),
        .data_mem_w_en(data_mem_w_en)
    );
    
ralu ralu_0
    (
       .clk(clk),
       .opcode(instr_mem_data_read [31:28]),
       .addr_operand0(instr_mem_data_read [23:20]),
       .addr_operand1(instr_mem_data_read [19:16]),
       .w_en(control_block_ralu_w_en),
       .addr_result(instr_mem_data_read [27:24]),
       .data_mem_data_read(data_mem_data_read),
       .instr_value(instr_mem_data_read [15:0]),
       .operand0(data_mem_addr_read),
       .result(data_mem_data_write),
       .zero_flag(ralu_zero_flag),
       .operand1(data_mem_addr_write)
    );
    
PC PC_0(
    .clk(clk),
    .reset(reset),
    .en(control_block_pc_en),
    .do_jump(control_block_do_jump),
    .jump_value(data_mem_data_write [7:0]),
    .pc(instr_mem_addr_read)
    );
    
    
    
    
    
endmodule










