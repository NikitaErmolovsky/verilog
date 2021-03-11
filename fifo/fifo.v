//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps
/*
module counter (clk, reset,inc,out,next);
	input clk,reset,inc;
	output reg [3:0]out;
	output wire [3:0]next;
	
	assign next[0] = inc^out[0];
	assign next[1] = out[1]^(out[0]&inc);
	assign next[2] = out[2]^(out[0]&out[1]&inc);
	assign next[3] = out[3]^(out[0]&out[1]&out[2]&inc);
	
	always @(posedge clk) 
		begin	
			out[0] <=next[0]&(~reset);
			out[1] <=next[1]&(~reset);
			out[2] <=next[2]&(~reset);
			out[3] <=next[3]&(~reset);
		end
		
	
endmodule

module d_trigger(clk,in,out, reset);
	input clk, in, reset;
	output reg out;
	always @(posedge clk)
		out <= (~reset)&in;
	endmodule
	
module mux16_1 (s,data_in_0, data_in_1, data_in_2, data_in_3, data_in_4, data_in_5, data_in_6, data_in_7,
	data_in_8, data_in_9, data_in_10, data_in_11, data_in_12, data_in_13, data_in_14, data_in_15,out);
	input [7:0] data_in_0, data_in_1, data_in_2, data_in_3, data_in_4, data_in_5, data_in_6, data_in_7, data_in_8, data_in_9, data_in_10,
	data_in_11, data_in_12, data_in_13, data_in_14, data_in_15;
	input [3:0] s;
	output wire[7:0] out;
		assign out[7:0] = (data_in_0[7:0]&(~s[0]&(~s[1])&(~s[2])&(~s[3]))) || (data_in_1[7:0]&(s[0]&(~s[1])&(~s[2])&(~s[3]))) || 
		(data_in_2[7:0]&(~s[0]&(s[1])&(~s[2])&(~s[3]))) || (data_in_3[7:0]&(s[0]&(s[1])&(~s[2])&(~s[3]))) || 
		(data_in_4[7:0]&(~s[0]&(~s[1])&(s[2])&(~s[3]))) || (data_in_5[7:0]&(s[0]&(~s[1])&(s[2])&(~s[3]))) ||
		(data_in_6[7:0]&(~s[0]&(s[1])&(s[2])&(~s[3]))) || (data_in_7[7:0]&(s[0]&(s[1])&(s[2])&(~s[3]))) ||
		(data_in_8[7:0]&(~s[0]&(~s[1])&(~s[2])&(s[3]))) || (data_in_9[7:0]&(s[0]&(~s[1])&(~s[2])&(s[3]))) ||
		(data_in_10[7:0]&(~s[0]&(s[1])&(~s[2])&(s[3]))) || (data_in_11[7:0]&(s[0]&(s[1])&(~s[2])&(s[3]))) ||
		(data_in_12[7:0]&(~s[0]&(~s[1])&(s[2])&(s[3]))) || (data_in_13[7:0]&(s[0]&(~s[1])&(s[2])&(s[3]))) ||
		(data_in_14[7:0]&(~s[0]&(s[1])&(s[2])&(s[3]))) || (data_in_0[7:0]&(s[0]&(s[1])&(s[2])&(s[3])));	  
	endmodule
	
module WE_demux16_1 (s,w,we_out_0,we_out_1,we_out_2,we_out_3,we_out_4,we_out_5,we_out_6,
	we_out_7,we_out_8,we_out_9,we_out_10,we_out_11,we_out_12,we_out_13,we_out_14,we_out_15);
	input w;
	input[3:0] s;
	output wire we_out_0, we_out_1,we_out_2,we_out_3,we_out_4,we_out_5,we_out_6,
	we_out_7,we_out_8,we_out_9,we_out_10,we_out_11,we_out_12,we_out_13,we_out_14,we_out_15;
	
	assign we_out_0 = w&((~s[0]&(~s[1])&(~s[2])&(~s[3])));
	assign we_out_1 = w&((s[0]&(~s[1])&(~s[2])&(~s[3])));
	assign we_out_2 = w&((~s[0]&(s[1])&(~s[2])&(~s[3])));
	assign we_out_3 = w&((s[0]&(s[1])&(~s[2])&(~s[3])));
	assign we_out_4 = w&((~s[0]&(~s[1])&(s[2])&(~s[3])));
	assign we_out_5 = w&((s[0]&(~s[1])&(s[2])&(~s[3])));
	assign we_out_6 = w&((~s[0]&(s[1])&(s[2])&(~s[3])));
	assign we_out_7 = w&((s[0]&(s[1])&(s[2])&(~s[3])));
	assign we_out_8 = w&((~s[0]&(~s[1])&(~s[2])&(s[3])));
	assign we_out_9 = w&((s[0]&(~s[1])&(~s[2])&(s[3])));
	assign we_out_10 = w&((~s[0]&(s[1])&(~s[2])&(s[3]))); 
	assign we_out_11 = w&((s[0]&(s[1])&(~s[2])&(s[3])));
	assign we_out_12 = w&((~s[0]&(~s[1])&(s[2])&(s[3])));
	assign we_out_13 = w&((s[0]&(~s[1])&(s[2])&(s[3])));
	assign we_out_14 = w&((~s[0]&(s[1])&(s[2])&(s[3])));
	assign we_out_15 = w&((s[0]&~s[1])&(s[2])&(s[3]));
	endmodule
	
		
module memory(clk,reset,we_0, we_1, we_2, we_3, we_4,we_5, we_6, we_7, we_8, we_9, we_10, we_11, we_12, we_13, we_14, we_15,data_in,
	data_out_0,data_out_1,data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,
	data_out_7,data_out_8,data_out_9,data_out_10,data_out_11,data_out_12,data_out_13,data_out_14,data_out_15);
	input clk, reset, we_0, we_1, we_2, we_3, we_4,we_5, we_6, we_7, we_8, we_9, we_10, we_11, we_12, we_13, we_14, we_15;
	input [7:0] data_in;
	output reg [7:0] data_out_0,data_out_1,data_out_2,data_out_3,data_out_4,data_out_5,data_out_6,
	data_out_7,data_out_8,data_out_9,data_out_10,data_out_11,data_out_12,data_out_13,data_out_14,data_out_15;
	always @(posedge clk)
			begin
				data_out_0[7:0] <= (data_out_0[7:0]&(~we_0)||(data_in[7:0] & we_0))&(~reset);
				data_out_1[7:0] <= (data_out_1[7:0]&(~we_1)||(data_in[7:0] & we_1))&(~reset);
				data_out_2[7:0] <= (data_out_2[7:0]&(~we_2)||(data_in[7:0] & we_2))&(~reset);
				data_out_3[7:0] <= (data_out_3[7:0]&(~we_3)||(data_in[7:0] & we_3))&(~reset);
				data_out_4[7:0] <= (data_out_4[7:0]&(~we_4)||(data_in[7:0] & we_4))&(~reset);
				data_out_5[7:0] <= (data_out_5[7:0]&(~we_5)||(data_in[7:0] & we_5))&(~reset);
				data_out_6[7:0] <= (data_out_6[7:0]&(~we_6)||(data_in[7:0] & we_6))&(~reset);
				data_out_7[7:0] <= (data_out_7[7:0]&(~we_7)||(data_in[7:0] & we_7))&(~reset);
				data_out_8[7:0] <= (data_out_8[7:0]&(~we_8)||(data_in[7:0] & we_8))&(~reset);
				data_out_9[7:0] <= (data_out_9[7:0]&(~we_9)||(data_in[7:0] & we_9))&(~reset);
				data_out_10[7:0] <= (data_out_10[7:0]&(~we_10)||(data_in[7:0] & we_10))&(~reset);
				data_out_11[7:0] <= (data_out_11[7:0]&(~we_11)||(data_in[7:0] & we_11))&(~reset);
				data_out_12[7:0] <= (data_out_12[7:0]&(~we_12)||(data_in[7:0] & we_12))&(~reset);
				data_out_13[7:0] <= (data_out_13[7:0]&(~we_13)||(data_in[7:0] & we_13))&(~reset);
				data_out_14[7:0] <= (data_out_14[7:0]&(~we_14)||(data_in[7:0] & we_14))&(~reset);
				data_out_15[7:0] <= (data_out_15[7:0]&(~we_15)||(data_in[7:0] & we_15))&(~reset); 
			end
endmodule
		
module fe_logic(clk,rst,cnt_w,cnt_r,cnt_w_next,cnt_r_next,w,r,out_full, out_empty);
	input clk,rst,w,r;
	input[3:0]cnt_w,cnt_r,cnt_w_next,cnt_r_next;
	output wire out_full, out_empty;
	
	d_trigger d_trig_empty (.clk(clk),.reset(rst),.in(out_empty),.out(out_empty_last));
	d_trigger d_trig_full (.clk(clk),.reset(rst),.in(out_full),.out(out_full_last));
	assign out_empty = (cnt_r_next[3:0] === cnt_w[3:0])&(~w&r)||(out_empty_last&(~w))||rst;
	assign out_full = ((cnt_w_next[3:0] === cnt_r[3:0])&(w&(~r))) || (out_full_last & (~r))&(~rst);	
endmodule

*/


