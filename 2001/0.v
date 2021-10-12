`timescale 1ns/1ns
module adder_tb();
    wire y_b;
    wire r_b;
    reg mismatch;

    reg [2:0] i_a;
    
	top_module top_module_ins (
		.a(i_a),
        .b(y_b)
	);
    
    reference reference_ins(
		.a(i_a),
        .b(r_b)
	);
    

	initial begin
        $dumpvars(
            1,
            //input
            adder_tb.i_a,
            //yours
            adder_tb.y_b,
            //reference
            adder_tb.r_b,
            //mismatch    
            adder_tb.mismatch
        );
	end
    
	initial begin
        mismatch=y_b!=r_b;
	end
	
	initial begin
    	i_a=3'd0;
        #1;
        i_a=3'd3;
        #1;
        i_a=3'd4;
        #1;
        i_a=3'd6;
        #1;
        i_a=3'd1;
        #1;
        i_a=3'd2;
        #1;
        i_a=3'd5;
        #1;
        i_a=3'd7;
	$finish;
	end
	
    
    always@(*)begin
        mismatch=y_c!=r_c;
    end
endmodule


module reference(
    input [2:0] a,
    output [7:0] b
);
    assign b=8'b0;
    assign b[a]=1'b1;
    
endmodule
