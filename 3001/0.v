`timescale 1ns/1ns
module adder_tb();
    parameter WIDTH=8;
    //yours
    wire [(WIDTH-1):0] y_q;
    //reference
    wire [(WIDTH-1):0] r_q;
    reg mismatch;

    //input
    reg [(WIDTH-1):0] i_a;
    reg [(WIDTH-1):0] i_b;
    reg [(WIDTH-1):0] i_c;
    reg [(WIDTH-1):0] i_d;
    reg [(WIDTH-1):0] i_e;
    reg [(WIDTH-1):0] i_f;
    reg [(WIDTH-1):0] i_g;
    reg [(WIDTH-1):0] i_h;
    
	top_module #(2,WIDTH) top_module_ins (
		.a(i_a),
		.b(i_b),
		.c(i_c),
		.d(i_d),
		.e(i_e),
		.f(i_f),
		.g(i_g),
		.h(i_h),
        .q(y_q)
	);
    
    reference #(2,WIDTH) reference_ins(
		.a(i_a),
		.b(i_b),
		.c(i_c),
		.d(i_d),
		.e(i_e),
		.f(i_f),
		.g(i_g),
		.h(i_h),
        .q(r_q)
	);
    

	initial begin
        $dumpvars(
            1,
            //input
            adder_tb.i_a,
            adder_tb.i_b,
            adder_tb.i_c,
            adder_tb.i_d,
            adder_tb.i_e,
            adder_tb.i_f,
            adder_tb.i_g,
            adder_tb.i_h,
            //yours
            adder_tb.y_q,
            //reference
            adder_tb.r_q,
            //mismatch    
            adder_tb.mismatch
        );
	end
    
	
	initial begin
        for(int i=0;i<20;i++)begin
            i_a=$urandom%128;
            i_b=$urandom%128;
            i_c=$urandom%128;
            i_d=$urandom%128;
            i_e=$urandom%128;
            i_f=$urandom%128;
            i_g=$urandom%128;
            i_h=$urandom%128;
            #1;
        end
	$finish;
	end
	
    
    always@(*)begin
        mismatch=y_q!==r_q;
    end
endmodule


module reference
#(parameter Port_Num=2,parameter WIDTH=8)
(
    input [(WIDTH-1):0] a,
    input [(WIDTH-1):0] b,
    input [(WIDTH-1):0] c,
    input [(WIDTH-1):0] d,
    input [(WIDTH-1):0] e,
    input [(WIDTH-1):0] f,
    input [(WIDTH-1):0] g,
    input [(WIDTH-1):0] h,
    output reg [(WIDTH-1):0] q
);
    
    assign q=a&b&c&d&e&f&g&h;
    
endmodule
