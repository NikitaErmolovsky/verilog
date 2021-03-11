
module FIFO_TEST;

//parametres
parameter CLOCK = 5;
parameter PERIOD = 2*CLOCK;
parameter FIFO_SIZE = 16;
	
reg clk,reset,r,w;
wire full,empty;
reg [7:0] data_in;
wire[7:0] out;
reg [7:0] test_data;
wire [3:0] cnt_w_next;
wire [3:0] cnt_w;
wire [3:0] cnt_r_next;
wire [3:0] cnt_r;

fifo fifo1(.clk(clk),.reset(reset),.r(r),.w(w),.data_in(data_in),.out(out),.full(full),.empty(empty),.cnt_w_next(cnt_w_next),.cnt_w(cnt_w),
.cnt_r(cnt_r),.cnt_r_next(cnt_r_next)); 



	initial	 begin
		clk = 0;
		data_in = 0;
		test_data = 0;
		r =0;
		w = 0;
		forever	  
		begin
			#CLOCK clk = ~clk;
		end	 
	end
	
	
	
	 always @(negedge clk & ~full & w)
		begin
			data_in[7:0]<= data_in[7:0]+8'b0000_0001; 
		end
	 
		
	always @(posedge clk & (~empty & r))
		begin
			//test_data[7:0] <= test_data[7:0]+ 8'b0000_0001; 
			if (out[7:0] != out[7:0] + 8'b0000_0001)
				begin
					$display("data lost! out = %b. Correct out is %b",out[7:0],(out[7:0] + 8'b0000_0001));
				end
				
		end
		
	
initial begin
 @(negedge clk);
 @(negedge clk);
 reset = 1;
 @(negedge clk);
 reset = 0;
 w = 1;
 @(negedge clk);
 @(negedge clk);
 @(negedge clk);
 w = 0;
 r = 1;
 @(negedge clk);
 @(negedge clk);
 r = 0;
 #1000 $finish;
end	 

  
	

/*	
	
// auto tests	
initial
	begin
		@(posedge clk);
		@(negedge clk);
		reset = 1;
		#(PERIOD) if(out[7:0]!==7'b0)
		begin
			$display("test failed: out is not 0 while reset = 1");
			$finish;
		end
		@(negedge clk);
		reset = 0;
		#(PERIOD) if(empty!== 1)
		begin
			$display("test failed: empty != 0 at start");
			//$finish;
		end
		@(negedge clk);
		w = 1; data_in = 8'b11111111;
		#(PERIOD) if(out[7:0]!==8'b11111111) 
		begin
			$display("test failed: you should have out = 8'b11111111, but out = %b",out);
			$finish;
		end
		@(negedge clk);
		data_in = 8'b00001111;
		#(PERIOD) if(out[7:0]!==8'b11111111) 
		begin
			$display("test failed: you should have out = 8'b11111111, but out = %b",out);
			$finish;
		end
		@(negedge clk);
		data_in = 8'b11110000;
		#(PERIOD) if(out[7:0]!==8'b11111111) 
		begin
			$display("test failed: you should have out = 8'b11111111, but out = %b",out);
			$finish;
		end
		@(negedge clk);
		w = 0; r = 1;
		#(PERIOD) if(out[7:0]!==8'b00001111) 
		begin
			$display("test failed: you should have out = 8'b00001111, but out = %b",out);
			$finish;
		end
		@(negedge clk);
		#(PERIOD) if(out[7:0]!==8'b11110000) 
		begin
			$display("test failed: you should have out = 8'b11110000, but out = %b",out);
			$finish;
		end
		@(negedge clk);
		#(PERIOD) if(out[7:0]!==8'b0) 
		begin
			$display("test failed: you should have out = 8'b0, but out = %b",out);
			$finish;
		end
		@(negedge clk);
		r=0;
		#(PERIOD) if(empty!==1) 
		begin
			$display("test failed: empty !=0 after reading all DATA");
			$finish;
		end
		@(negedge clk);
		w = 1; data_in = 8'b11111111;
		#(PERIOD*FIFO_SIZE) if(full!==1) 
		begin
			$display("test failed: full != 1 when fifo is full");
			$finish;
		end
		#1000 $finish;
	end
	 */
	/*	
//воздействие
initial begin
	r = 0; w = 0; data_in = 8'b11111111;
	@(negedge clk) reset = 1;
	@(negedge clk) reset = 0;
	@(negedge clk);
	@(negedge clk);
	@(negedge clk)#2 w = 1;
	@(negedge clk);
	@(negedge clk) w = 0;
	@(negedge clk) r = 1;
	@(negedge clk) data_in = 8'b00001111;
	@(negedge clk) r = 0; w = 1;
	@(negedge clk);
	@(negedge clk) r = 1;
	@(negedge clk);
	//@(negedge clk) rst = 1;
	@(negedge clk);
	//@(negedge clk) rst = 0;
	//#1000 $display("tests OK!"); 
	
end
		
*/


endmodule
		