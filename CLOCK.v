
module CLOCK(CLOCK_50,SW,HEX0);
            input [9:0]SW;
            input CLOCK_50;
            output [6:0]HEX0;
            wire speed;
           wire [3:0]display;
           wire[1:0]select;
           wire reset;

         assign select=SW[1:0];
         assign reset=SW[9];


Ratedivider myfrequency(CLOCK_50,reset,select,speed);
displayCounter mydisplay(CLOCK_50,reset,speed,display[3:0]);
decoder my (.c0(display[0]),.c1(display[1]),.c2(display[2]),.c3(display[3]),.LED0(HEX0[0]),.LED1(HEX0[1]),.LED2(HEX0[2]),.LED3(HEX0[3]),.LED4(HEX0[4]),.LED5(HEX0[5]),.LED6(HEX0[6]));

endmodule

module Ratedivider(input Clock,reset,input[1:0]Select,output reg theenablesignal);

reg [25:0] q; // declare q
reg[25:0]d;

always@(*)
	case(Select[1:0])

			2'b00: d= 26'b0;//to generate 50Mhz clock start counting from 0 itself so never decrement

			2'b01: d=26'b001011111010111100000111111;
			//for 2 hz clock start counting from 12499999//correct//124999

			2'b10: d =26'b000101111101011110000011111;//24//for 1hz clock signal start counting from 2499999

			2'b11: d= 26'b11101110011010110010011111;//for 0.5hz clock cycle start counting from 62499999
         
			endcase
		
	
		
		
always@(posedge Clock)

	begin
       if(reset==1'b1)
		

		begin       //need to reset initially to load the d value only first time

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

	end

		


endmodule






module displayCounter(input Clock,Clear_b,Enable,output reg [3:0]q);//successively flashes digits from 0 to F at the desired speed


always@(posedge Clock) // triggered every time clock rises
begin
if(Clear_b==1'b1) // when Clear b is 0
q<=0;

else if(Enable==1'b1)// increment q only when Enable is 1
q<=q+1; // increment q
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








