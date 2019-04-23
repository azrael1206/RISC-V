----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2018 14:27:17
-- Design Name: 
-- Module Name: register_mult - Behavioral
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

entity register_mult is
    Port (to_register : out std_logic_vector (32 - 1 downto 0);
          from_ram_io : in std_logic_vector (32 - 1 downto 0);
          from_alu : in std_logic_vector (32 - 1 downto 0);
          from_pc : in std_logic_vector (32 - 1 downto 0);
          selector : in std_logic_vector (2 - 1 downto 0);
          from_id : in std_logic_vector (32 - 1 downto 0)
          );
end register_mult;

architecture Behavioral of register_mult is
begin
    to_register <= from_alu when (selector = "00") else
               from_ram_io when (selector = "01") else 
               from_pc when (selector = "10") else
               from_id when (selector = "11") else
               (others => '0');


end Behavioral;
