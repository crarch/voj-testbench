`timescale 1ns/1ns
module adder_tb();
    wire y_c;
    wire r_c;
    reg mismatch;

    reg i_a;
    reg i_b;
    
	top_module top_module_ins (
		.a(i_a),
        .b(i_b),
        .c(y_c)
	);
    
    reference reference_ins(
		.a(i_a),
        .b(i_b),
        .c(r_c)
	);
    

	initial begin
        $dumpvars(
            1,
            //input
            adder_tb.i_a,
            adder_tb.i_b,
            //yours
            adder_tb.y_c,
            //reference
            adder_tb.r_c,
            //mismatch    
            adder_tb.mismatch
        );
	end
    
	initial begin
        mismatch=y_c!=r_c;
	end
	
	initial begin
	i_a=0;
	i_b=1;
        #1;
        i_a=1;
        i_b=1;
        #1;
        i_a=1;
        i_b=0;
        #1;
        i_a=0;
        i_b=0;
        #1;
        i_a=1;
        i_b=0;
        #1;
        i_a=0;
        i_b=1;
        #1;
        i_a=1;
        i_b=1;
        #1;
        i_a=1;
        i_b=0;
        #1;
        i_a=0;
        i_b=0;
        #1;
        i_a=1;
        i_b=1;
        #1;
        i_a=1;
        i_b=0;
	$finish;
	end
	
    
    always begin
        mismatch=y_c!=r_c;
        #1;
    end
endmodule


module reference(
    input a,
    input b,
    output c
);
    assign c=a&b;
    
endmodule
