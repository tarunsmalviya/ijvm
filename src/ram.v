module ram #(parameter WORD_WIDTH = 8, ADDRESS_WIDTH = 32) (clk,word_address,word_data,byte_address,byte_data,read,write,fetch);
  input clk,read,write,fetch;
  input [ADDRESS_WIDTH-1 : 0] word_address;
  input [ADDRESS_WIDTH-1 : 0] byte_address;
  output reg [WORD_WIDTH -1 : 0] byte_data;
  inout [(WORD_WIDTH*4)-1 : 0] word_data;
  
  parameter RAM_DEPTH = 128;
  
  reg [WORD_WIDTH-1:0] mem [0:RAM_DEPTH-1];
  reg [(WORD_WIDTH*4)-1 : 0] word_data_out;
  
  assign word_data = (read && !write) ? word_data_out : 32'bz; 

  initial 
  begin
    word_data_out <= 32'bZ;
    $readmemb("main_memory.list", mem); // memory_list is memory file
  end

  always @ (posedge clk)
  begin
    if (write && !read) 
    begin
       mem[word_address] <= word_data[(WORD_WIDTH*1)-1 : (WORD_WIDTH*0)];
       mem[word_address+1] <= word_data[(WORD_WIDTH*2)-1 : (WORD_WIDTH*1)];
       mem[word_address+2] <= word_data[(WORD_WIDTH*3)-1 : (WORD_WIDTH*2)];
       mem[word_address+3] <= word_data[(WORD_WIDTH*4)-1 : (WORD_WIDTH*3)];
    end
  end

  always @ (posedge clk)
  begin
    if (!write && read)  
    begin
      word_data_out[(WORD_WIDTH*1)-1 : (WORD_WIDTH*0)] <= mem[word_address];
      word_data_out[(WORD_WIDTH*2)-1 : (WORD_WIDTH*1)] <= mem[word_address+1];
      word_data_out[(WORD_WIDTH*3)-1 : (WORD_WIDTH*2)] <= mem[word_address+2];
      word_data_out[(WORD_WIDTH*4)-1 : (WORD_WIDTH*3)] <= mem[word_address+3];
    end 
  end

  always @ (posedge clk)
  begin
    byte_data <= (fetch == 1) ? mem[byte_address] : 8'bz;  
  end
endmodule