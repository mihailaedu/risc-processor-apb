
module ralu
    (
       input logic clk,
       input logic [3:0] opcode,
       input logic [3:0] addr_operand0,
       input logic [3:0] addr_operand1,
       input logic w_en,
       input logic [3:0] addr_result,
       input logic [15:0] data_mem_data_read,
       input logic [15:0] instr_value,
       output logic [15:0] operand0,
       output logic [15:0] result,
       output logic zero_flag,
       output logic [15:0] operand1
    );
  
  
    
logic [15:0] register_file0_X_operand1;
logic ALU0_X_zero;
logic [15:0] ralu_operand1;

 
 
 
  
register_file register_file0(
        .clk(clk),
        .addr_operand0(addr_operand0),
        .addr_operand1(addr_operand1),
        .operand0(operand0),
        .operand1(register_file0_X_operand1),
        .w_en(w_en),
        .addr_result(addr_result),
        .data_write(result)
    );  
    
Mux Mux0(          
        .in0(0),      
        .in1(register_file0_X_operand1),       
        .in2(register_file0_X_operand1),     
        .in3(register_file0_X_operand1),
        .in4(register_file0_X_operand1),
        .in5(0),
        .in6(register_file0_X_operand1),
        .in7(register_file0_X_operand1),
        .in8(register_file0_X_operand1),
        .in9(0),
        .in10(instr_value),
        .in11(instr_value),
        .in12(instr_value),
        .in13(register_file0_X_operand1),
        .in14(data_mem_data_read),
        .in15(0),
        .sel(opcode),
        .out(ralu_operand1)
    );
    
ALU ALU0
    (
        .opcode(opcode),
        .operand0(operand0),
        .operand1(ralu_operand1),
        .result(result),
        .zero(ALU0_X_zero)
    );    
    
REG_ZERO_FLAG REG_ZERO_FLAG0
    (
        .clk(clk),
        .in(ALU0_X_zero),
        .out(zero_flag)
    );    
    
 assign operand1 = ralu_operand1;
    
    
        
    
endmodule










