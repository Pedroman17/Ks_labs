
module sum_6r (Ain, Bin, Ci, Sout, Co);
    input  [5:0] Ain, Bin;
    input        Ci;
    output [5:0] Sout;
    output       Co;

    wire [5:0] C;

    sum_1r sum1 (Ain[0], Bin[0], Ci,     Sout[0], C[0]);
    sum_1r sum2 (Ain[1], Bin[1], C[0],   Sout[1], C[1]);
    sum_1r sum3 (Ain[2], Bin[2], C[1],   Sout[2], C[2]);
    sum_1r sum4 (Ain[3], Bin[3], C[2],   Sout[3], C[3]);
    sum_1r sum5 (Ain[4], Bin[4], C[3],   Sout[4], C[4]);
    sum_1r sum6 (Ain[5], Bin[5], C[4],   Sout[5], C[5]);

    assign Co = C[5];
endmodule
