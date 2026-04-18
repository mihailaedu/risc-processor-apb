module APB_Master(
    input logic clk,
    input logic reset,
    
    // interface to processor
    input logic [15:0] data_mem_addr_read,
    input logic [15:0] data_mem_addr_write,
    input logic [15:0] data_mem_data_write,
    output logic [15:0] data_mem_data_read,
    output logic block_pc,
    input logic wr_transfer,
    input logic rd_transfer,
    
    // APB
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
    
localparam IDLE = 0;
localparam ACCESS = 1;
localparam TRANSFER = 2;



logic [1:0] state;
logic [1:0] state_next;

always_ff@(posedge clk) begin
    if(reset == 1)
        state <= IDLE;
    else    
        state <= state_next;
end        

always_comb begin
    state_next = state;
    case(state)
        IDLE: begin
                if(wr_transfer == 1 || rd_transfer == 1)
                    state_next = ACCESS;
              end
    
        ACCESS: begin
                    state_next = TRANSFER;
                end
        
        TRANSFER: begin
                    if(pready == 1) begin
                        if(wr_transfer == 1 || rd_transfer == 1)
                            state_next = ACCESS;
                        else
                            state_next = IDLE;    
                        end
                    end    
    endcase
end    
    
assign pclk = clk;
assign preset = reset;
    
always_comb begin
    data_mem_data_read = 0;
    block_pc = 0;
    paddr = 0;
    psel = 0;
    penable = 0;
    pwrite = 0;
    periferal_select = 0;
    
    case(state)
        IDLE: begin
                if(wr_transfer ==1 || rd_transfer == 1)
                    block_pc = 1;
              end
              
        ACCESS: begin
                    block_pc = 1;
                    paddr = (wr_transfer == 1) ? data_mem_addr_write : data_mem_addr_read; //if ? = daca da : daca nu
                    periferal_select = (wr_transfer) ? data_mem_addr_write[11:10] : data_mem_addr_read[11:10];
                    psel = 1;
                    penable = 0;
                    pwrite = wr_transfer;
                    pwdata = (wr_transfer == 1) ? data_mem_data_write : 0;
                end
        
        TRANSFER: begin
                    data_mem_data_read = (pready & ~pwrite) ? prdata : 0;
                    block_pc = ~pready;
                    paddr = (wr_transfer == 1) ? data_mem_addr_write : data_mem_addr_read;
                    periferal_select = (wr_transfer == 1) ? data_mem_addr_write[11:10] : data_mem_addr_read[11:10];
                    psel = 1;
                    penable = 1;
                    pwrite = wr_transfer;
                    pwdata = (wr_transfer) ? data_mem_data_write : 0;            
                  end          
                     
    endcase
end    
    
    
endmodule
