module tflipflop(T,clear_b,Clock,Q);
input T,clear_b,Clock;
output reg Q;


always@(posedge Clock,negedge clear_b)//active low asynchronous clear 
 
if (!clear_b)
begin
  Q<=0;
  end
else  
  begin
  Q<=Q^T;
  end
 
endmodule


module counter8bit(SW,KEY,HEX0,HEX1);
input [1:0]SW;
input [1:0]KEY;
output [7:0]HEX0;
output [7:0]HEX1;
wire enable,Clear_b,clock;
assign Clear_b=SW[0];
assign enable=SW[1];
assign clock=KEY[0];



wire [7:0]temp;
wire [7:0]count;

tflipflop myff1(.T(enable),.clear_b(Clear_b),.Clock(clock),.Q(count[0]));
assign temp[0]=enable&count[0];

tflipflop myff2(.T(temp[0]),.clear_b(Clear_b),.Clock(clock),.Q(count[1]));
assign temp[1]=temp[0]&count[1];

tflipflop myff3(.T(temp[1]),.clear_b(Clear_b),.Clock(clock),.Q(count[2]));
assign temp[2]=temp[1]&count[2];

tflipflop myff4(.T(temp[2]),.clear_b(Clear_b),.Clock(clock),.Q(count[3]));
assign temp[3]=temp[2]&count[3];

tflipflop myff5(.T(temp[3]),.clear_b(Clear_b),.Clock(clock),.Q(count[4]));
assign temp[4]=temp[3]&count[4];

tflipflop myff6(.T(temp[4]),.clear_b(Clear_b),.Clock(clock),.Q(count[5]));
assign temp[5]=temp[4]&count[5];

tflipflop myff7(.T(temp[5]),.clear_b(Clear_b),.Clock(clock),.Q(count[6]));
assign temp[6]=temp[5]&count[6];

tflipflop myff8(.T(temp[6]),.clear_b(Clear_b),.Clock(clock),.Q(count[7]));
decoder my (.c0(count[0]),.c1(count[1]),.c2(count[2]),.c3(count[3]),.LED0(HEX0[0]),.LED1(HEX0[1]),.LED2(HEX0[2]),.LED3(HEX0[3]),.LED4(HEX0[4]),.LED5(HEX0[5]),.LED6(HEX0[6]));
decoder my2 (.c0(count[4]),.c1(count[5]),.c2(count[6]),.c3(count[7]),.LED0(HEX1[0]),.LED1(HEX1[1]),.LED2(HEX1[2]),.LED3(HEX1[3]),.LED4(HEX1[4]),.LED5(HEX1[5]),.LED6(HEX1[6]));

endmodule

module decoder(input c0,c1,c2,c3,output LED0,LED1,LED2,LED3,LED4,LED5,LED6);
assign LED0=(~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&c0);
assign LED1=(~c3&c2&~c1&c0)|(~c3&c2&c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0);
assign LED2=(~c3&~c2&c1&~c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0);
assign LED3=(~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&c1&c0)|(c3&~c2&c1&~c0)|(c3&c2&c1&c0);
assign LED4=(~c3&~c2&~c1&c0)|(~c3&~c2&c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&~c2&~c1&c0);
assign LED5=(~c3&~c2&~c1&c0)|(~c3&~c2&c1&~c0)|(~c3&~c2&c1&c0)|(~c3&c2&c1&c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&c0);
assign LED6=(~c3&~c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&~c0)|(~c3&~c2&~c1&~c0);
endmodule





 
  
  
  

  


  
  
  
  