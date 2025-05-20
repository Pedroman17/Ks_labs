library verilog;
use verilog.vl_types.all;
entity alb is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        R_in            : in     vl_logic_vector(3 downto 0);
        S_in            : in     vl_logic_vector(3 downto 0);
        CI              : in     vl_logic;
        I               : in     vl_logic_vector(1 downto 0);
        F_ALB           : out    vl_logic_vector(3 downto 0);
        CO              : out    vl_logic;
        VO              : out    vl_logic;
        NO              : out    vl_logic;
        ZO              : out    vl_logic
    );
end alb;
