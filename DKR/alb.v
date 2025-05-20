// Arithmetic-Logic Block (ALB) with specified micro-operations
module alb (
    input wire clk,              // Clock for input registers
    input wire reset,            // Synchronous reset
    input wire [3:0] R_in,       // Input operand R
    input wire [3:0] S_in,       // Input operand S
    input wire CI,               // Carry-in
    input wire [1:0] I,          // Control input (I4, I3)
    output reg [3:0] F_ALB,      // Result output
    output wire CO,              // Carry out
    output wire VO,              // Overflow
    output wire NO,              // Negative flag
    output wire ZO               // Zero flag
);

    // Input buffer registers
    reg [3:0] R_reg, S_reg;
    reg CI_reg;
    reg [1:0] I_reg;

    // Internal signals for operations
    wire [3:0] sum_result, sub_result, or_result, xnor_result;
    wire sum_co, sub_co, sum_vo, sub_vo;

    // Input registers
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            R_reg <= 4'b0;
            S_reg <= 4'b0;
            CI_reg <= 1'b0;
            I_reg <= 2'b0;
        end else begin
            R_reg <= R_in;
            S_reg <= S_in;
            CI_reg <= CI;
            I_reg <= I;
        end
    end

    // Arithmetic operations (4-bit adder/subtractor)
    assign {sum_co, sum_result} = S_reg + R_reg + CI_reg; // S + R + CI
    assign {sub_co, sub_result} = S_reg - R_reg - 1 + CI_reg; // S - R - 1 + CI

    // Logical operations
    assign or_result = S_reg | R_reg; // S ? R
    assign xnor_result = ~(S_reg ^ R_reg); // not(S ? R) = S ? R

    // Overflow calculation (for arithmetic operations)
    wire sum_msb_cin, sum_msb_cout, sub_msb_cin, sub_msb_cout;
    assign sum_msb_cin = (S_reg[2] + R_reg[2] + CI_reg >= 2) ? 1 : 0;
    assign sum_msb_cout = (sum_result[3] >= 2) ? 1 : 0;
    assign sum_vo = sum_msb_cin ^ sum_msb_cout;

    assign sub_msb_cin = (S_reg[2] - R_reg[2] - 1 + CI_reg >= 2) ? 1 : 0;
    assign sub_msb_cout = (sub_result[3] >= 2) ? 1 : 0;
    assign sub_vo = sub_msb_cin ^ sub_msb_cout;

    // Multiplexer for result selection
    always @(*) begin
        case (I_reg)
            2'b00: F_ALB = sub_result; // S - R - 1 + CI
            2'b01: F_ALB = or_result;  // S ? R
            2'b10: F_ALB = sum_result; // S + R + CI
            2'b11: F_ALB = xnor_result; // not(S ? R)
            default: F_ALB = 4'b0;
        endcase
    end

    // Flag generation
    assign CO = (I_reg == 2'b00) ? sub_co : (I_reg == 2'b10) ? sum_co : 1'b0;
    assign VO = (I_reg == 2'b00) ? sub_vo : (I_reg == 2'b10) ? sum_vo : 1'b0;
    assign NO = F_ALB[3]; // MSB indicates sign
    assign ZO = (F_ALB == 4'b0); // Zero flag

endmodule
