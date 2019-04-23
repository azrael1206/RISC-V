----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2017 17:57:59
-- Design Name: 
-- Module Name: ram_io_mult - Behavioral
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
use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ram_io_mult is
Port (r_w : in std_logic; -- 0 read 1 write
      r_w_ram : out std_logic; -- Write bit for RAM
      r_w_io : out std_logic; -- Write bit for IO
      offset : in std_logic_vector (12 - 1 downto 0); --Offset
      width : in std_logic_vector (3 -1 downto 0); --witch modus
      from_register_adress : in std_logic_vector (32 - 1 downto 0); --adress from Register
      from_register_data : in std_logic_vector (32 - 1 downto 0); --data from Register
      to_ram_adress : out std_logic_vector (14 - 1 downto 0); --adress Ram
      to_ram_data : out std_logic_vector (32 - 1 downto 0); --Data to ram
      from_ram_data: in std_logic_vector (32 - 1 downto 0); -- data from Ram
      to_register_data: out std_logic_vector (32 - 1 downto 0); --data to register
      to_io_adress : out std_logic; --adress IO
      to_io_data : out std_logic_vector (16 - 1 downto 0); --data to IO
      from_io_data : in std_logic_vector (21 - 1 downto 0); --data from IO
      to_display : out std_logic_vector (32 - 1 downto 0);
      to_display_data: out std_logic_vector (32 - 1 downto 0)
      );
end ram_io_mult;

architecture Behavioral of ram_io_mult is
signal new_adress : std_logic_vector (33 - 1 downto 0);
--signal resized_offset : std_logic_vector (14 - 1 downto 0);                 
    
begin

    new_adress <= unsigned(from_register_adress(32 - 1 downto 0)) + signed(offset);
    to_io_adress <= new_adress(0);
    to_ram_adress <= new_adress (16 - 1 downto 2);
    r_w_ram <= r_w when (from_register_adress(32 - 1 downto 16) = "0000000000000000") else '0';
    r_w_io <= r_w when (from_register_adress(32 - 1 downto 16) = "1000000000000000") else '0';
    
    
    to_register_data <= "00000000000" & from_io_data when (r_w = '0' AND from_register_adress(31) = '1' AND width = "010") else                                                 --LW     IO
                        "0000000000000000" & from_io_data(16 - 1 downto 0) when (r_w = '0' AND from_register_adress(31) = '1' AND (width = "001" OR width = "101")) else        --LH/LHU IO
                        "000000000000000000000000" & from_io_data(8 - 1 downto 0) when (r_w = '0' AND from_register_adress(31) = '1' AND (width = "000" OR width = "100")) else --LB/LBU IO
                        from_ram_data when (width = "010") else                                                                                                                 --LW
                        "1111111111111111" & from_ram_data(16 - 1 downto 0)  when (width = "001" AND from_ram_data(31) = '1') else                                              --LH
                        "0000000000000000" & from_ram_data(16 - 1 downto 0) when ((width = "001" AND from_ram_data(31) = '0') OR width = "101") else                            --LH/LHU
                        "111111111111111111111111" & from_ram_data(8 - 1 downto 0) when (width = "000" AND from_ram_data(23) = '1') else                                        --LB
                        "000000000000000000000000" & from_ram_data(8 - 1 downto 0) when ((width = "000" AND from_ram_data(23) = '0') OR width = "100") else                     --LB/LBU
                        (others => '0');
             
    to_io_data <= from_register_data (16 - 1 downto 0);
    to_display_data <= from_register_data;
    to_ram_data <= from_register_data(32 - 1 downto 0)  when (width = "010") else                               --SW
                   "0000000000000000" & from_register_data(16 - 1 downto 0)  when (width = "001") else          --SH
                   "000000000000000000000000" & from_register_data(8 - 1 downto 0)  when (width = "000") else   --SB
                   (others => '0');
    to_display <= from_register_adress when (from_register_adress (32 - 1 downto 16) = "1111111111111111") else 
                  (others => '0');
                  


end Behavioral;
