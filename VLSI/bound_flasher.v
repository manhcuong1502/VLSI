module bound_flasher(reset, flick, clk, out, state);
input clk, reset, flick; //input
output reg [15:0] out; //output
//define state and kickback point
parameter init = 4'b0000,
          s1 = 4'b0001,
          s2 = 4'b0010,
          s3 = 4'b0011,
          s4 = 4'b0100,
          s5 = 4'b0101,
          s6 = 4'b0110,
          s3_flick = 4'b0111,
          s5_flick = 4'b1000,
          kickbackPoint5 = 16'b0000_0000_0011_1111,
          kickbackPoint10 = 16'b0000_0111_1111_1111;

//variable define
reg [15:0] max; //store max value
reg [15:0] min;//store min value
reg countUp;//countUp=1 means lamps are gradually turn on.

//state for fsm
output reg [3:0] state;
reg [3:0] nextState;
reg [15:0] nextOutput;

//initial value
initial begin
    out = 0;
    nextOutput = 0;
    state = init;
    nextState = init;
    max = 0;
    min = 0;
    countUp = 0;
end

//reset block
always @(posedge clk) begin
    if (reset ==1'b0) begin
        state <= init;
        out <= 0;
    end
    else begin
        state <=nextState;
        out <= nextOutput;
    end
end

//update nextOutput 
always @(countUp, state, out) begin
    if (state == init) nextOutput <= 0;
    else begin
        if(countUp==1'b1) nextOutput <=out*2+1;
        else nextOutput <=out/2;
    end
end

//update nextState

always @(out, flick) begin
    case (state)
        init: begin
            if (flick == 1) nextState <= s1;
            else nextState <= state;
        end
        s1: begin
            if (out == max) nextState <= s2;
            else nextState <= state;
        end
        s2: begin
            if (out == min) nextState <= s3;
            else nextState <= state;
        end
        s3: begin
            if ((out == kickbackPoint5 || out == kickbackPoint10) && flick == 1) nextState <= s3_flick;
            else if (out == max) nextState <= s4;
            else nextState <= state;
        end
        s3_flick: begin
            if (out == min) nextState <= s3;
            else nextState <=state;
        end
        s4: begin
            if (out == min) nextState <= s5;
            else nextState <= state;
        end
        s5: begin
            if ((out == kickbackPoint5 || out == kickbackPoint10) && flick == 1) nextState <= s5_flick;
            else if (out == max) nextState <= s6;
            else nextState <= state;
        end
        s5_flick: begin
            if (out == min) nextState <= s5;
            else nextState <=state;
        end
        s6: begin
            if (out == min) nextState <= init;
            else nextState <= state;
        end
        default: nextState <= state;
    endcase
           
end
//update min,max

always @(nextState) begin
    case (nextState)
        init: begin
            min<=0;
            max<=0;
            countUp <= 0;
            end
        s1: begin
            min<=0;
            max<=16'b0000_0000_0011_1111;
            countUp <= 1;
            end
        s2: begin
            min<=0;
            max<=16'b0000_0000_0011_1111;
            countUp <= 0;
            end
        s3: begin
            min<=0;
            max<=16'b0000_0111_1111_1111;
            countUp <= 1;
            end
        s4: begin
            min<=16'b0000_0000_0001_1111;
            max<=16'b0000_0111_1111_1111;
            countUp <= 0;
            end
        s5: 
        begin
            min<=16'b0000_0000_0001_1111;
            max<=16'b1111_1111_1111_1111;
            countUp <= 1;
        end
        s6:
        begin
            min<=0;
            max<=16'b1111_1111_1111_1111;
            countUp <= 0;
        end
        s3_flick:
        begin
            min <=0;
            max <=16'b0000_0000_0011_1111;
            countUp <=0;
        end
        
        s5_flick:
        begin
            min <=16'b0000_0000_0001_1111;
            max <=16'b0000_0111_1111_1111;
            countUp <=0;
        end
        
        default:
        begin
            min<=0;
            max<=0;
            countUp = 0;
        end
    endcase
end

endmodule