module shifter #(parameter WORD_WIDTH = 8) (in,control,out);
  input [WORD_WIDTH-1 : 0] in;
  input [1:0] control;
  output reg [WORD_WIDTH-1:0] out; 
  
  always @ (*)
  begin
    /*(*full_case,parallel_case*)
    case(control)
      2'b10 : out <= in<<1;
      2'b01 : out <= in>>1;
      default   :  out <= in;
    endcase
    */ 
    if(control==2'b01)
      out <= in>>>1;    //right_shift
    else if(control==2'b10)
      out <= in<<8;   //left_shift
    else
      out <= in;
  end
endmodule