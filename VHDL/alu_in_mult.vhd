----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.12.2017 14:28:09
-- Design Name: 
-- Module Name: io_mult - Behavioral
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


entity alu_in_mult is
	port(
	reg_in : in std_logic_vector(32-1 downto 0);
	imm_in : in std_logic_vector(32-1 downto 0);
	selector : in std_logic;
	data_out : out std_logic_vector(32-1 downto 0)
	);
end alu_in_mult;

architecture Behavorial of alu_in_mult is
begin
	data_out <= reg_in when (selector = '0') else
	            imm_in;
end architecture;
