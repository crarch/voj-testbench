`timescale 1ns/1ns
module adder_tb();
    //yours
    wire [7:0] y_led;
    //reference
    wire [7:0] r_led;
    reg mismatch;

    //input
    reg i_clk,i_rst,i_enable;
    reg [2:0] i_switch;
    
	top_module top_module_ins (
        .clk(i_clk),
        .rst(i_rst),
        .enable(i_enable),
        .switch(i_switch),
        .led(y_led)
	);
    
    reference reference_ins(
        .clk(i_clk),
        .rst(i_rst),
        .enable(i_enable),
        .switch(i_switch),
        .led(r_led)
	);
    

	initial begin
        $dumpvars(
            1,
            //input
            i_clk,
            i_rst,
            i_enable,
            i_switch,
            //yours
            adder_tb.y_led,
            //reference
            adder_tb.r_led,
            //mismatch    
            adder_tb.mismatch
        );
	end
    
	
	initial begin
        i_clk=1'b0;
        i_rst=1'b0;
        i_enable=1'b1;
        for(int i=0;i<40;i++)begin
            i_switch=$urandom%8;
            #1;
        end
    	$finish;
	end
    
    always begin
        #1;
        i_clk<=~i_clk;
    end
	
    
    always@(*)begin
        mismatch=y_led!==r_led;
    end
endmodule


module reference
(
    input clk,rst,enable,
    input switch,
    output [7:0] led 
);
    
    assign led=8'b0;//fix me
    
endmodule
