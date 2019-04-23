----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Yannick
-- 
-- Create Date: 09.01.2018 12:58:28
-- Design Name: 
-- Module Name: branch_predictor - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity branch_predictor is
  Port (                                                    --B-Type       / AUIPC      / JAL          / JALR
      data1 : in std_logic_vector(32 - 1 downto 0);         --rs1          / -          / -            / rs1
      data2 : in std_logic_vector(32 - 1 downto 0);         --rs2          / -          / -            / -
      r1 : in std_logic_vector(5 - 1 downto 0);             -- -           / imm[19:15] / imm[19:15]   / -
      r2 : in std_logic_vector(5 - 1 downto 0);             -- -           / imm[24:20] / imm[4:1|11]  / imm[4:0]
      rd : in std_logic_vector(5 - 1 downto 0);             --imm[4:1|11]  / -          / -            / -
      funct7 : in std_logic_vector(7 - 1 downto 0);         --imm[12|10:5] / imm[31:25] / imm[20|10:5] / imm[11:5]
      funct3 : in std_logic_vector(3 - 1 downto 0);         --funct3       / imm[14:12] / imm[14:12]   / funct3
      pc_in : in std_logic_vector(16 - 1 downto 0);         --current PC
      write_enable_pc : in std_logic;                       --is b-type
      selector_bra : in std_logic_vector(2 - 1 downto 0);   --mult
      
      pc_out : out std_logic_vector(16 - 1 downto 0);       --new PC
      set_adress : out std_logic;                           --set new PC
      datad : out std_logic_vector(32 - 1 downto 0)         -- -           / rd         / rd           / rd
  );
end branch_predictor;

architecture Behavioral of branch_predictor is
signal jal : std_logic_vector (21 - 1 downto 0);
signal jalr : std_logic_vector (33 - 1 downto 0);
signal b_type : std_logic_vector (17 - 1 downto 0);
--signal temp : std_logic_vector (33 - 1 downto 0);
begin

  jal    <= unsigned(pc_in) + signed(funct7(6) & r1 & funct3 & r2(0) & funct7(5 downto 0) & r2(4 downto 1) & "0");
  jalr   <= unsigned(data1) + signed(funct7 & r2);
  b_type <= unsigned(pc_in) + signed(funct7(6) & rd(0) & funct7(5 downto 0) & rd(4 downto 1) & "0");
  
  pc_out <= unsigned(jal (16 - 1 downto 2) & "00") - 4 when (selector_bra = "00") else  --JAL
            jalr (16 - 1 downto 2) & "00" when (selector_bra = "01") else               --JALR
            unsigned(b_type (16 - 1 downto 2) & "00") - 4;                              --B-Type
  
  set_adress <= '1' when (write_enable_pc = '1' and (selector_bra = "00" or selector_bra = "01" or (selector_bra = "10" and --JAL, JALR
                          ((funct3 = "000" and data1 = data2) or                                                            --BEQ
                           (funct3 = "001" and data1 /= data2) or                                                           --BNE
                           (funct3 = "100" and signed(data1) < signed(data2)) or                                            --BLT
                           (funct3 = "101" and signed(data1) >= signed(data2)) or                                           --BGE
                           (funct3 = "110" and unsigned(data1) < unsigned(data2)) or                                        --BLTU
                           (funct3 = "111" and unsigned(data1) >= unsigned(data2)))))) else                                 --BGEU
                '0';
                
--  temp  <= unsigned(data1) + signed("1111111111111111111" & funct7 & r2 & "0") when (selector_bra = "01" and funct7(6) = '1') else  --JALR
--           unsigned(data1) + signed("0000000000000000000" & funct7 & r2 & "0");                                                     --JALR
           
  datad <= "0000000000000000" & pc_in when (selector_bra = "00" and funct7(6) = '1') else                                           --JAL
           unsigned(pc_in) + signed("1111111111111111" & r1(0) & funct3(2 downto 0) & "000000000000") when (funct3(1) = '1') else   --AUIPC
           unsigned(pc_in) + signed("0000000000000000" & r1(0) & funct3(2 downto 0) & "000000000000") when (funct3(1) = '0') else   --AUIPC
           "0000000000000000" & pc_in;                                                                                              --JALR
--           temp(31 downto 0);                                                                                                       --JALR

end Behavioral;
