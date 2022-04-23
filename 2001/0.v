`timescale 1ns/1ns
module adder_tb();
    //yours
    wire [7:0] y_led;
    //reference
    wire [7:0] r_led;
    reg mismatch;

    //input
    reg i_clk,i_rst;
    reg [2:0] i_switch,i_enable;
    
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
        reg [31:0] seed;
        int fh;
        fh = $fopen("/dev/urandom", "r");
        $fgets(seed,fh);
        $fclose(fh);
        seed=$urandom(seed);
        
        i_clk=1'b0;
        i_rst=1'b1;
        i_enable=3'b100;
        for(int i=0;i<40;i++)begin
            #1;
            i_switch=$urandom%8;
            
            if($urandom%7==0)begin
                i_enable=$urandom%8;
            end else
            begin
                i_enable<=3'b100;
            end
            
            if($urandom%5==0)begin
                i_rst<=1'b1;
            end else
            begin
                i_rst<=1'b0;
            end
            
        end
    	$finish;
	end
    
    always begin
        #1;
        i_clk<=~i_clk;
    end
	
    
    always@(*)begin
        mismatch=!($isunknown(r_led))&&y_led!==r_led;
    end
endmodule


module reference
(
    input clk,rst,
    input [2:0] enable,
    input [2:0] switch,
    output reg [7:0] led 
);
    
    always@(posedge clk or posedge rst)begin
        if(rst)begin
            led<=8'hff;
        end else
        begin
            led<=~((enable==3'd4)<<(switch));
        end
    end
    
endmodule
