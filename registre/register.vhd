library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg is
    generic(
        N_BITS : integer := 32
    );
    port(
        clk     : in  std_logic;
        rst     : in  std_logic;
        e       : in  std_logic;
        d       : in  std_logic_vector(N_BITS-1 downto 0);
        q       : out std_logic_vector(N_BITS-1 downto 0)
    );
end reg;

architecture rtl of reg is
    component D_flip_flop
        port (
            D     : in  std_logic;
            E     : in std_logic;
            clk   : in  std_logic;
            reset : in  std_logic;
            Q     : out std_logic
        );
    end component;

    signal q_int : std_logic_vector(N_BITS-1 downto 0);
begin
    gen_reg : for i in 0 to N_BITS-1 generate
        U_DFF : D_flip_flop
            port map (
                D     => d(i),
                E     => e,
                clk   => clk,
                reset => rst,
                Q     => q_int(i)
            );
    end generate gen_reg;
    q <= q_int;
end rtl ;