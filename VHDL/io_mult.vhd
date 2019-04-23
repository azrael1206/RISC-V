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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity io_mult is
  Port (
        io_rw : in std_logic;
        write : out std_logic;
        io_adress : in std_logic;
        io_to_data : in std_logic_vector (16 - 1 downto 0);
        io_from_data : out std_logic_vector (21 - 1 downto 0);
        data_io_0 : out std_logic_vector (16 - 1 downto 0);
        data_io_1 : in std_logic_vector (21 - 1 downto 0)
        );
end io_mult;

architecture Behavioral of io_mult is

begin
        write <= io_rw;
        data_io_0 <= io_to_data(16 - 1 downto 0) when (io_adress = '0') else
                     (others => '0');
        io_from_data <= std_logic_vector(resize(unsigned(data_io_1), io_from_data'length)) when (io_adress = '1') else
                        (others => '0');
end Behavioral;
