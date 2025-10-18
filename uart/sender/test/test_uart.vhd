library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_uart is
    port(
        clk : in std_logic;
        rst : in std_logic;

        m_axi_s_tdata  : out std_logic_vector(7 downto 0);
        m_axi_s_tvalid : out std_logic;
        m_axi_s_tready : in std_logic
    );
end entity;

architecture rtl of test_uart is
    signal cnt : integer range 1 to 5 := 1;
begin

    process(clk, rst)
    begin
        if rst = '1' then
            cnt <= 1;
            m_axi_s_tdata  <= (others => '0');
            m_axi_s_tvalid <= '0';
        elsif rising_edge(clk) then
            if m_axi_s_tready = '1' then
                m_axi_s_tvalid <= '1';
                
                case cnt is
                    when 1 => m_axi_s_tdata <= X"74"; -- t
                    when 2 => m_axi_s_tdata <= X"65"; -- e
                    when 3 => m_axi_s_tdata <= X"73"; -- s
                    when 4 => m_axi_s_tdata <= X"74"; -- t
                    when 5 => m_axi_s_tdata <= X"0A"; -- \n
                    when others => m_axi_s_tdata <= X"00";
                end case;

                if cnt = 5 then
                    cnt <= 1; -- on repart sur 1 après le retour à la ligne
                else
                    cnt <= cnt + 1;
                end if;
            else
                -- Si le slave n'est pas prêt, on ne valide pas les données
                m_axi_s_tvalid <= '0';
            end if;
        end if;
    end process;

end rtl;
