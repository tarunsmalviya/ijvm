module testbench(clk, reset);
  input clk,reset;
  
  wire [31:0] word_data;
  wire [7:0] byte_data;
  wire [31:0] word_address;
  wire [31:0] byte_address;
  wire read,write,fetch;
  
  processor p(clk,reset,word_address,word_data,byte_address,byte_data,read,write,fetch);
  ram r(clk,word_address,word_data,byte_address,byte_data,read,write,fetch);
endmodule