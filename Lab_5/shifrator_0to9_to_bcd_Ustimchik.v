module shifrator_0to9_to_bcd(
    input [9:0] X,
    output reg [3:0] Y
);

always @ (X) begin
    case (X)
        10'b0000000001: Y = 4'b0000;
        10'b0000000010: Y = 4'b0001;
        10'b0000000100: Y = 4'b0010;
        10'b0000001000: Y = 4'b0011;
        10'b0000010000: Y = 4'b0100;
        10'b0000100000: Y = 4'b0101;
        10'b0001000000: Y = 4'b0110;
        10'b0010000000: Y = 4'b0111;
        10'b0100000000: Y = 4'b1000;
        10'b1000000000: Y = 4'b1001;
        default:        Y = 4'bxxxx;
    endcase
end

endmodule

