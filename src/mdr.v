module mdr #(parameter WORD_WIDTH = 8) (clk,c_bus,c_write_enable,b_bus,b_read_enable,mem,mem_read,mem_write);
  input clk;
  input [WORD_WIDTH-1 : 0] c_bus;
  input b_read_enable,c_write_enable,mem_read,mem_write;
  output reg [WORD_WIDTH-1 : 0] b_bus;
  inout [WORD_WIDTH-1 : 0] mem;
  
  reg [WORD_WIDTH-1 : 0] data;
  
  assign mem = mem_write ? data : 'bZ ;
  
  initial 
  begin
    b_bus = 'bZ;
    data = 0;
  end
  
  always @ (posedge clk)
  begin
    if (c_write_enable)
      data <= c_bus;
    else if (mem_read)
      data <= mem;
  end

  always @ (negedge clk)
  begin
    if (b_read_enable)
      b_bus <= data;
    else b_bus <= 'bZ;      
  end  
  
endmodule