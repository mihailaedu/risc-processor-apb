`timescale 1ns / 1ps

module computer_APB_tb();

logic           clk_tb;
logic           reset_tb;
logic           pwm_out_tb;
logic   [3:0]   btn_in_tb;

computer_APB DUT(
    .clk(clk_tb),
    .reset(reset_tb),
    .pwm_out(pwm_out_tb),
    .btn_in(btn_in_tb)
    );
    
initial begin
    clk_tb = 0;
    forever #1 clk_tb = ~clk_tb;    
end

initial begin
           reset_tb = 1;
           btn_in_tb = 4'b0001;
    #2     reset_tb = 0;
    #200   $stop ;
 end

initial begin
    DUT.instr_mem_0.mem_instr[0] = 32'b1010_0000_0000_0000_0000_0000_0000_1110;
    DUT.instr_mem_0.mem_instr[1] = 32'b1010_0001_0000_0000_0000_0000_0001_0001;
    DUT.instr_mem_0.mem_instr[2] = 32'b1010_0010_0000_0000_0000_0000_0001_0110;
    DUT.instr_mem_0.mem_instr[3] = 32'b1010_0011_0000_0000_0000_0000_0101_1100;
    
    DUT.instr_mem_0.mem_instr[4] = 32'b1101_0000_0000_0001_0000_0000_0000_0000;
    DUT.instr_mem_0.mem_instr[5] = 32'b1101_0000_0010_0011_0000_0000_0000_0000;
    
    DUT.instr_mem_0.mem_instr[6] = 32'b1110_0100_0001_0000_0000_0000_0000_0000;
    DUT.instr_mem_0.mem_instr[7] = 32'b1110_0101_0011_0000_0000_0000_0000_0000;
end

/*
initial begin
    DUT.instr_mem_0.mem_instr[0] = 32'b1010_0001_0000_0000_0000_0000_0000_1010;
    DUT.instr_mem_0.mem_instr[1] = 32'b1010_0010_0000_0000_0000_1100_0000_0001;
    DUT.instr_mem_0.mem_instr[2] = 32'b1110_0000_0001_0010_0000_0000_0000_0000;
    DUT.instr_mem_0.mem_instr[3] = 32'b1111_0000_0000_0000_0000_0000_0000_0000;
end
*/

endmodule
