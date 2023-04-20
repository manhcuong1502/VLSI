library verilog;
use verilog.vl_types.all;
entity Flash_bounder is
    generic(
        IDLE            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        UP              : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        DOWN            : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        KICK_BACK       : vl_logic_vector(0 to 1) := (Hi1, Hi1);
        INIT            : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        ZERO_TO_FIVE    : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi0, Hi1, Hi0);
        OFF_TO_ZERO     : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi0, Hi1, Hi0, Hi0);
        ZERO_TO_TEN     : vl_logic_vector(0 to 5) := (Hi0, Hi0, Hi1, Hi0, Hi0, Hi0);
        OFF_TO_FOUR     : vl_logic_vector(0 to 5) := (Hi0, Hi1, Hi0, Hi0, Hi0, Hi0);
        FOUR_TO_FTEEN   : vl_logic_vector(0 to 5) := (Hi1, Hi0, Hi0, Hi0, Hi0, Hi0);
        SIZE            : integer := 6
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        flick           : in     vl_logic;
        LED             : out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of UP : constant is 1;
    attribute mti_svvh_generic_type of DOWN : constant is 1;
    attribute mti_svvh_generic_type of KICK_BACK : constant is 1;
    attribute mti_svvh_generic_type of INIT : constant is 1;
    attribute mti_svvh_generic_type of ZERO_TO_FIVE : constant is 1;
    attribute mti_svvh_generic_type of OFF_TO_ZERO : constant is 1;
    attribute mti_svvh_generic_type of ZERO_TO_TEN : constant is 1;
    attribute mti_svvh_generic_type of OFF_TO_FOUR : constant is 1;
    attribute mti_svvh_generic_type of FOUR_TO_FTEEN : constant is 1;
    attribute mti_svvh_generic_type of SIZE : constant is 1;
end Flash_bounder;
