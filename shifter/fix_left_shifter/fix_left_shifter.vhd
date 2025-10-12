library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fix_left_shifter is
    generic(
        N_BITS : integer := 32;
        N_SHIFT : integer :=2
    );
    port(
        E : in std_logic_vector(N_BITS-1 downto 0);
        S : out std_logic_vector(N_BITS-1 downto 0)
    );
end fix_left_shifter;

architecture rtl of fix_left_shifter is
begin
    S <= E(N_BITS-1-N_SHIFT downto 0) & (N_SHIFT-1 downto 0 => '0');
end rtl ;
