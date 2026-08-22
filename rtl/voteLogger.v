`timescale 1ns/1ps
// voteLogger module// Logs the number of valid votes received for each candidate.
// Votes are only counted when mode == 0 (voting mode).
module voteLogger(
    input clock, // System clock
    input reset, // Reset signal to clear all vote counts
    input mode, // Mode signal (0 = voting mode, 1 = result mode)
    input cand1_vote_valid, // Valid vote signal for candidate 1
    input cand2_vote_valid, // Valid vote signal for candidate 2
    input cand3_vote_valid, // Valid vote signal for candidate 3
    input cand4_vote_valid, // Valid vote signal for candidate 4
    output reg [7:0] cand1_vote_recvd, // Vote count for candidate 1
    output reg [7:0] cand2_vote_recvd, // Vote count for candidate 2
    output reg [7:0] cand3_vote_recvd, // Vote count for candidate 3
    output reg [7:0] cand4_vote_recvd // Vote count for candidate 4
);

// Synchronous logic triggered on the rising edge of the clock
always @(posedge clock)
begin
    if(reset)
    begin
        // Reset all vote counts to zero when reset is active
        cand1_vote_recvd <= 0;
        cand2_vote_recvd <= 0;
        cand3_vote_recvd <= 0;
        cand4_vote_recvd <= 0;
    end
    else
    begin
        // Only count votes in voting mode (mode == 0)
        // Prioritize one vote per clock cycle using if-else chain
        if(cand1_vote_valid & mode == 0)
            cand1_vote_recvd <= cand1_vote_recvd + 1;
        else if(cand2_vote_valid & mode == 0)
            cand2_vote_recvd <= cand2_vote_recvd + 1;
        else if(cand3_vote_valid & mode == 0)
            cand3_vote_recvd <= cand3_vote_recvd + 1;
        else if(cand4_vote_valid & mode == 0)
            cand4_vote_recvd <= cand4_vote_recvd + 1;
    end
end
endmodule


