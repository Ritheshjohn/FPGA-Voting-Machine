`timescale 1ns/1ps
module buttonControl(
    input clock,
    input reset,
    input button,
    output reg valid_vote
);

reg [30:0] counter;

// Counter logic to measure how long the button is held
always @(posedge clock)
begin
    if (reset)
        counter <= 0;
    else
    begin
        if (button & counter < 100000001)
            counter <= counter + 1;
        else if (!button)
            counter <= 0;
    end
end

// Output logic to generate a valid vote signal
always @(posedge clock)
begin
    if (reset)
        valid_vote <= 1'b0;
    else
    begin
        if (counter == 100000000)
            valid_vote <= 1'b1;
        else
            valid_vote <= 1'b0;
    end
end

endmodule

