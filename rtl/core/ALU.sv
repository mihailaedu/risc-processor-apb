module ALU(
        input logic [3:0] opcode,
        input logic [15:0] operand0,
        input logic [15:0] operand1,
        output logic [15:0] result,
        output logic  zero
    );
      
always_comb
    begin
    if(result == 0 )
        zero=1;
    else
        zero=0;
    end
    
//assign zero = (result == 0);
   
    
    always_comb begin        
        case(opcode)
            0: result = operand0;            // NOP
            1: result = operand0 + operand1; // ADD
            2: result = operand0 - operand1; // SUB
            3: result = operand0 * operand1; // MULT
            4: result = operand1 >> 1;       // SHIFT 1 RIGHT
            5: result = 0;                  
            6: result = operand0 & operand1; // AND 
            7: result = operand0 | operand1; // OR
            8: result = operand0 ^ operand1; // XOR
            9: result = 0;
            10: result = operand1;
            11: result = operand1;
            12: result = operand1;
            13: result = operand0;
            14: result = operand1;
            15: result = 0;             
            
            default: result = 0;
            
        endcase
    
    end
endmodule