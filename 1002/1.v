`timescale 1ns/1ns
module adder_tb();
    wire y_a;
    reg r_a;
    reg mismatch;

	top_module top_module_ins (
		.a(y_a)
	);
    

	initial begin
        $dumpvars(
            1,
            adder_tb.y_a,
            adder_tb.r_a,
            adder_tb.mismatch
     
        );
        #40;
	$finish;
	end
    
	initial begin
        mismatch=y_a!=r_a;
	end
	
	initial begin
        r_a=1'b0;
        #40;
	end
	
    
    always@(*)begin
        mismatch=y_a!=r_a;
    end
endmodule