module fifo(clk,reset,r,w,data_in,out,full,empty,
	cnt_w_next,cnt_w,cnt_r_next,cnt_r);
	input clk,reset,r,w;
	input [7:0] data_in;
	output wire [7:0]out;
	output reg full,empty;
	output wire [3:0] cnt_w_next,cnt_r_next;
	output reg [3:0] cnt_w, cnt_r;
	
//regs and wires
	//count
	/*wire [3:0] cnt_w_next;
	reg [3:0] cnt_w;
	wire [3:0] cnt_r_next;
	reg [3:0] cnt_r; */
	//WE_dmx_16_1 
	wire we_0,we_1,we_2,we_3,we_4,we_5,we_6,
	we_7,we_8,we_9,we_10,we_11,we_12,we_13,we_14,we_15;
	//memory
	reg [7:0] mem_out_0,mem_out_1,mem_out_2,mem_out_3,mem_out_4,mem_out_5,mem_out_6,
	mem_out_7,mem_out_8,mem_out_9,mem_out_10,mem_out_11,mem_out_12,mem_out_13,mem_out_14,mem_out_15;
	//FULL EMPTY
	wire empty_next, full_next;
//end of regs and wires


	//counter W
	assign cnt_w_next[0] = w^cnt_w[0];
	assign cnt_w_next[1] = cnt_w[1]^(cnt_w[0]&w);
	assign cnt_w_next[2] = cnt_w[2]^(cnt_w[0]&cnt_w[1]&w);
	assign cnt_w_next[3] = cnt_w[3]^(cnt_w[0]&cnt_w[1]&cnt_w[2]&w);	 
	//assign cnt_w_next[3:0]=cnt_w[3:0]+(4'b0001);
	always @(posedge clk) 		
		begin	
			
			cnt_w[0] <=cnt_w_next[0]&(~reset);
			cnt_w[1] <=cnt_w_next[1]&(~reset);
			cnt_w[2] <=cnt_w_next[2]&(~reset);
			cnt_w[3] <=cnt_w_next[3]&(~reset); 
			/*
			if(reset)
				cnt_w <=0;
			if(~reset & w)
			cnt_w[3:0]<=cnt_w[3:0]+4'b0001;	
			*/
		end
	
	//counter R	
	
	assign cnt_r_next[0] = r^cnt_r[0];
	assign cnt_r_next[1] = cnt_r[1]^(cnt_r[0]&r);
	assign cnt_r_next[2] = cnt_r[2]^(cnt_r[0]&cnt_r[1]&r);
	assign cnt_r_next[3] = cnt_r[3]^(cnt_r[0]&cnt_r[1]&cnt_r[2]&r);	 
	
	//assign cnt_r_next[3:0]=cnt_r[3:0]+(4'b0001);
	always @(posedge clk) 
		begin
			
			cnt_r[0] <=cnt_r_next[0]&(~reset);
			cnt_r[1] <=cnt_r_next[1]&(~reset);
			cnt_r[2] <=cnt_r_next[2]&(~reset);
			cnt_r[3] <=cnt_r_next[3]&(~reset);
			/*
			if(reset)
				cnt_r <=0;
			if(~reset & r)
			cnt_r[3:0]<=cnt_r[3:0]+4'b0001;	
			*/
		end
	 
	//WE_demux16_1
	assign we_0 = w&((~cnt_w[0]&(~cnt_w[1])&(~cnt_w[2])&(~cnt_w[3])));
	assign we_1 = w&((cnt_w[0]&(~cnt_w[1])&(~cnt_w[2])&(~cnt_w[3])));
	assign we_2 = w&((~cnt_w[0]&(cnt_w[1])&(~cnt_w[2])&(~cnt_w[3])));
	assign we_3 = w&((cnt_w[0]&(cnt_w[1])&(~cnt_w[2])&(~cnt_w[3])));
	assign we_4 = w&((~cnt_w[0]&(~cnt_w[1])&(cnt_w[2])&(~cnt_w[3])));
	assign we_5 = w&((cnt_w[0]&(~cnt_w[1])&(cnt_w[2])&(~cnt_w[3])));
	assign we_6 = w&((~cnt_w[0]&(cnt_w[1])&(cnt_w[2])&(~cnt_w[3])));
	assign we_7 = w&((cnt_w[0]&(cnt_w[1])&(cnt_w[2])&(~cnt_w[3])));
	assign we_8 = w&((~cnt_w[0]&(~cnt_w[1])&(~cnt_w[2])&(cnt_w[3])));
	assign we_9 = w&((cnt_w[0]&(~cnt_w[1])&(~cnt_w[2])&(cnt_w[3])));
	assign we_10 = w&((~cnt_w[0]&(cnt_w[1])&(~cnt_w[2])&(cnt_w[3]))); 
	assign we_11 = w&((cnt_w[0]&(cnt_w[1])&(~cnt_w[2])&(cnt_w[3])));
	assign we_12 = w&((~cnt_w[0]&(~cnt_w[1])&(cnt_w[2])&(cnt_w[3])));
	assign we_13 = w&((cnt_w[0]&(~cnt_w[1])&(cnt_w[2])&(cnt_w[3])));
	assign we_14 = w&((~cnt_w[0]&(cnt_w[1])&(cnt_w[2])&(cnt_w[3])));
	assign we_15 = w&((cnt_w[0]&~cnt_w[1])&(cnt_w[2])&(cnt_w[3]));
	
	// memory
	always @(posedge clk)
			begin
				mem_out_0[7:0] <= (mem_out_0[7:0] & {8{(~we_0)}} | (data_in[7:0] & {8{we_0}})) & {8{(~reset)}};
				mem_out_1[7:0] <= (mem_out_1[7:0] & {8{(~we_1)}} | (data_in[7:0] & {8{we_1}})) & {8{(~reset)}};
				mem_out_2[7:0] <= (mem_out_2[7:0] & {8{(~we_2)}} | (data_in[7:0] & {8{we_2}})) & {8{(~reset)}};
				mem_out_3[7:0] <= (mem_out_3[7:0] & {8{(~we_3)}} | (data_in[7:0] & {8{we_3}})) & {8{(~reset)}};
				mem_out_4[7:0] <= (mem_out_4[7:0] & {8{(~we_4)}} | (data_in[7:0] & {8{we_4}})) & {8{(~reset)}};
				mem_out_5[7:0] <= (mem_out_5[7:0] & {8{(~we_5)}} | (data_in[7:0] & {8{we_5}})) & {8{(~reset)}};
				mem_out_6[7:0] <= (mem_out_6[7:0] & {8{(~we_6)}} | (data_in[7:0] & {8{we_6}})) & {8{(~reset)}};
				mem_out_7[7:0] <= (mem_out_7[7:0] & {8{(~we_7)}} | (data_in[7:0] & {8{we_7}})) & {8{(~reset)}};
				mem_out_8[7:0] <= (mem_out_8[7:0] & {8{(~we_8)}} | (data_in[7:0] & {8{we_8}})) & {8{(~reset)}};
				mem_out_9[7:0] <= (mem_out_9[7:0] & {8{(~we_9)}} | (data_in[7:0] & {8{we_9}})) & {8{(~reset)}};
				mem_out_10[7:0] <= (mem_out_10[7:0] & {8{(~we_10)}} | (data_in[7:0] & {8{we_10}})) & {8{(~reset)}};
				mem_out_11[7:0] <= (mem_out_11[7:0] & {8{(~we_11)}} | (data_in[7:0] & {8{we_11}})) & {8{(~reset)}};
				mem_out_12[7:0] <= (mem_out_12[7:0] & {8{(~we_12)}} | (data_in[7:0] & {8{we_12}})) & {8{(~reset)}};
				mem_out_13[7:0] <= (mem_out_13[7:0] & {8{(~we_13)}} | (data_in[7:0] & {8{we_13}})) & {8{(~reset)}};
				mem_out_14[7:0] <= (mem_out_14[7:0] & {8{(~we_14)}} | (data_in[7:0] & {8{we_14}})) & {8{(~reset)}};
				mem_out_15[7:0] <= (mem_out_15[7:0]& {8{(~we_15)}} | (data_in[7:0] & {8{we_15}})) & {8{(~reset)}}; 
			end
			
		//mux16_1 OUT
		assign out[7:0] = 
		(mem_out_0[7:0]&{8{(~cnt_r[0] & (~cnt_r[1]) & (~cnt_r[2]) & (~cnt_r[3]))}}) | 
		(mem_out_1[7:0]&{8{(cnt_r[0] & (~cnt_r[1]) & (~cnt_r[2]) & (~cnt_r[3]))}}) | 
		(mem_out_2[7:0]&{8{(~cnt_r[0] & (cnt_r[1]) & (~cnt_r[2]) & (~cnt_r[3]))}}) |
		(mem_out_3[7:0]&{8{(cnt_r[0] & (cnt_r[1]) & (~cnt_r[2]) & (~cnt_r[3]))}}) | 
		(mem_out_4[7:0]&{8{(~cnt_r[0] & (~cnt_r[1]) & (cnt_r[2]) & (~cnt_r[3]))}}) |
		(mem_out_5[7:0]&{8{(cnt_r[0] & (~cnt_r[1]) & (cnt_r[2]) & (~cnt_r[3]))}}) |
		(mem_out_6[7:0]&{8{(~cnt_r[0] & (cnt_r[1]) & (cnt_r[2]) & (~cnt_r[3]))}}) | 
		(mem_out_7[7:0]&{8{(cnt_r[0] & (cnt_r[1]) & (cnt_r[2]) & (~cnt_r[3]))}}) |
		(mem_out_8[7:0]&{8{(~cnt_r[0] & (~cnt_r[1]) & (~cnt_r[2]) & (cnt_r[3]))}}) | 
		(mem_out_9[7:0]&{8{(cnt_r[0] & (~cnt_r[1]) & (~cnt_r[2]) & (cnt_r[3]))}}) |
		(mem_out_10[7:0]&{8{(~cnt_r[0] & (cnt_r[1]) & (~cnt_r[2]) & (cnt_r[3]))}}) | 
		(mem_out_11[7:0]&{8{(cnt_r[0] & (cnt_r[1]) & (~cnt_r[2]) & (cnt_r[3]))}}) |
		(mem_out_12[7:0]&{8{(~cnt_r[0] & (~cnt_r[1]) & (cnt_r[2]) & (cnt_r[3]))}}) | 
		(mem_out_13[7:0]&{8{(cnt_r[0] & (~cnt_r[1]) & (cnt_r[2]) & (cnt_r[3]))}}) |
		(mem_out_14[7:0]&{8{(~cnt_r[0] & (cnt_r[1]) & (cnt_r[2]) & (cnt_r[3]))}}) | 
		(mem_out_15[7:0]&{8{(cnt_r[0] & (cnt_r[1]) & (cnt_r[2]) & (cnt_r[3]))}}) & {8{r}};
		
	//FULL EMPTY LOGIC
	assign empty_next = (cnt_r_next[3:0] === cnt_w[3:0])&(~w&r)|(empty&(~w))|reset;
	//assign full_next = ((cnt_w_next[3:0] === cnt_r[3:0])&(w&(~r))) | (full & (~r))&(~reset); 
	assign full_next = (((cnt_w_next[3:0]===cnt_r[3:0]) & w & ~r) | (full & ~r))&(~reset);
	always @(posedge clk)
		begin
		 empty <= (~reset)&empty_next | (reset);
		 full <= (~reset)&full_next;
		end
endmodule
	
 
	