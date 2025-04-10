module f4_1(x1, x2, x3, f_1);
 input x1,x2,x3;
 output f_1;
 assign f_1 = ~((~x1 & x3) | (x3 & x2) | (x2 & ~x1) | (~x3 & ~x2 & x1));
endmodule


module f4(x1, x2, x3, f);
 input x1, x2, x3;
 output f;
 assign f = ~(~(x1 & x2 & ~x3) & ~(x1 & ~x2 & x3) & ~(~x1 & ~x2 & ~x3));
endmodule