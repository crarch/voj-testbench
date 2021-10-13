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
    
	top_module #(WIDTH,1) top_module_ins (
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
    
    reference #(WIDTH,1) reference_ins(
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
        i_a=8'd1;
        i_b=8'd1;
        i_c=8'd1;
        i_d=8'd1;
        i_e=8'd1;
        i_f=8'd1;
        i_g=8'd1;
        i_h=8'd1;
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
    
    assign q=&{a,b,c,d,e,f,g,h};
    
endmodule
