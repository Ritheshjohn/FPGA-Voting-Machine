`timescale 1ns/1ps

module votingMachine_tb;

    // ------------------------------------------------
    // Testbench signals
    // ------------------------------------------------

    reg clock;
    reg reset;
    reg mode;

    reg button1;
    reg button2;
    reg button3;
    reg button4;

    wire [7:0] led;


    // ------------------------------------------------
    // DUT
    // ------------------------------------------------

    votingMachine dut (
        .clock   (clock),
        .reset   (reset),
        .mode    (mode),
        .button1 (button1),
        .button2 (button2),
        .button3 (button3),
        .button4 (button4),
        .led     (led)
    );


    // ------------------------------------------------
    // 100 MHz clock
    // ------------------------------------------------

    initial
    begin
        clock = 1'b0;
        forever #5 clock = ~clock;
    end


    // ------------------------------------------------
    // MAIN TEST
    // ------------------------------------------------

    initial
    begin

        // Initial values
        reset   = 1'b1;
        mode    = 1'b0;

        button1 = 1'b0;
        button2 = 1'b0;
        button3 = 1'b0;
        button4 = 1'b0;


        // ============================================
        // TEST 1 : RESET
        // ============================================

        $display("\n======================================");
        $display("TEST 1 : RESET");
        $display("======================================");

        repeat (5)
            @(posedge clock);

        reset = 1'b0;

        repeat (5)
            @(posedge clock);

        $display("Vote counts after reset:");
        $display("C1 = %0d", dut.cand1_vote_recvd);
        $display("C2 = %0d", dut.cand2_vote_recvd);
        $display("C3 = %0d", dut.cand3_vote_recvd);
        $display("C4 = %0d", dut.cand4_vote_recvd);


        // ============================================
        // TEST 2 : SHORT PRESS - INVALID VOTE
        // ============================================

        $display("\n======================================");
        $display("TEST 2 : SHORT BUTTON PRESS");
        $display("======================================");

        short_press_candidate1;

        $display("C1 votes after short press = %0d",
                 dut.cand1_vote_recvd);


        // ============================================
        // TEST 3 : CANDIDATE 1 - 1 VOTE
        // ============================================

        $display("\n======================================");
        $display("TEST 3 : CANDIDATE 1 - 1 VOTE");
        $display("======================================");

        vote_candidate1;

        $display("C1 votes = %0d",
                 dut.cand1_vote_recvd);

        wait_for_led_off;


        // ============================================
        // TEST 4 : CANDIDATE 2 - 2 VOTES
        // ============================================

        $display("\n======================================");
        $display("TEST 4 : CANDIDATE 2 - 2 VOTES");
        $display("======================================");

        vote_candidate2;
        wait_for_led_off;

        vote_candidate2;

        $display("C2 votes = %0d",
                 dut.cand2_vote_recvd);

        wait_for_led_off;


        // ============================================
        // TEST 5 : CANDIDATE 3 - 3 VOTES
        // ============================================

        $display("\n======================================");
        $display("TEST 5 : CANDIDATE 3 - 3 VOTES");
        $display("======================================");

        vote_candidate3;
        wait_for_led_off;

        vote_candidate3;
        wait_for_led_off;

        vote_candidate3;

        $display("C3 votes = %0d",
                 dut.cand3_vote_recvd);

        wait_for_led_off;


        // ============================================
        // TEST 6 : CANDIDATE 4 - 4 VOTES
        // ============================================

        $display("\n======================================");
        $display("TEST 6 : CANDIDATE 4 - 4 VOTES");
        $display("======================================");

        vote_candidate4;
        wait_for_led_off;

        vote_candidate4;
        wait_for_led_off;

        vote_candidate4;
        wait_for_led_off;

        vote_candidate4;

        $display("C4 votes = %0d",
                 dut.cand4_vote_recvd);

        wait_for_led_off;


        // ============================================
        // FINAL VOTE COUNT
        // ============================================

        $display("\n======================================");
        $display("FINAL VOTE COUNTS");
        $display("======================================");

        $display("Candidate 1 = %0d",
                 dut.cand1_vote_recvd);

        $display("Candidate 2 = %0d",
                 dut.cand2_vote_recvd);

        $display("Candidate 3 = %0d",
                 dut.cand3_vote_recvd);

        $display("Candidate 4 = %0d",
                 dut.cand4_vote_recvd);


        // ============================================
        // TEST 7 : RESULT MODE
        // ============================================

        $display("\n======================================");
        $display("TEST 7 : RESULT MODE");
        $display("======================================");

        mode = 1'b1;

        repeat (5)
            @(posedge clock);


        // --------------------------------------------
        // Candidate 1 result
        // --------------------------------------------

        result_candidate1;

        repeat (2)
            @(posedge clock);

        $display("Candidate 1 result = %0d",
                 led);


        // --------------------------------------------
        // Candidate 2 result
        // --------------------------------------------

        result_candidate2;

        repeat (2)
            @(posedge clock);

        $display("Candidate 2 result = %0d",
                 led);


        // --------------------------------------------
        // Candidate 3 result
        // --------------------------------------------

        result_candidate3;

        repeat (2)
            @(posedge clock);

        $display("Candidate 3 result = %0d",
                 led);


        // --------------------------------------------
        // Candidate 4 result
        // --------------------------------------------

        result_candidate4;

        repeat (2)
            @(posedge clock);

        $display("Candidate 4 result = %0d",
                 led);


        // ============================================
        // TEST 8 : VOTE ATTEMPT IN RESULT MODE
        // ============================================

        $display("\n======================================");
        $display("TEST 8 : VOTE ATTEMPT IN RESULT MODE");
        $display("======================================");

        vote_candidate1;

        $display("Counts after invalid vote attempt:");
        $display("C1 = %0d", dut.cand1_vote_recvd);
        $display("C2 = %0d", dut.cand2_vote_recvd);
        $display("C3 = %0d", dut.cand3_vote_recvd);
        $display("C4 = %0d", dut.cand4_vote_recvd);


        // ============================================
        // FINAL RESULT
        // ============================================

        $display("\n======================================");
        $display("FINAL RESULT");
        $display("======================================");

        $display("C1 = %0d", dut.cand1_vote_recvd);
        $display("C2 = %0d", dut.cand2_vote_recvd);
        $display("C3 = %0d", dut.cand3_vote_recvd);
        $display("C4 = %0d", dut.cand4_vote_recvd);

        $display("LED = %h", led);

        $display("======================================");
        $display("SIMULATION COMPLETE");
        $display("======================================");

        repeat (10)
            @(posedge clock);

        $finish;

    end


    // =================================================
    // SHORT PRESS - INVALID VOTE
    // =================================================
    //
    // Actual design:
    //
    // Valid threshold = 100,000,000 counts
    //
    // For this test:
    //
    // Counter = 9,999,999
    //
    // After one clock:
    //
    // 9,999,999 -> 10,000,000
    //
    // 10,000,000 < 100,000,000
    //
    // Therefore valid_vote = 0
    // =================================================

    task short_press_candidate1;
    begin

        $display("Testing INVALID vote for Candidate 1");
        $display("Counter forced to 9,999,999");

        button1 = 1'b1;

        // Artificially set counter below threshold
        force dut.bc1.counter = 31'd9999999;

        @(posedge clock);

        // Release counter
        release dut.bc1.counter;

        // Release button
        button1 = 1'b0;

        repeat (2)
            @(posedge clock);

        $display("valid_vote_1 = %b",
                 dut.valid_vote_1);

        $display("C1 votes = %0d",
                 dut.cand1_vote_recvd);

    end
    endtask


    // =================================================
    // CANDIDATE 1 VOTE - VALID
    // =================================================

    task vote_candidate1;
    begin

        $display("Casting VALID vote for Candidate 1");

        button1 = 1'b1;

        // Valid threshold = 100,000,000
        // Force to one count before threshold
        force dut.bc1.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc1.counter;

        @(posedge clock);

        button1 = 1'b0;

        repeat (2)
            @(posedge clock);

        $display("valid_vote_1 = %b",
                 dut.valid_vote_1);

    end
    endtask


    // =================================================
    // CANDIDATE 2 VOTE - VALID
    // =================================================

    task vote_candidate2;
    begin

        $display("Casting VALID vote for Candidate 2");

        button2 = 1'b1;

        force dut.bc2.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc2.counter;

        @(posedge clock);

        button2 = 1'b0;

        repeat (2)
            @(posedge clock);

        $display("valid_vote_2 = %b",
                 dut.valid_vote_2);

    end
    endtask


    // =================================================
    // CANDIDATE 3 VOTE - VALID
    // =================================================

    task vote_candidate3;
    begin

        $display("Casting VALID vote for Candidate 3");

        button3 = 1'b1;

        force dut.bc3.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc3.counter;

        @(posedge clock);

        button3 = 1'b0;

        repeat (2)
            @(posedge clock);

        $display("valid_vote_3 = %b",
                 dut.valid_vote_3);

    end
    endtask


    // =================================================
    // CANDIDATE 4 VOTE - VALID
    // =================================================

    task vote_candidate4;
    begin

        $display("Casting VALID vote for Candidate 4");

        button4 = 1'b1;

        force dut.bc4.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc4.counter;

        @(posedge clock);

        button4 = 1'b0;

        repeat (2)
            @(posedge clock);

        $display("valid_vote_4 = %b",
                 dut.valid_vote_4);

    end
    endtask


    // =================================================
    // WAIT FOR LED INDICATION
    // =================================================

    task wait_for_led_off;
    begin

        $display("LED indication active...");

        force dut.MC.counter = 31'd99999999;

        @(posedge clock);

        release dut.MC.counter;

        @(posedge clock);

        @(posedge clock);

        $display("LED after indication = %h",
                 led);

    end
    endtask


    // =================================================
    // RESULT : CANDIDATE 1
    // =================================================

    task result_candidate1;
    begin

        $display("Selecting Candidate 1 result");

        button1 = 1'b1;

        force dut.bc1.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc1.counter;

        @(posedge clock);

        button1 = 1'b0;

        repeat (2)
            @(posedge clock);

    end
    endtask


    // =================================================
    // RESULT : CANDIDATE 2
    // =================================================

    task result_candidate2;
    begin

        $display("Selecting Candidate 2 result");

        button2 = 1'b1;

        force dut.bc2.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc2.counter;

        @(posedge clock);

        button2 = 1'b0;

        repeat (2)
            @(posedge clock);

    end
    endtask


    // =================================================
    // RESULT : CANDIDATE 3
    // =================================================

    task result_candidate3;
    begin

        $display("Selecting Candidate 3 result");

        button3 = 1'b1;

        force dut.bc3.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc3.counter;

        @(posedge clock);

        button3 = 1'b0;

        repeat (2)
            @(posedge clock);

    end
    endtask


    // =================================================
    // RESULT : CANDIDATE 4
    // =================================================

    task result_candidate4;
    begin

        $display("Selecting Candidate 4 result");

        button4 = 1'b1;

        force dut.bc4.counter = 31'd99999999;

        @(posedge clock);

        release dut.bc4.counter;

        @(posedge clock);

        button4 = 1'b0;

        repeat (2)
            @(posedge clock);

    end
    endtask


    // =================================================
    // WAVEFORM MONITOR
    // =================================================

    initial
    begin

        $monitor(
            "TIME=%0t | mode=%b | buttons=%b%b%b%b | ",
            $time,
            mode,
            button4,
            button3,
            button2,
            button1
        );

    end

endmodule

