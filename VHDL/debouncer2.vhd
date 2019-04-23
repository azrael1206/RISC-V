----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.01.2018 13:19:31
-- Design Name: 
-- Module Name: debouncer2 - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer2 is
  Port (clk : in std_logic;
        reset : in std_logic;
        sw : in std_logic_vector(16 - 1 downto 0);
        db : out std_logic_vector(16 - 1 downto 0)
         );
end debouncer2;

architecture arch of debouncer2 is
    constant N: integer:= 19;
    signal q_reg, q_next: unsigned (N-1 downto 0);
    signal m_tick: std_logic;
    type eg_state_type is (zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3);
    signal state_reg, state_next: eg_state_type;
begin
    process (clk, reset)
    begin
        if (rising_edge(clk)) then
            q_reg <= q_next;
        end if;
     end process;
     
     q_next <= q_reg + 1;
     
     m_tick <= '1' when q_reg = 0 else
               '0';
               
     process (clk, reset)
     begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                state_reg <= zero;
            else
                state_reg <= state_next;
             end if;
         end if;
     end process;
     
     process (state_reg, sw, m_tick)
     begin
        state_next <= state_reg;
        db <= (others => '0');
        
        case state_reg is
            when zero =>
                if (sw = '1') then
                    state_next <= wait1_1;
                end if;
            when wait1_1
end arch;
