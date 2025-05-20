library verilog;
use verilog.vl_types.all;
entity reference_model is
    port(
        R               : in     vl_logic_vector(3 downto 0);
        S               : in     vl_logic_vector(3 downto 0);
        CI              : in     vl_logic;
        I               : in     vl_logic_vector(1 downto 0);
        ref_F_ALB       : out    vl_logic_vector(3 downto 0);
        ref_CO          : out    vl_logic;
        ref_VO          : out    vl_logic;
        ref_NO          : out    vl_logic;
        ref_ZO          : out    vl_logic
    );
end reference_model;
