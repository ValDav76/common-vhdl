library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture sim of testbench is
    constant N_BITS : integer := 8;
    signal clk      : std_logic := '0';
    signal rst      : std_logic := '0';
    signal e        : std_logic := '0';
    signal d        : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal q        : std_logic_vector(N_BITS-1 downto 0);
    
    component reg
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
    end component;

    constant clk_period : time := 10 ns;

    procedure wait_cycles(cycles : natural) is
    begin
        for i in 1 to cycles loop
            wait until falling_edge(clk);
        end loop;
    end procedure; 
begin
    uut : reg
        generic map(
            N_BITS => N_BITS
        )
        port map(
            clk => clk,
            rst => rst,
            e   => e,
            d   => d,
            q   => q
        );
    gen_clk : process
    constant NB_CYCLES : integer := 20;
    begin
        for i in 1 to NB_CYCLES loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;  -- stop le process après les cycles
    end process gen_clk;

    test : process
    begin
        wait_cycles(5);
        rst <= '1';
        wait_cycles(1);
        rst <= '0';
        wait_cycles(2);

        d <= std_logic_vector(to_unsigned(15, d'length)); -- 00001111
        e <= '1'; 
        wait_cycles(1);
        e <= '0';
        d <= (others => '0');
        wait_cycles(3);
        assert q = std_logic_vector(to_unsigned(15, q'length))
        report "Test 1 failed" severity error;

        d <= std_logic_vector(to_unsigned(42, d'length));-- 11110000
        e <= '1';
        wait_cycles(1);
        e <= '0';
        d <= (others => '0');
        wait_cycles(3);
        assert q = std_logic_vector(to_unsigned(42, q'length))
        report "Test 2 failed" severity error;
        wait_cycles(2);

    end process;
end architecture sim;
