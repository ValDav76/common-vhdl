library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture Behavioral of testbench is
    constant N_BITS : integer := 32;
    signal E : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal S : std_logic_vector(N_BITS-1 downto 0) := (others => '0');

    component fix_left_shifter is
    generic(
        N_BITS : integer := 32;
        N_SHIFT : integer :=2
    );
    port(
        E : in std_logic_vector(N_BITS-1 downto 0);
        S : out std_logic_vector(N_BITS-1 downto 0)
    );
    end component;

begin
    UUT : fix_left_shifter
    port map(
        E => E,
        S => S
    );
    
    test : process
    begin
        E <= X"45B73124";
        wait for 10 ns;
    end process;
end Behavioral;