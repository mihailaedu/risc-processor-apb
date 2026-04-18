module BTN_APB(
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
    
    // to buttons
    input logic [3:0]  buttons 
    );
    
logic [3:0] btn_reg;

always_ff@(posedge pclk) begin
    if(preset)
        btn_reg <= 0;
    else
        btn_reg <= buttons;    
end

assign pready = 1;
assign prdata = (psel & pready & penable & (~pwrite)) ? {12'b0, btn_reg} : 0;



endmodule
