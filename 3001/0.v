`timescale 1ns/1ns
module adder_tb();
    //yours
    wire [7:0] y_led;
    //reference
    wire [7:0] r_led;
    reg mismatch;

    //input
    reg i_clk;
    reg i_rst;
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
        clk<=~clk;
    end
    
	
	initial begin
        clk=0;
        rst=0;
        button=1;
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
	output reg  [7:0] led
);
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            led<=8'h1;
        end
        else begin
            if(button)begin
                led<=(led<<1)|{{7{1'b0}},{led[7]}};
            end else
            begin
                led<=led;
            end
        end
    end
    
    
endmodule
