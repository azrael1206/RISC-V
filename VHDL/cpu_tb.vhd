----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2018 14:31:03
-- Design Name: 
-- Module Name: cpu_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cpu_tb is
--  Port ( );
end cpu_tb;

architecture Behavioral of cpu_tb is
    constant T: time := 10 ns;
    signal clk100Mhz : std_logic;
    signal reset : std_logic;
    signal switch : std_logic_vector (21 - 1 downto 0);
    signal led : std_logic_vector (16 - 1 downto 0);
    --signal jump : std_logic_vector (14 - 1 downto 0);
    signal rgb : std_logic_vector (12 - 1 downto 0);
    signal hsync : std_logic;
    signal vsync : std_logic;
    --signal clk1 : std_logic;
    --signal clk2 : std_logic;
begin
    cpu_test : entity work.cpu(Structual)
               port map (clk100Mhz => clk100Mhz,
                         reset => reset,
                         switch => switch,
                         led => led,
      --                   jump => jump,
                         rgb => rgb,
                         vsync => vsync,
                         hsync => hsync
                        -- clk2out => clk2,
                         --clk1out => clk1
                         );
    process
    begin
        clk100Mhz <= '0';
        wait for T/2;
        clk100Mhz <= '1';
        wait for T/2;
    end process;
    
    reset <= '0', '1' after 2*T;
    switch <= "000000000010000000000", "000000000000000000000" after 40*T, "000000000010000000000" after 80*T;
end Behavioral;
