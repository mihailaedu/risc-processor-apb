`timescale 1ns / 1ps

module test();

logic clk_tb;
logic rst_tb;  
 
 basic_computer dut(
    .clk(clk_tb),
    .rst(rst_tb)    
    );   

initial 
    begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
end  
 
 
 initial
    begin
        rst_tb <= 1;
        @(posedge clk_tb);
        rst_tb <= 0;
        #300;
        $stop();
end 
 
 /*   
initial
    begin
        rst_tb <= 1;
    #10 rst_tb <= 0;
    #300;
    $stop();
end    
 */
 
initial
    begin
    dut.instr_mem0.mem_instr[0] = 32'b1010_0111_0000_0000_0000_0000_0000_1010;
    dut.instr_mem0.mem_instr[1] = 32'b1010_1001_0000_0000_0000_0000_0000_0110;
    dut.instr_mem0.mem_instr[2] = 32'b0010_0101_0111_1001_0000_0000_0000_0000;
    dut.instr_mem0.mem_instr[3] = 32'b1111_0000_0000_0000_0000_0000_0000_0000;
    end 
 
 
 
    
endmodule
