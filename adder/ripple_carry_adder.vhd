library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ripple_carry_adder is
    generic(
        N_BITS : integer := 32
    );
    port(
        A : in std_logic_vector(N_BITS-1 downto 0);
        B: in std_logic_vector(N_BITS-1 downto 0);
        C_in : in std_logic;

        S : out std_logic_vector(N_BITS-1 downto 0);
        C_out : out std_logic
    );
end ripple_carry_adder;


architecture rtl of ripple_carry_adder is
    signal carry : std_logic_vector(N_BITS downto 0);
begin
    carry(0) <= C_in;
    gen_add : for i in 0 to N_BITS-1 generate
        FA_inst : entity work.full_adder
        port map (
            A     => A(i),
            B     => B(i),
            C_in  => carry(i),
            S     => S(i),
            C_out => carry(i+1)
        );
    end generate;
    C_out <= carry(N_BITS);
end rtl;
