library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity full_adder is
    port(
        A : in std_logic;
        B : in std_logic;
        C_in : in std_logic;
        
        S : out std_logic;
        C_out : out std_logic
    );
end full_adder;

architecture rtl of full_adder is
begin
    S      <= A xor B xor C_in;
    C_out  <= (A and B) or (C_in and (A xor B));
end rtl;
