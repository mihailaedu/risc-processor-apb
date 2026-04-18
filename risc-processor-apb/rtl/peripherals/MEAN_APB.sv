module MEAN_APB(
    input logic pclk,
    input logic preset,
    input logic [9:0] paddr,
    input logic penable,
    input logic pwrite,
    input logic [15:0] pwdata,
    input logic psel,
    output logic pready,
    output logic [15:0] prdata
    );
    
logic [1:0] configure;
logic [15:0] data_a; 
logic [15:0] data_b; 
logic [15:0] data_c; 
logic [15:0] data_d;
logic [15:0] result; 

logic [17:0] sum;
logic [2:0] counter; 


localparam IDLE = 0;
localparam BUSY = 1;
localparam DONE = 2;

logic [1:0] state;
logic [1:0] state_next;

always_comb begin
    state_next = state;
    case(state)
        IDLE: begin
            if(configure[0] == 1)
                state_next = BUSY;
            end
        
        BUSY: begin
                if(counter == 3'd4)
                     state_next = DONE;       
            end
        
        DONE: begin
                state_next = IDLE;
            end
            
         default: state_next = IDLE;  
    endcase    
end

assign pready = (state != BUSY);    

always_ff@(posedge pclk) begin
    if(preset) begin
            state         <= IDLE;
            counter     <= 0;
            sum          <= 0;
            configure   <= 0;
            result        <= 0;
        end
   
    else begin
        state <= state_next;
        
        if(state == IDLE) begin
            counter <= 0;
            sum <= 0;
        end
        
        else if(state == BUSY) begin
            case(counter)
                0: sum <= sum + data_a;
                1: sum <= sum + data_b;
                2: sum <= sum + data_c;
                3: sum <= sum + data_d;
                default: sum <= sum;
            endcase
            counter <= counter + 1;
        end
        
        else if(state == DONE) begin
            result          <= sum >> 2;    //impartirea la 4
            configure[1] <= 1;
            configure[0] <= 0;    
        end
    
    end    
end   

always_ff@(posedge pclk) begin 
    if (psel & penable & pwrite & pready & state == IDLE & !preset) begin
        case(paddr)
            10'd0:  begin
                            configure[0] <= pwdata[0];
                            configure[1] <= 1'b0;
                       end
            10'd1:  data_a         <= pwdata;
            10'd2:  data_b         <= pwdata;
            10'd3:  data_c         <= pwdata;
            10'd4:  data_d         <= pwdata;
        endcase
    end  
end

always_comb begin
    prdata = 16'd0;
    
    if(psel & penable & pready & !pwrite) begin
        prdata = 16'd0;
        case(paddr)
            10'd0: prdata = {14'd0, configure};
            10'd1: prdata = data_a;
            10'd2: prdata = data_b;
            10'd3: prdata = data_c;
            10'd4: prdata = data_d;
            10'd5: prdata = result;
        endcase
    end
end  
endmodule
