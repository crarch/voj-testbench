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
        .switch(i_switch)
        .led(y_led)
	);
    
    reference reference_ins(
        .clk(i_clk),
        .rst(i_rst),
        .button(i_button),
        .switch(i_switch)
        .led(r_led)
	);
    

	initial begin
        $dumpvars(
            1,
            //input
            adder_tb.i_clk,
            adder_tb.i_rst,
            adder_tb.i_button,
            adder_tb.i_switch,
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
        i_clk=0;
        i_rst=1;
        i_button=1;
        i_switch=3'd2;
        #1;
        i_rst=0;
        #19;
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
	input wire [2:0] switch,
	output reg  [15:0] led
);
    wire [7:0] length;
    assign length=(1<<(switch+1))-1;
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            led<=length;
        end
        else begin
            if(button)begin
                led<=(led<<1)|{{15{1'b0}},{(led[15]||led[0])&&(led[7:0]<length)}};
            end else
            begin
                led<=led;
            end
        end
    end
endmodule
