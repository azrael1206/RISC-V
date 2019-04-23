----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2018 15:55:51
-- Design Name: 
-- Module Name: Synchronizer - Behavioral
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

entity Synchronizer is
    port(clk : in std_logic;
         reset : in std_logic;
         async : in std_logic;
         sync : out std_logic);
end Synchronizer;

architecture TwoFF of Synchronizer is
    signal meta_reg , meta_next : std_logic;
    signal sync_reg , sync_next : std_logic;
begin
    process(clk , reset) -- Implementiere zwei Flip -Flops
        begin
            if (rising_edge(clk)) then
                if (reset = '1') then
                    meta_reg <= '0';
                    sync_reg <= '0';
                else
                    meta_reg <= meta_next;
                    sync_reg <= sync_next;
                end if;
            end if;
    end process;

    -- Next state logic
    meta_next <= async;
    sync_next <= meta_reg;
    
    -- Output logic
    sync <= sync_reg;
end architecture;

