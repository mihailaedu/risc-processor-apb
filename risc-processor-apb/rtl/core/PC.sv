module PC(
    input logic clk,
    input logic reset,
    input logic en,
    input logic do_jump,
    input logic [7:0] jump_value,
    output logic [7:0] pc
    );
    
always_ff@(posedge clk)
    begin
        if(reset) pc <= 0;
        else 
            if(en)
                if(do_jump) pc <= jump_value;
                else pc <= pc + 1;
            else pc <= pc;
    end

endmodule
