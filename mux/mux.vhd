library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is
    generic(
        N_BITS : integer := 32
    );
    port(
        sel  : in  std_logic_vector(1 downto 0);
        din_1  : in  std_logic_vector(N_BITS-1 downto 0);
        din_2  : in  std_logic_vector(N_BITS-1 downto 0);
        din_3  : in  std_logic_vector(N_BITS-1 downto 0);
        din_4  : in  std_logic_vector(N_BITS-1 downto 0);
        dout : out std_logic_vector(N_BITS-1 downto 0)
    );
end mux;

architecture rtl of mux is 
begin
    dout <= din_1 when sel = "00" else
              din_2 when sel = "01" else
              din_3 when sel = "10" else
              din_4;
end rtl;

