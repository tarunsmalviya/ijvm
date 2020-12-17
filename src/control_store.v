module control_store(clk,address,out);
  input clk;
  input [8:0] address;
  output reg [35:0] out;
  
  reg [35:0] mem [0:511] ;  
      
  initial 
  begin
    out <= 36'bZ;
    $readmemb("control_memory.list", mem); // memory_list is memory file
  end
  
  always @(negedge clk)
  begin
    out <= mem[address];    
  end
endmodule