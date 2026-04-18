module PWM_APB(
    //conexiuni APB
    input logic        pclk,
    input logic        preset,
    input logic [9:0]  paddr,
    input logic        psel,
    input logic        penable,
    input logic        pwrite,
    input logic [15:0] pwdata,
    output logic[15:0] prdata,
    output logic       pready,
    
    //PWM out
    output logic       pwm_out
    );
    
logic [15:0] counter;
logic reset;
logic configure;
logic [15:0] limit_period, limit_duty;
logic period_reset;

always_ff@(posedge pclk) begin
    if(reset)
        counter <= 0;
    else 
        counter <= counter + 1;
end   

always_ff@(posedge pclk) begin
    if(preset)
        begin
            configure <= 0;
            limit_period <= 0;
            limit_duty <= 0;
        end
    else if(psel & pwrite & penable & pready)
        begin
            case(paddr)
                0: configure <= pwdata[0];
                1: limit_period <= pwdata;
                2: limit_duty <= pwdata;
            endcase
        end 
end    

assign pwm_out = counter < limit_duty;
assign period_reset = counter >= (limit_period - 1);
assign reset = preset | configure | period_reset; 

assign pready = 1;

always_comb begin
    prdata = 0;    
    if(psel & penable & pready & !pwrite)
        begin
            case(paddr)
                0: prdata = {15'b0, configure};
                1: prdata = limit_period;
                2: prdata = limit_duty;
                default: prdata = 0;
            endcase
        end         
end
    
endmodule
