library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_top_level is
    port(
        clk : in std_logic;
        rst : in std_logic;
        tx : out std_logic;
    );
end test_top_level;

architecture rtl of test_top_level is
        signal tdata : std_logic_vector(7 downto 0);
        signal tready : std_logic;
        signal tvalid : std_logic;
    begin
    uart_sender : entity work.uart_sender(rtl)
        port map(
            clk => clk,
            rst => rst,
            s_axi_s_tdata => tdata,
            s_axi_s_tvalid => tvalid,
            s_axi_s_tready => tready,
            tx => tx
        );
    
    test_uart : entity.test_uart(rtl)
        port map(
            clk => clk,
            rst => rst,
            m_axi_s_tdata => tdata,
            m_axi_s_tvalid => tvalid,
            m_axi_s_tready => tready
        );
end rtl;