`timescale 1ns/1ns
module adder_tb();
    //yours
    wire [15:0] y_led;
    //reference
    wire [15:0] r_led;
    reg mismatch;

    //input
    reg i_clk;
    reg i_rst;
    reg [2:0] i_switch;
    reg i_button;
    
	top_module top_module_ins (
        .clk(i_clk),
        .rst(i_rst),
        .button(i_button),
        .led(y_led)
	);
    
    reference reference_ins(
        .clk(i_clk),
        .rst(i_rst),
        .button(i_button),
        .led(r_led)
	);
    

	initial begin
        $dumpvars(
            1,
            //input
            adder_tb.i_clk,
            adder_tb.i_rst,
            adder_tb.i_button,
            //yours
            adder_tb.y_led,
            //reference
            adder_tb.r_led,
            //mismatch    
            adder_tb.mismatch
        );
	end
    
    always begin
        #1;
        i_clk<=~i_clk;
    end
    
	
	initial begin
        reg [31:0] seed;
        int fh;
        fh = $fopen("/dev/urandom", "r");
        $fgets(seed,fh);
        $fclose(fh);
        seed=$urandom(seed);
        
        i_clk=0;
        i_rst=1;
        i_button=1;
        #1;
        i_rst=0;
        #39;
	$finish;
	end
	
    
    always@(*)begin
        mismatch=y_led!==r_led;
    end
endmodule


module reference(
    input  wire       clk   ,
	input  wire       rst   ,
	input  wire       button,
	output wire  [15:0] led
);
    reg start;
    always@(posedge clk or posedge rst)begin
        if(rst)start<=1'b0;
        else if(button)start<=1'b1;
        else start<=start;
    end
    
    reg [16:0] sum;
    always@(posedge clk or posedge rst)begin
        if(rst)sum<=17'b1;
        else if(sum==17'h10000)sum<=sum;
        else sum<=sum<<1;
    end
    
    
    
    assign led=sum-17'b1;
    
endmodule
