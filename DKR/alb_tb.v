// Testbench for ALB with separate reference model based on Fig. 6.3
module alb_tb;

    // Inputs and Outputs to ALB
    reg clk;
    reg reset;
    reg [3:0] R_in, S_in;
    reg CI;
    reg [1:0] I;
    wire [3:0] F_ALB;
    wire CO, VO, NO, ZO;

    // Outputs from Reference Model
    wire [3:0] ref_F_ALB;
    wire ref_CO, ref_VO, ref_NO, ref_ZO;

    // Instantiate ALB (Operation Device)
    alb uut (
        .clk(clk),
        .reset(reset),
        .R_in(R_in),
        .S_in(S_in),
        .CI(CI),
        .I(I),
        .F_ALB(F_ALB),
        .CO(CO),
        .VO(VO),
        .NO(NO),
        .ZO(ZO)
    );

    // Instantiate Reference Model
    reference_model ref_model (
        .R(R_in),
        .S(S_in),
        .CI(CI),
        .I(I),
        .ref_F_ALB(ref_F_ALB),
        .ref_CO(ref_CO),
        .ref_VO(ref_VO),
        .ref_NO(ref_NO),
        .ref_ZO(ref_ZO)
    );

    // Clock generation (Top Level)
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100 MHz clock
    end

    // Stimulus and Test Logic (Control Device and Stimulus Block)
    initial begin
        // Initialize
        reset = 1;
        R_in = 4'b0;
        S_in = 4'b0;
        CI = 0;
        I = 2'b0;
        #10;
        reset = 0;

        // Test 1: S - R - 1 + CI (I = 00)
        R_in = 4'b0010; // R = 2
        S_in = 4'b0100; // S = 4
        CI = 1;
        I = 2'b00;
        #20;
        $display("\n--- Test 1: S - R - 1 + CI ---");
        $display("Applied Inputs: I=%b, R=%h, S=%h, CI=%b", I, R_in, S_in, CI);
        $display("ALB Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", F_ALB, CO, VO, NO, ZO);
        $display("Ref Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", ref_F_ALB, ref_CO, ref_VO, ref_NO, ref_ZO);
        if (F_ALB !== ref_F_ALB || CO !== ref_CO || VO !== ref_VO || NO !== ref_NO || ZO !== ref_ZO) begin
            $display("ERROR: Mismatch detected!");
            if (F_ALB !== ref_F_ALB) $display("  F_ALB mismatch: Expected %h, Got %h", ref_F_ALB, F_ALB);
            if (CO !== ref_CO) $display("  CO mismatch: Expected %b, Got %b", ref_CO, CO);
            if (VO !== ref_VO) $display("  VO mismatch: Expected %b, Got %b", ref_VO, VO);
            if (NO !== ref_NO) $display("  NO mismatch: Expected %b, Got %b", ref_NO, NO);
            if (ZO !== ref_ZO) $display("  ZO mismatch: Expected %b, Got %b", ref_ZO, ZO);
        end else begin
            $display("PASS: All outputs match.");
        end

        // Test 2: S ? R (I = 01)
        R_in = 4'b1010; // R = 10
        S_in = 4'b1100; // S = 12
        CI = 0;
        I = 2'b01;
        #20;
        $display("\n--- Test 2: S ? R ---");
        $display("Applied Inputs: I=%b, R=%h, S=%h, CI=%b", I, R_in, S_in, CI);
        $display("ALB Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", F_ALB, CO, VO, NO, ZO);
        $display("Ref Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", ref_F_ALB, ref_CO, ref_VO, ref_NO, ref_ZO);
        if (F_ALB !== ref_F_ALB || CO !== ref_CO || VO !== ref_VO || NO !== ref_NO || ZO !== ref_ZO) begin
            $display("ERROR: Mismatch detected!");
            if (F_ALB !== ref_F_ALB) $display("  F_ALB mismatch: Expected %h, Got %h", ref_F_ALB, F_ALB);
            if (CO !== ref_CO) $display("  CO mismatch: Expected %b, Got %b", ref_CO, CO);
            if (VO !== ref_VO) $display("  VO mismatch: Expected %b, Got %b", ref_VO, VO);
            if (NO !== ref_NO) $display("  NO mismatch: Expected %b, Got %b", ref_NO, NO);
            if (ZO !== ref_ZO) $display("  ZO mismatch: Expected %b, Got %b", ref_ZO, ZO);
        end else begin
            $display("PASS: All outputs match.");
        end

        // Test 3: S + R + CI (I = 10)
        R_in = 4'b0011; // R = 3
        S_in = 4'b0010; // S = 2
        CI = 0;
        I = 2'b10;
        #20;
        $display("\n--- Test 3: S + R + CI ---");
        $display("Applied Inputs: I=%b, R=%h, S=%h, CI=%b", I, R_in, S_in, CI);
        $display("ALB Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", F_ALB, CO, VO, NO, ZO);
        $display("Ref Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", ref_F_ALB, ref_CO, ref_VO, ref_NO, ref_ZO);
        if (F_ALB !== ref_F_ALB || CO !== ref_CO || VO !== ref_VO || NO !== ref_NO || ZO !== ref_ZO) begin
            $display("ERROR: Mismatch detected!");
            if (F_ALB !== ref_F_ALB) $display("  F_ALB mismatch: Expected %h, Got %h", ref_F_ALB, F_ALB);
            if (CO !== ref_CO) $display("  CO mismatch: Expected %b, Got %b", ref_CO, CO);
            if (VO !== ref_VO) $display("  VO mismatch: Expected %b, Got %b", ref_VO, VO);
            if (NO !== ref_NO) $display("  NO mismatch: Expected %b, Got %b", ref_NO, NO);
            if (ZO !== ref_ZO) $display("  ZO mismatch: Expected %b, Got %b", ref_ZO, ZO);
        end else begin
            $display("PASS: All outputs match.");
        end

        // Test 4: not(S ? R) (I = 11)
        R_in = 4'b1010; // R = 10
        S_in = 4'b1100; // S = 12
        CI = 0;
        I = 2'b11;
        #20;
        $display("\n--- Test 4: not(S ? R) ---");
        $display("Applied Inputs: I=%b, R=%h, S=%h, CI=%b", I, R_in, S_in, CI);
        $display("ALB Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", F_ALB, CO, VO, NO, ZO);
        $display("Ref Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", ref_F_ALB, ref_CO, ref_VO, ref_NO, ref_ZO);
        if (F_ALB !== ref_F_ALB || CO !== ref_CO || VO !== ref_VO || NO !== ref_NO || ZO !== ref_ZO) begin
            $display("ERROR: Mismatch detected!");
            if (F_ALB !== ref_F_ALB) $display("  F_ALB mismatch: Expected %h, Got %h", ref_F_ALB, F_ALB);
            if (CO !== ref_CO) $display("  CO mismatch: Expected %b, Got %b", ref_CO, CO);
            if (VO !== ref_VO) $display("  VO mismatch: Expected %b, Got %b", ref_VO, VO);
            if (NO !== ref_NO) $display("  NO mismatch: Expected %b, Got %b", ref_NO, NO);
            if (ZO !== ref_ZO) $display("  ZO mismatch: Expected %b, Got %b", ref_ZO, ZO);
        end else begin
            $display("PASS: All outputs match.");
        end

        // Test 5: Zero result (S - R - 1 + CI) (I = 00)
        R_in = 4'b0001; // R = 1
        S_in = 4'b0001; // S = 1
        CI = 0;
        I = 2'b00;
        #20;
        $display("\n--- Test 5: Zero result (S - R - 1 + CI) ---");
        $display("Applied Inputs: I=%b, R=%h, S=%h, CI=%b", I, R_in, S_in, CI);
        $display("ALB Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", F_ALB, CO, VO, NO, ZO);
        $display("Ref Outputs: F_ALB=%h, CO=%b, VO=%b, NO=%b, ZO=%b", ref_F_ALB, ref_CO, ref_VO, ref_NO, ref_ZO);
        if (F_ALB !== ref_F_ALB || CO !== ref_CO || VO !== ref_VO || NO !== ref_NO || ZO !== ref_ZO) begin
            $display("ERROR: Mismatch detected!");
            if (F_ALB !== ref_F_ALB) $display("  F_ALB mismatch: Expected %h, Got %h", ref_F_ALB, F_ALB);
            if (CO !== ref_CO) $display("  CO mismatch: Expected %b, Got %b", ref_CO, CO);
            if (VO !== ref_VO) $display("  VO mismatch: Expected %b, Got %b", ref_VO, VO);
            if (NO !== ref_NO) $display("  NO mismatch: Expected %b, Got %b", ref_NO, NO);
            if (ZO !== ref_ZO) $display("  ZO mismatch: Expected %b, Got %b", ref_ZO, ZO);
        end else begin
            $display("PASS: All outputs match.");
        end

        $display("\nSimulation completed.");
        $finish;
    end

endmodule
