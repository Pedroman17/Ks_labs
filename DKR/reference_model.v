module reference_model (
    input [3:0] R,
    input [3:0] S,
    input CI,
    input [1:0] I,
    output reg [3:0] ref_F_ALB,
    output reg ref_CO,
    output reg ref_VO,
    output reg ref_NO,
    output reg ref_ZO
);

    reg [4:0] temp_result;

    always @(*) begin
        case (I)
            2'b00: begin // S - R - 1 + CI
                temp_result = S - R - 1 + CI;
                ref_F_ALB = temp_result[3:0];
                ref_CO = temp_result[4];
                ref_VO = ((S[3] == R[3]) && (ref_F_ALB[3] != S[3])) ? 1 : 0;
                ref_NO = ref_F_ALB[3];
                ref_ZO = (ref_F_ALB == 4'b0);
            end
            2'b01: begin // S ? R
                ref_F_ALB = S | R;
                ref_CO = 1'b0;
                ref_VO = 1'b0;
                ref_NO = ref_F_ALB[3];
                ref_ZO = (ref_F_ALB == 4'b0);
            end
            2'b10: begin // S + R + CI
                temp_result = S + R + CI;
                ref_F_ALB = temp_result[3:0];
                ref_CO = temp_result[4];
                ref_VO = ((S[3] == R[3]) && (ref_F_ALB[3] != S[3])) ? 1 : 0;
                ref_NO = ref_F_ALB[3];
                ref_ZO = (ref_F_ALB == 4'b0);
            end
            2'b11: begin // not(S ? R)
                ref_F_ALB = ~(S ^ R);
                ref_CO = 1'b0;
                ref_VO = 1'b0;
                ref_NO = ref_F_ALB[3];
                ref_ZO = (ref_F_ALB == 4'b0);
            end
            default: begin
                ref_F_ALB = 4'b0;
                ref_CO = 1'b0;
                ref_VO = 1'b0;
                ref_NO = 1'b0;
                ref_ZO = 1'b0;
            end
        endcase
    end

endmodule
