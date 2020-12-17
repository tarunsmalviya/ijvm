module alu #(parameter WORD_WIDTH = 32) (clk,a,b,control,n,z,out);
  input clk;
  input [WORD_WIDTH-1 : 0] a, b;      //inputs
  input [5:0] control;                //control lines
  output reg n, z;                    //flags n=sign z=zero
  output reg [WORD_WIDTH-1 : 0] out;  //output
  
  initial //initializing flags ant output to zero
  begin
    n = 0;
    z = 0;
    out = 0;
  end 
  
  always @(posedge clk)
  begin
    if (out == 0)
      z <= 1;
    else z <= 0;
    
    n <= out[WORD_WIDTH-1];
  end
  
  always @(*)
  begin
    (*full_case,parallel_case*)
    case(control)
      6'b011000 :  out <= a;
      6'b010100 :  out <= b;
      6'b011010 :  out <= ~a;
      6'b101100 :  out <= ~b;
      6'b111100 :  out <= a+b;
      6'b111101 :  out <= a+b+1;
      6'b111001 :  out <= a+1;
      6'b110101 :  out <= b+1;
      6'b111111 :  out <= b-a;
      6'b110110 :  out <= b-1;
      6'b111011 :  out <= -a;
      6'b001100 :  out <= a&b;
      6'b011100 :  out <= a|b;
      6'b010000 :  out <= 0;
      6'b010001 :  out <= 1;
      6'b010010 :  out <= -1;
      default   :  out <= 0;
    endcase
  end
endmodule