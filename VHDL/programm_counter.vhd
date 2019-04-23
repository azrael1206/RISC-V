----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2017 10:32:51
-- Design Name: 
-- Module Name: programm_counter - Behavioral
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

entity programm_counter is
    Port (
        clk : in std_logic;
        inst_out_adress : out std_logic_vector (16 - 1 downto 0);
        inst_in_adress : in std_logic_vector (16 - 1 downto 0);
        set_adress : in std_logic;
        reset : in std_logic;
        stop_cpu : in std_logic
    );
end programm_counter;

architecture Behavioral of programm_counter is
    signal cnt_reg : std_logic_vector (16 - 1 downto 0);
    signal cnt_next : std_logic_vector (16 - 1 downto 0);
begin
    
    process (clk)
    begin
         if(rising_edge(clk)) then
            if (reset = '1') then
                cnt_reg <= (others => '0');
            elsif (set_adress = '1') then
                cnt_reg <= inst_in_adress;
            else
                cnt_reg <= cnt_next ;
            end if;
          end if;
     end process;
    
     cnt_next <= std_logic_vector (unsigned (cnt_reg) + 4) when stop_cpu = '0' else
                 cnt_reg;
        
     inst_out_adress <= cnt_reg;
end Behavioral;
