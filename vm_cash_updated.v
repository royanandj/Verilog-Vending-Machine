`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Create Date:    18:40:30 09/10/20
// Design Name:    
// Module Name:    vending_machine_cash
// Project Name:   Vending Machine
// Target Device:  FPGA
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module vending_machine_cash(m, p, can, reset, clk, del, change, halt, return5, return10, return20, return50, out_of_order);
	
	input can, clk, reset;
	input [3:0]m, p;	// money ip, product select
	
	reg [3:0] next_state,current_state; 
	output reg [3:0]del, out_of_order;
	output reg [7:0]change;
	output reg halt, return5, return10, return20, return50;
	
	reg [3:0]di5,di10,di20,di50;	// count of denominations inserted 
	reg [7:0]amt;

	parameter rs0 = 0, rs5 = 1, rs10 = 2, rs15 = 3, rs20 = 4, rs25 = 5, rs30 = 6, rs35 = 7, rs40 = 8, rs45 = 9, rs50 = 10, rs55 = 11, rs60 = 12, rs65 = 13, rs70 = 14, rs75 = 15, rs80 = 16, rs85 = 17, rs90 = 18, rs95 = 19, rs100 = 20, rs105 = 21, rs110 = 22, rs115 = 23, rs120 = 24, rs125 = 25, rs130 = 26, rs135 = 27, rs140 = 28, rs145 = 29, rs150 = 30;
	parameter pc0 = 8'b00001111, pc1 = 8'b00100011, pc2 = 8'b00110010, pc3 = 8'b01000110;
 	
	reg [3:0]count5,count10,count20,count50,prod0,prod1,prod2,prod3; //total machine count

	initial
		begin
			count5 = 4'b0011;
			count10 = 4'b0011;
			count20 = 4'b0011;
			count50 = 4'b0011;
			prod0 = 4'b1010;
			prod1 = 4'b1010;
			prod2 = 4'b1010;
			prod3 = 4'b1010;
			out_of_order  = 4'b0000;

		end

	always @(posedge clk or posedge reset)
		begin
			if(reset)
				begin
					amt = 8'b00000000;
					change = 8'b00000000;

					del = 4'b0000;
					halt = 1'b0;

					di5 = 4'b0000;
					di10 = 4'b0000;
					di20 = 4'b0000;
					di50 = 4'b0000;

					return5 = 1'b0;
					return10 = 1'b0;
					return20 = 1'b0;
					return50 = 1'b0;

					current_state = rs0;
				end
			else
				current_state = next_state;
		end

	always @(m)
		begin
			case(current_state)
				rs0:begin
						if(m == 4'b0001)
							begin
								next_state = rs5;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs10;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs20;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs50;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
					end
					
				rs5:begin
						if(m == 4'b0001)
							begin
								next_state = rs10;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs15;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs25;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs55;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
					end
				
				rs10:begin
						if(m == 4'b0001)
							begin
								next_state = rs15;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs20;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs30;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs60;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
					end
					
				rs15:begin
						if(m == 4'b0001)
							begin
								next_state = rs20;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs25;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs35;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs65;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
					end
					
				rs20:begin
						if(m == 4'b0001)
							begin
								next_state = rs25;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs30;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs40;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs70;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end
				
				rs25:begin
						if(m == 4'b0001)
							begin
								next_state = rs30;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs35;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs45;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs75;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs30:begin
							if(m == 4'b0001)
								begin
									next_state = rs35;
									amt = amt + 8'b00000101;
									di5 = di5 + 1'b1;
								end
							else if(m == 4'b0010)
								begin
									next_state = rs40;
									amt = amt + 8'b00001010;
									di10 = di10 + 1'b1;
								end	
							else if(m == 4'b0100)
								begin	
									next_state = rs50;
									amt = amt + 8'b00010100;
									di20 = di20 + 1'b1;
								end
							else if(m == 4'b1000)
								begin
									next_state = rs80;
									amt = amt + 8'b00110010;
									di50 = di50 + 1'b1;
								end
							end

					rs35:begin
						if(m == 4'b0001)
							begin
								next_state = rs40;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs45;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs55;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs85;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs40:begin
						if(m == 4'b0001)
							begin
								next_state = rs45;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs50;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs60;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs90;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs45:begin
						if(m == 4'b0001)
							begin
								next_state = rs50;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs55;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs65;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs95;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs50:begin
						if(m == 4'b0001)
							begin
								next_state = rs55;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs60;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs70;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs100;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs55:begin
						if(m == 4'b0001)
							begin
								next_state = rs60;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs65;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs75;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs105;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end
					
					rs60:begin
						if(m == 4'b0001)
							begin
								next_state = rs65;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs70;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs80;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs110;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs65:begin
						if(m == 4'b0001)
							begin
								next_state = rs70;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs75;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs85;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs115;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs70:begin
						if(m == 4'b0001)
							begin
								next_state = rs75;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs80;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs90;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs120;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs75:begin
						if(m == 4'b0001)
							begin
								next_state = rs80;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs85;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs95;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs125;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs80:begin
						if(m == 4'b0001)
							begin
								next_state = rs85;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs90;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs100;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs130;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs85:begin
						if(m == 4'b0001)
							begin
								next_state = rs90;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs95;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs105;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs135;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs90:begin
						if(m == 4'b0001)
							begin
								next_state = rs95;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs100;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs110;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs140;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs95:begin
						if(m == 4'b0001)
							begin
								next_state = rs100;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs105;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs115;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs145;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

					rs100:begin
						if(m == 4'b0001)
							begin
								next_state = rs105;
								amt = amt + 8'b00000101;
								di5 = di5 + 1'b1;
							end
						else if(m == 4'b0010)
							begin
								next_state = rs110;
								amt = amt + 8'b00001010;
								di10 = di10 + 1'b1;
							end	
						else if(m == 4'b0100)
							begin	
								next_state = rs120;
								amt = amt + 8'b00010100;
								di20 = di20 + 1'b1;
							end
						else if(m == 4'b1000)
							begin
								next_state = rs150;
								amt = amt + 8'b00110010;
								di50 = di50 + 1'b1;
							end
						end

		endcase
	end
		
	always @(p)
		begin
			case(p)
				4'b0001://15
				if(prod0 > 4'b0000)
					begin
						if(amt >= pc0)
							begin
								change = amt - pc0;
								prod0 = prod0 - 4'b0001;
								del[0] = 1'b1;
								#0.2;
								del[0] = 1'b0;
							end
						else
							begin
								$display("Insuffient amount inserted! You can add more money and buy the product or cancel the transaction. Thankyou");
							end
					end
				else
					begin
						out_of_order = 4'b0001;
						$display("Sorry,the item selected is unavailable!");
					end

				4'b0010://35
				if(prod1 > 4'b0000)
					begin
						if(amt >= pc1)
							begin
								change = amt - pc1;
								prod1 = prod1 - 4'b0001;
								del[1] = 1'b1;
								#0.2;
								del[1] = 1'b0;
							end
						else
							begin
								$display("Insuffient amount inserted! You can add more money and buy the product or cancel the transaction. Thankyou");
							end
					end
				else
					begin
						out_of_order = 4'b0010;
						$display("Sorry,the item selected is unavailable!");
					end

				4'b0100:
				if(prod2 > 4'b0000)
					begin
						if(amt >= pc2)
							begin
								change = amt - pc2;
								prod2 = prod2 - 4'b0001;
								del[2] = 1'b1;
								#0.2;
								del[2] = 1'b0;
							end
						else
							begin
								$display("Insuffient amount inserted! You can add more money and buy the product or cancel the transaction. Thankyou");
							end
					end
				else
					begin
						out_of_order = 4'b0100;
						$display("Sorry,the item selected is unavailable!");
					end

				4'b1000:
				if(prod3 > 4'b0000)
					begin
						if(amt >= pc3)
							begin
								change = amt - pc3;
								prod3 = prod3 - 4'b0001;
								del[3] = 1'b1;
								#0.2;
								del[3] = 1'b0;
							end
						else
								begin
									$display("Insuffient amount inserted! You can add more money and buy the product or cancel the transaction. Thankyou");
								end
						end
				else
					begin
						out_of_order = 4'b1000;
						$display("Sorry,the item selected is unavailable!");
					end
			
			endcase
		end
		
	always @(posedge can)
		begin
			change = amt;
			amt = 8'b00000000;
			halt = 1'b1;
			//create appropriate number of pulses for returning notes
			if(di5 > 0)
			begin
				return5 = 1'b1;
				#(di5*0.1);
				return5 = 1'b0;
			end
			if(di10 > 0)
			begin
				return10 = 1'b1;
				#(di10*0.1);
				return10 = 1'b0;
			end
			if(di20 > 0)
			begin
				return20 = 1'b1;
				#(di20*0.1);
				return20 = 1'b0;
			end
			if(di50 > 0)
			begin
				return50 = 1'b1;
				#(di50*0.1);
				return50 = 1'b0;
			end
			$display("Transaction cancelled.");
		end

	always@ (posedge del[0] or posedge del[1] or posedge del[2] or posedge del[3])
		begin
					count5 = count5 + di5;
					count10 = count10 + di10;
					count20 = count20 + di20; 
					count50 = count50 + di50;

					$display("Change due : Rs.%0d",change);
					while(change > 8'b00000000)
					begin
						if(change >= 8'd50)
						begin
							while(count50>=4'b0001 && change>=8'd50)
								begin
									change = change - 8'd50;
									count50 = count50 - 1;
									return50 = 1'b1;
									#0.1;
									return50 = 1'b0;
								end
						end
						else if(change >= 8'd20)
						begin
							while(count20>=4'b0001 && change>=8'd20)
								begin
									change = change - 8'd20;
									count20 = count20 - 1;
									return20 = 1'b1;
									#0.1;
									return20 = 1'b0;
								end
						end
						else if(change >= 8'd10)
						begin
							while(count10>=4'b0001 && change>=8'd10)
								begin
									change = change - 8'd10;
									count10 = count10 - 1;
									return10 = 1'b1;
									#0.1;
									return10 = 1'b0;
								end
						end
						else if(change >= 8'd5)
						begin
							while(count5>=4'b0001 && change>=8'd5)
								begin
									change = change - 8'd5;
									count5 = count5 - 1;
									return5 = 1'b1;
									#0.1;
									return5 = 1'b0;
								end
						end
					end//while

					$display("Thanks, Please come again! :)");
		end
endmodule
