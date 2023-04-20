
module bound_flasher_tb;
    reg reset=1, flick=0, clk=0;
    wire[15:0] out;
    wire [3:0] state;
    bound_flasher uut(.reset(reset), .flick(flick), .clk(clk), .out(out), .state(state));
    //initial assign
    initial begin
    reset = 1'b1;
    flick = 1'b0;
    clk = 0;
    end
    //clock generator
    always begin
        clk = 0;
        #10;
        clk = 1;
        #10;
    end
    //end
    initial begin
        #10000000;
        $finish;
    end
    //testcase 0: no flick
//    testcase 1: default trigger once
//    initial begin
//        #25;
//        flick = 1;
//        #50;
//        flick = 0;
//    end
    //testcase 2: trigger+reset
//    initial begin
//        #2;
//        flick = 1;
//        #10;
//        flick = 0;
//        #100;
//        reset = 0;
//        #20;
//        reset = 1;
//    end
    //testcase 3: flick at state s3 kickbackPoint5
//    initial begin
//        #2;
//        flick=1;
//        #10;
//        flick=0;
//        #313;
//        flick=1;
//        #30;
//        flick=0;
//    end
     //testcase 4: flick at state s3 kickbackPoint5 and state s5 kickbackPoint10
//        initial begin
//        #2;
//        flick=1;
//        #10;
//        flick=0;
//        #313;
//        flick=1;
//        #30;
//        flick=0;
//        end
        
//        initial begin
//        #817;
//        flick=1;
//        #20;
//        flick = 0;
//        end

    //testcase 5: flick signal always equal 1
//    initial begin
//    #2;
//    flick=1;
//    end

    //testcase 6: flick signal always equal 1 after state 4
//    initial begin
//    #2
//    flick=1;
//    #20;
//    flick=0;
//    #483;
//    flick=1;
//    end
    
    //testcase 7: flick at state s3 kickbackPoint10
//    initial begin
//        #2
//        flick=1;
//        #20;
//        flick=0;
//        #395;
//        flick = 1;
//        #20;
//        flick = 0;
//    end
//    //reset
//    initial begin
//        #563;
//        reset = 0;
//        #20;
//        reset = 1;
//    end
//    //flick again
//    initial begin
//        #603;
//        flick = 1;
//        #20;
//        flick = 0;
//    end
    
    //testcase 8: random test
//    initial begin
//        #4;
//        flick = 1;
//        #20;
//        flick = 0;
//    end
    
//    initial begin
//        #132;
//        reset = 0;
//        #20;
//        reset = 1;
//    end
    
//    initial begin
//        #385;
//        flick = 1;
//        #187;
//        flick = 0;
//    end
    
//    initial begin
//        #632;
//        flick = 1;
//        #185;
//        flick = 0;
//    end
    
//    initial begin
//        #832;
//        reset = 0;
//        #178;
//        reset = 1;
//    end
initial begin
  $recordfile ("waves");
  $recordvars ("depth=0", testbench);
end

endmodule
