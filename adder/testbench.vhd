library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity testbench is
end testbench;

architecture Behavioral of testbench is
    constant N_BITS : integer := 32;
    signal A : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal B : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal sel : std_logic := '0';
    signal S : std_logic_vector(N_BITS-1 downto 0) := (others => '0');
    signal C_out : std_logic := '0';

    component alu_addsub is
        generic(
            N_BITS : integer := 32
        ); 
        port(
            sel : std_logic; -- 0 : A ADD B ; 1 : A SUB B 
            A : in std_logic_vector(N_BITS-1 downto 0);
            B: in std_logic_vector(N_BITS-1 downto 0);
            S : out std_logic_vector(N_BITS-1 downto 0);
            C_out : out std_logic
        );
    end component;
begin

    UUT : alu_addsub
    port map(
        sel => sel,
        A => A,
        B => B,
        S => S,
        C_out => C_out
    );

    test : process
    begin
        wait for 10 ns;
        sel <= '0';
        A <= std_logic_vector(to_signed(56, A'length));
        B <= std_logic_vector(to_signed(44, B'length));
        wait for 10 ns;
        assert (S = std_logic_vector(to_signed(100, S'length)))
        report "Erreur : la somme est incorrecte"
        severity error;

        sel <= '1';
        A <= std_logic_vector(to_signed(56, A'length));
        B <= std_logic_vector(to_signed(69, B'length));
        wait for 10 ns;
        assert (S = std_logic_vector(to_signed(-13, S'length)))
        report "Erreur : la soustraction est incorrecte"
        severity error;
    end process;

end Behavioral;
