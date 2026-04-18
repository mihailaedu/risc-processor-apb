module computer_APB(
    input logic clk,
    input logic reset,
    
    output logic pwm_out,
    input logic [3:0] btn_in
    );

logic [7:0] instr_mem_addr_read;
logic [31:0] instr_mem_data_read;

logic        pclk;
logic        preset;
logic [9:0]  paddr;
logic        psel; 
logic        penable;
logic        pwrite;
logic [15:0] pwdata;
logic [15:0] prdata;
logic        pready;
logic [1:0]  periferal_select;

logic psel_mem, psel_pwm, psel_btn, psel_mean;
logic pready_mem, pready_pwm, pready_btn, pready_mean;
logic [15:0] prdata_mem, prdata_pwm, prdata_btn, prdata_mean;


procesorAPB procesorAPB_0(
    .clk(clk),
    .reset(reset),
    
    //conexiuni memorie intructiuni
    .instr_mem_data_read(instr_mem_data_read),
    .instr_mem_addr_read(instr_mem_addr_read),
    
    //conexiuni APB
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
    
    
data_mem_APBSlave data_mem_APBSlave_0(
   .pclk(pclk),
   .paddr(paddr),
   .psel(psel_mem),
   .penable(penable),
   .pwrite(pwrite),
   .pwdata(pwdata),
   .prdata(prdata_mem),
   .pready(pready_mem)
    );    

instr_mem instr_mem_0(
    .addr_read(instr_mem_addr_read),
    .data_read(instr_mem_data_read)    
    );    
    
PWM_APB PWM_APB_0(
    //conexiuni APB
    .pclk(pclk),
    .preset(preset),
    .paddr(paddr),
    .psel(psel_pwm),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .prdata(prdata_pwm),
    .pready(pready_pwm),
    
    //PWM out
    .pwm_out(pwm_out)
    );    

BTN_APB BTN_APB_0(
    //conexiuni APB
    .pclk(pclk),
    .preset(preset),
    .paddr(paddr),
    .psel(psel_btn),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .prdata(prdata_btn),
    .pready(pready_btn),
    
    // to buttons
    .buttons(btn_in) 
    );
    
MEAN_APB MEAN_APB_0(
    .pclk(pclk),
    .preset(preset),
    .paddr(paddr),
    .penable(penable),
    .pwrite(pwrite),
    .pwdata(pwdata),
    .psel(psel_mean),
    .pready(pready_mean),
    .prdata(prdata_mean)
    );     
    
always_comb begin

    psel_mem = 0;
    psel_pwm = 0;
    psel_btn = 0;
    psel_mean = 0;
    
    case(periferal_select)
        0: psel_mem = psel;
        1: psel_pwm = psel;
        2: psel_btn = psel;
        3: psel_mean = psel;
    endcase
end

always_comb begin
    case(periferal_select)
        0:pready = pready_mem;
        1:pready = pready_pwm;
        2:pready = pready_btn;
        3:pready = pready_mean;
        default: pready = 0;
    endcase
end

always_comb begin
    case(periferal_select)
        0:prdata = prdata_mem;
        1:prdata = prdata_pwm;
        2:prdata = prdata_btn;
        3:prdata = prdata_mean;
        default: prdata = 0;
    endcase
end

endmodule