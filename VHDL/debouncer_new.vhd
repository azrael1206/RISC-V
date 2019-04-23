----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2018 13:40:39
-- Design Name: 
-- Module Name: debouncer_new - Behavioral
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
 
entity debouncer_new is
Port (
      data : in std_logic;
      clk : in std_logic;
      op_data : out std_logic
      );
end debouncer_new ;
 
architecture Behavioral of debouncer_new is
 
Signal op1, op2, op3: std_logic;
 
begin
 
    Process(CLK) 
    begin    
        If rising_edge(CLK) then        
            op1 <= data;
            op2 <= op1; 
            op3 <= op2;        
        end if;
    end process;
 
op_data <= op1 and op2 and op3;
 
end Behavioral;