library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_addsub is
    generic(
        N_BITS : integer := 32
    );
    port(
        sel : std_logic; -- 0 : A ADD B ; 1 : A SUB B 
        A : in std_logic_vector(N_BITS-1 downto 0);
        B : in std_logic_vector(N_BITS-1 downto 0);
        S : out std_logic_vector(N_BITS-1 downto 0);
        C_out : out std_logic
    );
end alu_addsub;

architecture rtl of alu_addsub is
    signal Bp : std_logic_vector(N_BITS-1 downto 0);
begin
    gen_xor: for i in B'range generate
        Bp(i) <= B(i) xor sel; -- if sel = 1, then all the bit of B are inverted
    end generate; 
    RCA_inst :  entity work.ripple_carry_adder
    port map(
        A => A,
        B => Bp,
        C_in => sel, -- if sel = 1, we need to add 1 to B to have 2 complement of B
        S => S,
        C_out => C_out
    );
end rtl;

