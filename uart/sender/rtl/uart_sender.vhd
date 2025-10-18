library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity uart_sender is
    generic (
        BAUD_DIV : integer := 104
    );
    port (
        clk     : in  std_logic;
        rst     : in  std_logic;

        s_axi_s_tdata  : in  std_logic_vector(7 downto 0);
        s_axi_s_tvalid : in  std_logic;
        s_axi_s_tready : out std_logic;

        tx : out std_logic
    );
end uart_sender;

architecture rtl of uart_sender is
    type state_t is (IDLE, START, DATA, STOP);
    signal state : state_t := IDLE;

    signal baud_cnt  : integer range 0 to BAUD_DIV-1 := 0;
    signal bit_cnt   : integer range 0 to 7 := 0;

    signal data_reg  : std_logic_vector(7 downto 0) := (others => '0');
    signal tx_reg    : std_logic := '1';
    signal ready_reg : std_logic := '1';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state     <= IDLE;
            baud_cnt  <= 0;
            bit_cnt   <= 0;
            tx_reg    <= '1';
            ready_reg <= '1';

        elsif rising_edge(clk) then
            case state is

                when IDLE =>
                    tx_reg <= '1';
                    ready_reg <= '1';
                    if s_axi_s_tvalid = '1' then
                        data_reg <= s_axi_s_tdata;
                        state <= START;
                        ready_reg <= '0';
                        baud_cnt <= 0;
                    end if;

                when START =>
                    tx_reg <= '0'; -- start bit
                    if baud_cnt = BAUD_DIV-1 then
                        baud_cnt <= 0;
                        state <= DATA;
                        bit_cnt <= 0;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when DATA =>
                    tx_reg <= data_reg(0);
                    if baud_cnt = BAUD_DIV-1 then
                        baud_cnt <= 0;
                        data_reg <= '0' & data_reg(7 downto 1);
                        if bit_cnt = 7 then
                            state <= STOP;
                        else
                            bit_cnt <= bit_cnt + 1;
                        end if;
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

                when STOP =>
                    tx_reg <= '1';
                    if baud_cnt = BAUD_DIV-1 then
                        baud_cnt <= 0;
                        state <= IDLE;
                        ready_reg <= '1';
                    else
                        baud_cnt <= baud_cnt + 1;
                    end if;

            end case;
        end if;
    end process;

    tx <= tx_reg;
    s_axi_s_tready <= ready_reg;
end rtl;
