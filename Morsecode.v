
module Morsecode(SW,KEY,LEDR,CLOCK_50);
               input [9:0] SW;
               input [1:0] KEY;
               input CLOCK_50;
               output [9:0]LEDR;

              reg [15:0]muxoutput;
             wire enable;
             wire [15:0]Q;
             wire [15:0]datatodff;
             wire [2:0]select;
             wire reset;
            wire userkey;
            wire Reset;
           
assign select=SW[2:0];
assign reset=KEY[0];
assign userkey=KEY[1];


always@(*)
         begin
          case(select[2:0])
                3'b000: muxoutput= 16'b1010;
                3'b001: muxoutput=16'b01011101110111000;
                3'b010: muxoutput=16'b01110101110;
                3'b011: muxoutput= 16'b01011101010;
                3'b100: muxoutput=16'b0111011100;
                3'b101: muxoutput=16'b01110100;
                3'b110: muxoutput=16'b01110111011100;
               3'b111: muxoutput=16'b0101110111010;
          default:muxoutput=16'b0;
		
endcase
end 
Ratedivider mydivider(CLOCK_50,reset,enable);//calling the frequency divider


//the register calling 
muxto1 a1(.x(muxoutput[15]),.y(0),.s(userkey),.m(datatodff[15]));
flipflop f1(datatodff[15],CLOCK_50,reset,enable,Q[15]);

muxto1 a2(.x(muxoutput[14]),.y(Q[15]),.s(userkey),.m(datatodff[14]));
flipflop f2(datatodff[14],CLOCK_50,reset,enable,Q[14]);

muxto1 a3(.x(muxoutput[13]),.y(Q[14]),.s(userkey),.m(datatodff[13]));
flipflop f3(datatodff[13],CLOCK_50,reset,enable,Q[13]);

muxto1 a4(.x(muxoutput[12]),.y(Q[13]),.s(userkey),.m(datatodff[12]));
flipflop f4(datatodff[12],CLOCK_50,reset,enable,Q[12]);

muxto1 a5(.x(muxoutput[11]),.y(Q[12]),.s(userkey),.m(datatodff[11]));
flipflop f5(datatodff[11],CLOCK_50,reset,enable,Q[11]);

 muxto1 a6(.x(muxoutput[10]),.y(Q[11]),.s(userkey),.m(datatodff[10]));
 flipflop f6(datatodff[10],CLOCK_50,reset,enable,Q[10]);


muxto1 a7(.x(muxoutput[9]),.y(Q[10]),.s(userkey),.m(datatodff[9]));
flipflop f7(datatodff[9],CLOCK_50,reset,enable,Q[9]);

muxto1 a8(.x(muxoutput[8]),.y(Q[9]),.s(userkey),.m(datatodff[8]));
flipflop f8(datatodff[8],CLOCK_50,reset,enable,Q[8]);





muxto1 a9(.x(muxoutput[7]),.y(Q[8]),.s(userkey),.m(datatodff[7]));
flipflop f9(datatodff[7],CLOCK_50,reset,enable,Q[7]);

muxto1 a10(.x(muxoutput[6]),.y(Q[7]),.s(userkey),.m(datatodff[6]));
flipflop f10(datatodff[6],CLOCK_50,reset,enable,Q[6]);

muxto1 a11(.x(muxoutput[5]),.y(Q[6]),.s(userkey),.m(datatodff[5]));
flipflop f11(datatodff[5],CLOCK_50,reset,enable,Q[5]);

muxto1 a12(.x(muxoutput[4]),.y(Q[5]),.s(userkey),.m(datatodff[4]));
flipflop f12(datatodff[4],CLOCK_50,reset,enable,Q[4]);

muxto1 a13(.x(muxoutput[3]),.y(Q[4]),.s(userkey),.m(datatodff[3]));
flipflop f13(datatodff[3],CLOCK_50,reset,enable,Q[3]);

 muxto1 a14(.x(muxoutput[2]),.y(Q[3]),.s(userkey),.m(datatodff[2]));
 flipflop f14(datatodff[2],CLOCK_50,reset,enable,Q[2]);


muxto1 a15(.x(muxoutput[1]),.y(Q[2]),.s(userkey),.m(datatodff[1]));
flipflop f15(datatodff[1],CLOCK_50,reset,enable,Q[1]);

muxto1 a16(.x(muxoutput[0]),.y(Q[1]),.s(userkey),.m(datatodff[0]));
flipflop f16(datatodff[0],CLOCK_50,reset,enable,Q[0]);


assign LEDR[0]=Q[0];//assigning the final ouput -displaying the blinking of LEDS.

endmodule


module Ratedivider(input Clock,reset,output reg theenablesignal);

reg [25:0] q; // declare q
wire[25:0]d;


assign d=26'b001011111010111100000111111;//for 2 hz clock start counting from 12499999

			
always@(posedge Clock)

	

		if (reset==1'b1)

		begin

		   q<=d;
			theenablesignal=1'b0;

		end

		else if (q==0)

		begin
		
		theenablesignal=1;//toggle the enable signal once one decrementation cycle is over

			q<=d;

		end

		else

		begin

			theenablesignal = 1'b0;

			q<=q-1;

		end

	

		


endmodule






//the mux module 
module muxto1(
    input x, //select 0
    input y, //select 1
    input s, //select signal 
    output m //output
  );
    assign m = s & y | ~s & x;
    

endmodule



//module flip flop 
module flipflop(D,Clk,Reset,Enable,Q);
input D,Clk,Reset,Enable;
output reg Q;
always@(posedge Clk)

if (Reset)
begin
Q<=0;
end

else if( Enable)
begin
Q<=D;
end
endmodule

