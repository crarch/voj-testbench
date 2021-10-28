`timescale 1ns/1ns
module adder_tb();
    reg mismatch;

	top_module top_module_ins (
	);
    

	initial begin
        $dumpvars(
            1,
            adder_tb.mismatch
        );
        #20;
	$finish;
	end
    
	initial begin
        mismatch=0'b1;
	end
	
endmodule
