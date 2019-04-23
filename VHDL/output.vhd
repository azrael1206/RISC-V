----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2018 16:17:14
-- Design Name: 
-- Module Name: output - Behavioral
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

entity output is
  Port (clk : in std_logic;
        reset : in std_logic;
        write : in std_logic;
        data_in : in std_logic_vector (16 - 1 downto 0);
        data_out : out std_logic_vector (16 - 1 downto 0));
end output;

architecture Behavioral of output is

begin
    process (clk)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                data_out <= (others => '1');
            else if (write = '1') then
                    data_out <= data_in;
                 end if;
            end if;
        end if;
    end process;
end Behavioral;
