module ALU (SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
            input [7:0]SW;
            input [2:0]KEY;
            output [6:0]HEX0;
            output [6:0]HEX1;
            output [6:0]HEX2;
            output [6:0]HEX3;
            output [6:0]HEX4;
            output [6:0]HEX5;
            output [7:0]LEDR;

            wire [3:0]A;
            wire [3:0]B;
           wire [2:0]Select;
           wire [7:0]ALUout;
          
           assign A=SW[7:4];
          assign B=SW[3:0];
          assign Select =KEY [2:0];
          assign LEDR=ALUout[7:0];
          

 //coding for the adder 
//instantiating modules
wire [ 7:0]Outputs;//temporary outputs of functions 
wire C[2:0];//carry
fulladder u1(A[0],B[0],0,Outputs[0],C[0]);
fulladder u2(A[1],B[1],C[0],Outputs[1],C[1]);
fulladder u3(A[2],B[2],C[1],Outputs[2],C[2]);
fulladder u4(A[3],B[3],C[2],Outputs[3],Outputs[4]);  
 assign Outputs[5]=0;
assign Outputs[6]=0;
assign Outputs[7]=0;



//coding for the A+B.
wire [7:0]plus;
wire [3:0] temp;
assign temp=plus[3:0];
adderoperator u5(A,B,0,temp,plus[4]);
assign plus[5]=0;
assign plus[6]=0;
assign plus[7]=0;


//coding for case 2
wire [7:0]case2;
assign case2[3:0]=A~^B;
assign case2[7:4]=~(A&B);
//all 8 outputs used so no need to assign any bits to 0.

//coding for case3
wire [7:0] case3;
wire [7:0]D;
assign D={A,B};//concatenation operator in verilog 
assign case3=(|D)?( 8'b0001111 ):(8'b0000000 );


//coding for case 4 
wire [7:0]case4;
//final output of the ALU
wire [1:0]halfA1;
wire [1:0] halfA2;
//final output of the ALU
assign halfA1=A[1:0];//halA1 represents  a vector consisting left most 2 bits of vector A
assign halfA2=A[3:2];//hal21 represents  a vector consisting right  most 2 bits of vector A

wire firstoutput;
assign firstoutput=((^halfA1)^(^halfA2));//reduction of thr vector halfA1 and halfA2 to produce single bit result called firstOutput
wire secondoutput;
assign secondoutput=((~&halfA1)&(~&halfA2));//NAND reduction of the vectors halfA1 and halfA2
wire thirdoutput;
assign thirdoutput=(~(^B)& ((|B)^(&B)));
assign case4=(firstoutput & secondoutput & thirdoutput)?(8'b1110000):(8'b0000000);

  

//case 5
wire [7:0]case5;
assign case5[3:0]=~B;
assign case5[7:4]=A;


//display zero on hex1 and hex3
decoder hex1 (.c0(0),.c1(0),.c2(0),.c3(0),.LED0(HEX1[0]),.LED1(HEX1[1]),.LED2(HEX1[2]),.LED3(HEX1[3]),.LED4(HEX1[4]),.LED5(HEX1[5]),.LED6(HEX1[6]));
decoder hex3 (.c0(0),.c1(0),.c2(0),.c3(0),.LED0(HEX3[0]),.LED1(HEX3[1]),.LED2(HEX3[2]),.LED3(HEX3[3]),.LED4(HEX3[4]),.LED5(HEX3[5]),.LED6(HEX3[6]));
//display on hex2 and hex0
//display B on hex0 and A on hex2
decoder hex0 (.c0(SW[0]),.c1(SW[1]),.c2(SW[2]),.c3(SW[3]),.LED0(HEX0[0]),.LED1(HEX0[1]),.LED2(HEX0[2]),.LED3(HEX0[3]),.LED4(HEX0[4]),.LED5(HEX0[5]),.LED6(HEX0[6]));
decoder hex2 (.c0(SW[4]),.c1(SW[5]),.c2(SW[6]),.c3(SW[7]),.LED0(HEX2[0]),.LED1(HEX2[1]),.LED2(HEX2[2]),.LED3(HEX2[3]),.LED4(HEX2[4]),.LED5(HEX2[5]),.LED6(HEX2[6]));
 

muxSelect final (Outputs,plus,case2,case3,case4,case5,Select,ALUout);//selection of function outputs using select

//displaying the output 
decoder hex4(.c0(ALUout[0]),.c1(ALUout[1]),.c2(ALUout[2]),.c3(ALUout[3]),.LED0(HEX4[0]),.LED1(HEX4[1]),.LED2(HEX4[2]),.LED3(HEX4[3]),.LED4(HEX4[4]),.LED5(HEX4[5]),.LED6(HEX4[6])); 
decoder hex5(.c0(ALUout[4]),.c1(ALUout[5]),.c2(ALUout[6]),.c3(ALUout[7]),.LED0(HEX5[0]),.LED1(HEX5[1]),.LED2(HEX5[2]),.LED3(HEX5[3]),.LED4(HEX5[4]),.LED5(HEX5[5]),.LED6(HEX5[6])); 

endmodule

module adderoperator(a,b,cIn,sum,Cout);
input [3:0]a;
input [3:0]b;
input cIn;

output[3:0]sum;

output Cout;

assign {cOut,sum}=a+b+cIn;

endmodule



module fulladder(a,b,cIn,s,cOut);
input a,b,cIn;
output s,cOut;
wire In;
assign In=a^b;
mux2to1 myMux(b,cIn,In,cOut);
assign s=cIn^In;
endmodule

module mux2to1(x1,x2,s,f);
input x1,x2,s;
output f;
assign f=(~s &x1)|(s&x2);
endmodule




module muxSelect(I0,I1,I2,I3,I4,I5,s,y);
input [7:0] I0,I1,I2,I3,I4,I5;
input [2:0] s;
output reg [7:0] y;
always@(*)
begin
case(s)
3'b000: y<=I0;
3'b001: y<=I1;
3'b010: y<=I2;
3'b011: y<=I3;
3'b100: y<=I4;
3'b101: y<=I5;
default:y<=8'b00000000;
endcase
end
endmodule

module decoder(input c0,c1,c2,c3,output LED0,LED1,LED2,LED3,LED4,LED5,LED6);
assign LED0=(~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&c0);
assign LED1=(~c3&c2&~c1&c0)|(~c3&c2&c1&~c0)|(c3&~c2&c1&c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0);
assign LED2=(~c3&~c2&c1&~c0)|(c3&c2&~c1&~c0)|(c3&c2&c1&~c0)|(c3&c2&c1&c0);
assign LED3=(~c3&~c2&~c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&c1&c0)|(c3&~c2&c1&~c0)|(c3&c2&c1&c0);
assign LED4=(~c3&~c2&~c1&c0)|(~c3&~c2&c1&c0)|(~c3&c2&~c1&~c0)|(~c3&c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&~c2&~c1&c0);
assign LED5=(~c3&~c2&~c1&c0)|(~c3&~c2&c1&~c0)|(~c3&~c2&c1&c0)|(~c3&c2&c1&c0)|(c3&c2&~c1&c0);
assign LED6=(~c3&~c2&~c1&c0)|(~c3&c2&c1&c0)|(c3&c2&~c1&~c0)|(~c3&~c2&~c1&~c0);
endmodule


