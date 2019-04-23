----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.12.2017 10:14:37
-- Design Name: 
-- Module Name: Instruction_Fetch - Behavioral
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

entity Instruction_Fetch is
    Port (   
        inst_in_adress : in std_logic_vector (16 - 1 downto 0); --von PC
        inst_out_adress : out std_logic_vector (14 - 1 downto 0);--an Ram
        inst_in_code : in std_logic_vector (32 - 1 downto 0); --Instruction von Ram
        inst_out_code : out std_logic_vector (32 - 1 downto 0); --Instruction an ID
        stop_cpu : in std_logic;
        mk_nop : in std_logic   
    );
end Instruction_Fetch;

architecture Behavioral of Instruction_Fetch is
    
begin
 
    inst_out_adress <= inst_in_adress(16 - 1 downto 2) when (stop_cpu = '0') else
                       std_logic_vector(unsigned(inst_in_adress(16 - 1 downto 2)) - 1);
    inst_out_code <= "00000000000000000000000000010011" when (mk_nop = '1') else
                     inst_in_code;

end Behavioral;
