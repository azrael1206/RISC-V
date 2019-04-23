----------------------------------------------------------------------------------
-- Company: UNSC
-- Engineer: Master Chief
-- 
-- Create Date: 10.11.2017 14:56:29
-- Design Name: Cortana 1.0
-- Module Name: registerfile - Behavioral
-- Project Name: riscv
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

entity registerfile is
--  Port ( );

    generic(wordSize : integer := 32; -- number of bits in a register
            adrSize  : integer := 5); -- number of address bits
            
    port(clk : in std_logic;
    
         writeEnable : in std_logic;
         
         wAdr  : in std_logic_vector(adrSize  - 1 downto 0);
         wData : in std_logic_vector(wordSize - 1 downto 0);
         rAdr_1 : in std_logic_vector(adrSize - 1 downto 0);
         rAdr_2 : in std_logic_vector(adrSize - 1 downto 0);
         rData_1 : out std_logic_vector(wordSize - 1 downto 0);
         rData_2 : out std_logic_vector(wordSize - 1 downto 0));
            
end registerfile;

architecture Behavioral of registerfile is

    type regFile_t is array (2**adrSize - 1 downto 0) of std_logic_vector(wordSize - 1 downto 0);
    
    signal regFile : regFile_t := (others => (others => '0'));

begin
    rData_1 <= (others => '0') when (rAdr_1 = "00000") else regFile(to_integer(unsigned(rAdr_1)));
    rData_2 <= (others => '0') when (rAdr_2 = "00000") else regFile(to_integer(unsigned(rAdr_2)));
    process (clk)
    begin
        if(rising_edge(clk)) then
            if (writeEnable = '1') then
                regFile(to_integer(unsigned(wAdr))) <= wData;
            end if;
        end if;
    end process;

end Behavioral;
