
module test_6r_sum;
    wire C1, C2;
    wire [5:0] Ain, Bin;
    reg  [5:0] Ain_r, Bin_r;
    reg        Ci_r;
    wire [5:0] res_my, res_ref;

    sum_6r     my_block  (Ain, Bin, Ci_r, res_my, C1);
    ref_6r_sum ref_block (Ain, Bin, Ci_r, res_ref, C2);

    initial begin
        $display("\tTime\tAin\tBin\tCi\tres_my\tC1\tres_ref\tC2");
        $monitor("%t\t%b\t%b\t%b\t%b\t%b\t%b\t%b",
                 $time, Ain, Bin, Ci_r, res_my, C1, res_ref, C2);
        #500 $finish;
    end

    initial begin
        Ain_r = 6'd5;
        #50 Ain_r = 6'd10;
        #50 Ain_r = 6'd20;
        #50 Ain_r = 6'd33;
        #50 Ain_r = 6'd15;
    end

    initial begin
        Bin_r = 6'd3;
        #100 Bin_r = 6'd12;
        #100 Bin_r = 6'd20;
    end

    initial begin
        Ci_r = 1'b0;
        #200 Ci_r = 1'b1;
    end

    assign Ain = Ain_r;
    assign Bin = Bin_r;

endmodule
