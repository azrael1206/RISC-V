----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.01.2018 15:46:26
-- Design Name: 
-- Module Name: debouncer_32 - Behavioral
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

entity debouncer_32 is
  Port (clk : in std_logic;
        data_in : in std_logic_vector (21 - 1 downto 0);
        data_out : out std_logic_vector (21 - 1 downto 0)
        );
end debouncer_32;

architecture Structual of debouncer_32 is

begin
    debouncers: for I in 0 to 21 - 1 generate
    begin
        bouncer: entity work.debouncer_new(Behavioral)
        port map (clk => clk,
                  data => data_in(I),
                  op_data => data_out(I)
                  );
    end generate;
    

end Structual;
