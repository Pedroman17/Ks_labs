
module sum_1r (A, B, Cin, S, Cout);
    input A, B, Cin;
    output S, Cout;

    wire Res, c1, c2;

    xor (Res, A, B);
    and (c1, A, B);
    xor (S, Cin, Res);
    and (c2, Cin, Res);
    or  (Cout, c1, c2);
endmodule
