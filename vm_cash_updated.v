`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:    10:46:15 08/24/20
// Design Name:    
// Module Name:    vending_machine_mod5
// Project_temp Name:   
// Target Device:  
// Tool versions:  
// Description:
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module vending_machine_cash(m20, m10, m5, A, B, C,clk, reset, cancel, current_state, next_state, change, del_A, del_B, del_C);
input m20, m10, m5, A, B, C, clk, reset, cancel;
output reg [3:0] next_state,current_state; 
output reg del_A, del_B, del_C;
output reg [5:0]change;
parameter rs0 = 0, rs5 = 1, rs10 = 2, rs15 = 3, rs20 = 4, rs25 = 5, rs30 = 6;
reg [3:0]ct[2:0];
wire [1:0]ct_temp[2:0];

initial 
begin
	ct[0] = 4'hA;
	ct[1] = 4'hA;
	ct[2] = 4'hA;	
end

always @(posedge clk or posedge reset)
    begin
        if(reset)
			  	begin
					change = 3'h0;
					del_A = 1'b0;
					del_B = 1'b0;
					del_C = 1'b0;
					current_state = rs0;
				
					ct_temp[0] = 4'hA;
					ct_temp[1] = 4'hA;
					ct_temp[2] = 4'hA;
					change = 4'h0;
				end
        else
            current_state = next_state;
    end

always @(m20 or m10 or m5)
    begin
	    case(current_state)
	        rs0: begin
		            if(m5)  
						begin
		                    next_state = rs5;
							ct_temp[0] = ct_temp[0] + 1'b1;
						end
		            else if(m10)
						begin
		                    next_state = rs10;
							ct_temp[1] = ct_temp[1] + 1'b1;
						end
		            else if(m20)
							begin
								ct_temp[2] = ct_temp[2] + 1'b1;
								if(C)
									begin
										next_state = rs0;
										del_C = 1;
									end
								else
									next_state = rs20;
							end
	             end

	        rs5: begin
		            if(m5)
						begin
							ct_temp[0] = ct_temp[0] + 1'b1;
		                    next_state = rs10;
						end
		            else if(m10)
						begin
							ct_temp[1] = ct_temp[1] + 1'b1;
		                    next_state = rs15;
						end
		            else if(m20)							
							begin
								ct_temp[2] = ct_temp[2] + 1'b1;
								if(C)
									begin
										change = 6'h5;
										next_state = rs0;
										del_C = 1;
									end
								else
									next_state = rs25;
							end
		          end

	        rs10: begin
		            if(m5)  
						begin
							ct_temp[0] = ct_temp[0] + 1'b1;
		                    next_state = rs15;
						end
		            else if(m10)
							begin
								ct_temp[1] = ct_temp[1] + 1'b1;
								if(C)
									begin
										next_state = rs0;
										del_C = 1;
									end
								else
		                    next_state = rs20;
							end
		            else if(m20)
							begin
								ct_temp[2] = ct_temp[2] + 1'b1;
								if(C)
									begin
										change = 6'hA;
										next_state = rs0;
										del_C = 1;
									end
								else
		                    next_state = rs30;
							end
	              end

	        rs15: begin
		            if(m5)
							begin
								ct_temp[0] = ct_temp[0] + 1'b1;
								if(C)
									begin
										next_state = rs0;
										del_C = 1;
									end
								else
		                    next_state = rs20;
							end  
		            else if(m10)
							begin
								ct_temp[1] = ct_temp[1] + 1'b1;
								if(C)
									begin
										change = 6'h5;
										next_state = rs0;
										del_C = 1;
									end
								else
		                    next_state = rs25;
							end
		            else if(m20)
								begin
									ct_temp[2] = ct_temp[2] + 1'b1;
									  next_state = rs0;
									  if(A)    
			                            del_A = 1;
			                    else if(B)
			                            del_B = 1;
									  else if(C)
									  		begin
												del_C = 1;
												change = 6'hF;
											end													
								end
	              end

	        rs20: begin
		            if(m5)  
						begin
							ct_temp[0] = ct_temp[0] + 1'b1;
		                    next_state = rs25;
						end
		            else if(m10)
						begin
							ct_temp[1] = ct_temp[1] + 1'b1;
		                    next_state = rs30;
						end
		            else if(m20)
									begin
									  next_state = rs0;
									  change = 6'h5;
			                    if(A)    
			                            del_A = 1;
			                    else if(B)
			                            del_B = 1;
									end
	            	end

            rs25: begin
	                if(m5)  
						begin
							ct_temp[0] = ct_temp[0] + 1'b1;
	                        next_state = rs30;
						end
	                else if(m10)
                 		begin
								ct_temp[1] = ct_temp[1] + 1'b1;
								next_state = rs0;
								if(A)    
                                del_A = 1;
                        else if(B)
                                del_B = 1;	
							end
	                else if(m20)
				 			begin
							ct_temp[2] = ct_temp[2] + 1'b1;
							next_state = rs0;
							change = 6'hA;
                        if(A)    
                                del_A = 1;
                        else if(B)
                                del_B = 1;
							end
                	end

            rs30: begin
		                if(m5)
					 			begin
								ct_temp[0] = ct_temp[0] + 1'b1;
			                  next_state = rs0;
					
									if(A)    
			                          del_A = 1;
			                  else if(B)
			                          del_B = 1;
								end
		                else if(m10)
					 			begin
								ct_temp[1] = ct_temp[1] + 1'b1;
			                  next_state = rs0;
									change = 6'h5;
			                  if(A)    
			                          del_A = 1;
			                  else if(B)
			                          del_B = 1;
								end
		                else if(m20)
					 			begin
								ct_temp[2] = ct_temp[2] + 1'b1;
								next_state = rs0;
								change = 6'hF;
					
			                  if(A)    
			                          del_A = 1;
			                  else if(B)
			                          del_B = 1;
								end
                   end
            default: next_state = current_state;
	            endcase
			
			
			
			always @ (posedge cancel)
			begin
				change = ct_temp[0] * 6'h5 + ct_temp[1] * 6'hA + ct_temp[2] * 6'h14;
			end
			
			
			
		end
endmodule