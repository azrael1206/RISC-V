----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2017 15:34:00
-- Design Name: 
-- Module Name: alu - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
--use ieee.std_logic_signed;
--use ieee.std_logic_unsigned;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu is
    Port ( data1 : in STD_LOGIC_VECTOR(31 downto 0);
           data2 : in STD_LOGIC_VECTOR(31 downto 0);
           func3 : in STD_LOGIC_VECTOR(2 downto 0);
           selector_bit : in STD_LOGIC;
           is_imm : in STD_LOGIC;
           data_out : out STD_LOGIC_VECTOR(31 downto 0));
end alu;

architecture Behavioral of alu is
begin
    data_out <= signed(data1) + signed(data2) when (func3 = "000" and (selector_bit = '0' or is_imm = '1')) else                        --ADD
                signed(data1) - signed(data2) when (func3 = "000" and selector_bit = '1' and is_imm = '0') else                         --SUB
                data1 and data2 when (func3 = "111") else                                                                               --AND
                data1 or data2 when (func3 = "110") else															                    --OR
                data1 xor data2 when (func3 = "100") else															                    --XOR
                "00000000000000000000000000000001" when ((func3 = "010") and (signed(data1) < signed(data2))) else		                --SLT
                "00000000000000000000000000000001" when ((func3 = "011") and (unsigned(data1) < unsigned(data2))) else  	            --SLTU
                std_logic_vector(shl(unsigned(data1), unsigned(data2(4 downto 0)))) when (func3 = "001") else					        --SLL
                std_logic_vector(shr(unsigned(data1), unsigned(data2(4 downto 0)))) when (func3 = "101" and selector_bit = '0') else    --SRL
                std_logic_vector(shr(signed(data1), unsigned(data2(4 downto 0)))) when (func3 = "101" and selector_bit = '1') else      --SRA
                (others => '0');
                
end Behavioral;
