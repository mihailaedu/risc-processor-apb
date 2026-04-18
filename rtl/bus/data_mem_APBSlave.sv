module data_mem_APBSlave(
    
    //conexiuni APB
    input logic        pclk,
    input logic [9:0]  paddr,
    input logic        psel,
    input logic        penable,
    input logic        pwrite,
    input logic [15:0] pwdata,
    output logic[15:0] prdata,
    output logic       pready
    );

logic [15:0] mem [0:2**10-1];
    
//scrierea din memorie - mereu sincrona
always_ff@(posedge pclk) begin
    if(pwrite & psel & penable & pready) //semnalele sa fie 1
        mem[paddr] <= pwdata;    
end

assign pready = 1;    


//citirea din memorie - asincrona
assign prdata = (~pwrite & psel & penable & pready) ? mem[paddr] : 0;
    
endmodule
