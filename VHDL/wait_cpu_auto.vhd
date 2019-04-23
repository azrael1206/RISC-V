----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.02.2018 10:55:09
-- Design Name: 
-- Module Name: wait_cpu_auto - Behavioral
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

entity wait_cpu_auto is
  Port (
        clk   : in  std_logic;
        reset : in  std_logic;
        data  : in  std_logic;
        sleep : out std_logic
        );
end wait_cpu_auto;

architecture Behavioral of wait_cpu_auto is
    type state is (running, sleeping);
    signal state_reg  : state;
    signal state_next : state;
begin

    transition : process (reset, clk, data)
    begin
        if(reset = '1') then
            state_reg <= running;
        elsif (falling_edge(clk) AND ((data = '1'AND state_reg = running) OR state_reg = sleeping)) then
            state_reg <= state_next;
        end if;
    end process;
    
    next_state_proc : process(state_reg, data)
    begin
        --Set default values
        state_next <= state_reg;
        sleep <= '0';
        
        case state_reg is
        
            -- Handle state 'running'
            when running =>
                state_next <= sleeping;
                sleep <= '0';
                
            -- Handle state 'sleeping'
            when sleeping =>
                state_next <= running;
                sleep <= '1';
                
        end case;
    end process;
end Behavioral;
