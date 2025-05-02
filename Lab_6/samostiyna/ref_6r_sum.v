
module ref_6r_sum (Ain, Bin, Ci, Sout, Co);
    input  [5:0] Ain, Bin;
    input        Ci;
    output [5:0] Sout;
    output       Co;

    reg [6:0] S;

    always @(*) begin
        S = Ain + Bin + Ci;
    end

    assign Sout = S[5:0];
    assign Co   = S[6];
endmodule
