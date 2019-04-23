----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2018 10:54:45
-- Design Name: 
-- Module Name: branch_auto - Behavioral
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

entity branch_auto is
  Port (
        reset : in std_logic;
        set_adress : in std_logic;
        clk : in std_logic;
        mk_nop : out std_logic
        );
end branch_auto;

architecture Behavioral of branch_auto is
    type state is (running, jumping);
    signal state_reg : state;
    signal state_next : state;
begin

    transition : process (reset, clk, set_adress)
    begin
        if(reset = '1') then
            state_reg <= running;
        elsif (rising_edge(clk) AND ((set_adress = '1' AND state_reg = running) OR  (state_reg = jumping))) then
            state_reg <= state_next;
        end if;
    end process;
    
    next_state_proc : process(state_reg, set_adress)
    begin
    
        --Set default values
        state_next <= state_reg;
        mk_nop <= '0';
            
        case state_reg is
            
            -- Handle state 'running'
            when running =>
                state_next <= jumping;
                mk_nop <= '0';
                    
            -- Handle state 'jumping'
            when jumping =>
                state_next <= running;
                mk_nop <= '1';
                    
        end case;
    end process;

end Behavioral;
