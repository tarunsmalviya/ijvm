module processor(clk,reset,word_address,word_data,byte_address,byte_data,read,write,fetch);
  input clk,reset;
  inout [31:0] word_data;
  input [7:0] byte_data;
  output [31:0] word_address;
  output [31:0] byte_address;
  output read,write,fetch;
  
  wire [31:0] a_bus,b_bus,c_bus,alu_output;
  wire [35:0] control_signal;
  wire [15:0] decoder_output;
  wire [8:0] control_store_address_bus;
  wire [7:0] mbr_data;
  wire N,Z,high_bit;
  
  assign high_bit = (control_signal[24] & Z) | (control_signal[25] & N);
  
  assign control_store_address_bus[8] = high_bit | control_signal[35];
 
  assign control_store_address_bus[7:0] = (control_signal[26] == 1)? mbr_data : control_signal[34:27]; 
  
  mar #(32) MAR(clk,c_bus,control_signal[7],word_address);
  mdr #(32) MDR(clk,c_bus,control_signal[8],b_bus,decoder_output[0],word_data,control_signal[5],control_signal[6]);
  pc #(32) PC(clk,c_bus,control_signal[9],b_bus,decoder_output[1],byte_address,control_signal[5]); 
  mbr MBR(clk,byte_data,control_signal[4],b_bus,decoder_output[3:2],mbr_data);
  sp #(32) SP(clk,c_bus,control_signal[10],b_bus,decoder_output[4]);
  lv #(32) LV(clk,c_bus,control_signal[11],b_bus,decoder_output[5]);
  cpp #(32) CPP(clk,c_bus,control_signal[12],b_bus,decoder_output[6]);
  tos #(32) TOS(clk,c_bus,control_signal[13],b_bus,decoder_output[7]);
  opc #(32) OPC(clk,c_bus,control_signal[14],b_bus,decoder_output[8]);
  h #(32) H(clk,c_bus,control_signal[15],a_bus);
  alu #(32) ALU(clk,a_bus,b_bus,control_signal[21:16],N,Z,alu_output);
  shifter #(32) SHIFTER(alu_output,control_signal[23:22],c_bus);
  
  control_store CONTROL_STORE(clk,control_store_address_bus,control_signal);
  
  decoder DECODER(control_signal[3:0],decoder_output[15:0]);
  
endmodule