module register8bit (SW,LEDR,KEY);
                input [9:0] SW;
                input [3:0] KEY;
                output [7:0] LEDR;
               reg [7:0] Out_Q;

               wire [7:0]rotatedata;
               wire [7:0]datatodff;
               wire [7:0]Q;
               wire endoneoutput;
               muxto1 endone(.x(Q[0]),.y(Q[7]),.s(KEY[3]),.m(endoneoutput));//select the most significant bit for repeat and  wrap around

muxto1 a1(.x(Q[6]),.y(endoneoutput),.s(KEY[2]),.m(rotatedata[7]));
muxto1 m1(.x(SW[7]),.y(rotatedata[7]),.s(KEY[1]),.m(datatodff[7]));
flipflop f1(datatodff[7],KEY[0],SW[9],Q[7]);

muxto1 a2(.x(Q[5]),.y(Q[7]),.s(KEY[2]),.m(rotatedata[6]));
 muxto1 m2(.x(SW[6]),.y(rotatedata[6]),.s(KEY[1]),.m(datatodff[6]));
flipflop f2(datatodff[6],KEY[0],SW[9],Q[6]);

muxto1 a3(.x(Q[4]),.y(Q[6]),.s(KEY[2]),.m(rotatedata[5]));
muxto1 m3(.x(SW[5]),.y(rotatedata[5]),.s(KEY[1]),.m(datatodff[5]));
flipflop f3(datatodff[5],KEY[0],SW[9],Q[5]);

muxto1 a4(.x(Q[3]),.y(Q[5]),.s(KEY[2]),.m(rotatedata[4]));
muxto1 m4(.x(SW[4]),.y(rotatedata[4]),.s(KEY[1]),.m(datatodff[4]));
flipflop f4(datatodff[4],KEY[0],SW[9],Q[4]);

muxto1 a5(.x(Q[2]),.y(Q[4]),.s(KEY[2]),.m(rotatedata[3]));
muxto1 m5(.x(SW[3]),.y(rotatedata[3]),.s(KEY[1]),.m(datatodff[3]));
flipflop f5(datatodff[3],KEY[0],SW[9],Q[3]);

 muxto1 a6(.x(Q[1]),.y(Q[3]),.s(KEY[2]),.m(rotatedata[2]));
 muxto1 m6(.x(SW[2]),.y(rotatedata[2]),.s(KEY[1]),.m(datatodff[2]));
flipflop f6(datatodff[2],KEY[0],SW[9],Q[2]);


muxto1 a7(.x(Q[0]),.y(Q[2]),.s(KEY[2]),.m(rotatedata[1]));
muxto1 m7(.x(SW[1]),.y(rotatedata[1]),.s(KEY[1]),.m(datatodff[1]));
flipflop f7(datatodff[1],KEY[0],SW[9],Q[1]);

muxto1 a8(.x(Q[7]),.y(Q[1]),.s(KEY[2]),.m(rotatedata[0]));
muxto1 m8(.x(SW[0]),.y(rotatedata[0]),.s(KEY[1]),.m(datatodff[0]));
flipflop f8(datatodff[0],KEY[0],SW[9],Q[0]);
assign LEDR[0]=Q[0];

	assign LEDR[1]=Q[1];

	assign LEDR[2]=Q[2];

	assign LEDR[3]=Q[3];

	assign LEDR[4]=Q[4];

	assign LEDR[5]=Q[5];

	assign LEDR[6]=Q[6];

	assign LEDR[7]=Q[7];

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
module flipflop(D,Clk,Reset,Q);
input D,Clk,Reset;
output reg Q;
always@(posedge Clk)

if (Reset==1'b1)
begin
Q<=0;
end

else
begin
Q<=D;
end
endmodule

