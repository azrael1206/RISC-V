----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2017 15:16:59
-- Design Name: 
-- Module Name: instruction_decoder - Behavioral
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

entity instruction_decoder is Port (
    instruction : in std_logic_vector (32 - 1  downto 0); --Instruction
    rs1 : out std_logic_vector (5 - 1 downto 0); --Adress first register
    rs2 : out std_logic_vector (5 - 1 downto 0); -- Adress second register
    rd : out std_logic_vector (5 - 1 downto 0); -- Adress write register
    funct3 : out std_logic_vector (3 - 1 downto 0); --ALU set first
    funct7 : out std_logic_vector (7 - 1 downto 0); --ALU set second
    rwrite : out std_logic; --Set Write Bit
    selector : out std_logic_vector (2 - 1 downto 0); --activate Alu
    selector_bra : out std_logic_vector (2 - 1 downto 0); --activate Brancher
    imm_select : out std_logic;
    imm_out : out std_logic_vector (32-1 downto 0);
    ram_offset : out std_logic_vector (12 -1 downto 0);
    ram_width : out std_logic_vector (3 - 1 downto 0);
    ram_r_w : out std_logic;
    pc_r_w: out std_logic;
    to_register : out std_logic_vector (32 - 1 downto 0);
    halt_cpu : out std_logic;
    clk : in std_logic;
    stop_cpu : in std_logic

    );
end instruction_decoder;

architecture Behavioral of instruction_decoder is
    signal opcode : std_logic_vector (7 - 1 downto 0);
begin
    imm_out <= std_logic_vector(resize(signed(instruction(31 downto 20)), imm_out'length));
    to_register <= instruction (31 downto 12) & "000000000000";
    opcode <= instruction(6 downto 0);
    rs1 <= instruction(19 downto 15);
    rs2 <= instruction(24 downto 20) when (opcode /= "0010011") else
           (others => '0');
    rd <= instruction(11 downto 7);
    funct3 <= instruction(14 downto 12);
    funct7 <= instruction(31 downto 25);
    ram_width <= instruction(14 downto 12);
    
    
    ram_r_w <= '1' when (opcode = "0100011") else
               '0';
     
    ram_offset <= instruction(31 downto 20) when (opcode = "0000011") else
                  instruction(31 downto 25) & instruction(11 downto 7) when (opcode = "0100011") else
                  (others => '0');
    
    rwrite <= '1' when (opcode = "0110011" OR opcode = "0010011" OR (opcode = "0000011" AND stop_cpu = '0') OR opcode = "1101111" OR opcode = "0110111" OR opcode = "0010111") else
              '0';

              
    selector <= "00" when (opcode = "0110011" OR opcode = "0010011") else                                               --ALU
                "01" when opcode = "0000011" else                                                                       --IO
                "10" when (opcode = "1101111" OR opcode = "1100011" OR opcode = "1100111"  OR opcode = "0010111") else  --PC
                "11" when opcode = "0110111" else                                                                       --ID
                "00";

    imm_select <= '1' when opcode = "0010011" else
                  '0';
    
    pc_r_w <= '1' when (opcode = "1101111" OR opcode = "1100011" OR opcode = "1100111"  OR opcode = "0010111" ) else
              '0';
                       

                  
    selector_bra <= "00" when opcode = "1101111" else   --JAL
                    "01" when opcode = "1100111" else   --JALR
                    "10" when opcode = "1100011" else   --B-Type
                    "11" when opcode = "0010111" else   --AUIPC
                    "00";
   
    halt_cpu <= '1' when (opcode = "0000011") else
                '0';

end Behavioral;
