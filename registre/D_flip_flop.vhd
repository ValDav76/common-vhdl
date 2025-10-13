library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity D_flip_flop is
    port (
        D     : in  std_logic;
        E     : in std_logic;
        clk   : in  std_logic;
        reset : in  std_logic;
        Q     : out std_logic
    );
end entity D_flip_flop;

architecture Behavioral of D_flip_flop is
    signal Q_reg : std_logic := '0';
begin
    process(clk, reset)
    begin
        if reset = '1' then
            Q_reg <= '0';
        elsif rising_edge(clk) then
            if e = '1' then
                Q_reg <= D;
            end if;
        end if;
    end process;
    Q <= Q_reg;
end architecture Behavioral;
