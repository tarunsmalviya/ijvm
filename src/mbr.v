module mbr (clk,mem,mem_read_enable,b_bus,b_write_enable,data);
  input clk;
  input [7 : 0] mem;
  input [1 : 0] b_write_enable; 
  input mem_read_enable;
  output reg [31 : 0] b_bus;
  output reg [7 : 0] data;
  
  initial 
  begin
    b_bus = 'bZ;
    data = 8'b01100000;
  end
  
  always @ (posedge clk)
  begin
    if (mem_read_enable)
      data <= mem;
  end

  always @ (negedge clk)
  begin
    if (b_write_enable == 2'b01)
      b_bus <= {24'b0,data};
    else if (b_write_enable == 2'b10)
      b_bus <= {{24{data[7]}},{data[7:0]}};
    else b_bus <= 'bZ;      
  end  
  
endmodule