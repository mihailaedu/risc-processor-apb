module procesorAPB(
    input logic clk,
    input logic reset,
    
    //conexiuni memorie intructiuni
    input logic [31:0] instr_mem_data_read,
    output logic [7:0] instr_mem_addr_read,
    
    //conexiuni APB
    output logic pclk,
    output logic preset,
    output logic [9:0] paddr,
    output logic psel,
    output logic penable,
    output logic pwrite,
    output logic [15:0] pwdata,
    input logic [15:0] prdata,
    input logic pready,
    output logic [1:0] periferal_select
    );

logic ralu_zero_flag, control_block_ralu_w_en, control_block_pc_en, control_block_do_jump ;
logic APB_Master_1_block_pc;
logic data_mem_w_en;
logic [15:0] data_mem_data_read;
logic [15:0] data_mem_addr_read;
logic [15:0]  data_mem_data_write;
logic [15:0]  data_mem_addr_write;

control_block control_block_1
    (
        .opcode(instr_mem_data_read [31:28]),
        .zero_flag(ralu_zero_flag),
        .ralu_w_en(control_block_ralu_w_en),
        .pc_en(control_block_pc_en),
        .do_jump(control_block_do_jump),
        .data_mem_w_en(data_mem_w_en)
    );
    
ralu ralu_1
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
    
PC PC_1(
    .clk(clk),
    .reset(reset),
    .en(control_block_pc_en & ~APB_Master_1_block_pc),
    .do_jump(control_block_do_jump),
    .jump_value(data_mem_data_write [7:0]),
    .pc(instr_mem_addr_read)
    );
        
APB_Master APB_Master_1(
    .clk(clk),
    .reset(reset),
    
    // interface to processor
    .data_mem_addr_read(data_mem_addr_read),
    .data_mem_addr_write(data_mem_addr_write),
    .data_mem_data_write(data_mem_data_write),
    .data_mem_data_read(data_mem_data_read),
    .block_pc(APB_Master_1_block_pc),
    .wr_transfer(data_mem_w_en),
    .rd_transfer(instr_mem_data_read[31:28] == 14),
    
    // APB
    .pclk(pclk),
    .preset(preset),
    .paddr(paddr),
    .psel(psel),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .prdata(prdata),
    .pready(pready),
    .periferal_select(periferal_select)
    );        
        
endmodule
