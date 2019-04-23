-- Listing 13.5
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity text_screen_top is
   port(
      clk,reset: in std_logic;
      adress: in std_logic_vector (32 - 1 downto 0);
      data :in std_logic_vector (32 - 1 downto 0);
      hsync, vsync: out  std_logic;
      rgb: out std_logic_vector(12 - 1 downto 0)
   );
end text_screen_top;

architecture arch of text_screen_top is
   signal pixel_x, pixel_y: std_logic_vector(9 downto 0);
   signal video_on, pixel_tick: std_logic;
   signal rgb_reg, rgb_next: std_logic_vector(12 - 1 downto 0);
   signal set_x : std_logic_vector (7 - 1 downto 0);
   signal set_y : std_logic_vector (5 - 1 downto 0);
   signal set_ascii : std_logic;
   signal ascii : std_logic_vector (7 - 1 downto 0);
   signal setc : std_logic_vector (2 - 1 downto 0);
begin
    
    setc <= "01" when (adress(32 - 1 downto 13) = "1111111111111111000") else   --movexy
            "10" when (adress(32 - 1 downto 13) = "1111111111111111100") else   --movex
            "11" when (adress(32 - 1 downto 13) = "1111111111111111110") else   --movey
            "00"; 


    ascii <= data (7 - 1 downto 0);
   -- instantiate VGA sync circuit
   vga_sync_unit: entity work.vga_sync
      port map(clk=>clk, 
               reset=>reset,
               hsync=>hsync, 
               vsync=>vsync,
               video_on=>video_on, 
               p_tick=>pixel_tick,
               pixel_x=>pixel_x, 
               pixel_y=>pixel_y);
   -- instantiate full-screen text generator
   text_gen_unit: entity work.text_screen_gen
      port map(clk=>clk,  
               set_x => set_x, 
               set_y => set_y,
               set_ascii => set_ascii,
               ascii => ascii,
               video_on=>video_on, 
               pixel_x=>pixel_x,
               pixel_y=>pixel_y, 
               text_rgb=>rgb_next);
   -- rgb buffer
   process (clk)
   begin
      if (clk'event and clk='1') then
         if (pixel_tick='1') then
            rgb_reg <= rgb_next;
         end if;
      end if;
   end process;
   rgb <= rgb_reg;
  
  process(clk)
  begin
  
  set_ascii <= '0';
  if (rising_edge(clk)) then
    if (reset = '1') then
        set_x <= (others => '0');
        set_y <= (others => '0');
    elsif (setc = "01") then
        set_x <= adress ( 7 - 1 downto 0);
        set_y <= adress (12 - 1 downto 7);
        --set_ascii <= '1';
    elsif (setc = "10") then
        if (unsigned (set_x) >= 80 - 1) then
            set_x <= (others => '0');
        else
            set_x <= std_logic_vector(unsigned(set_x) + 1);
        end if;
        set_ascii <= '1';
    elsif (setc = "11") then
        if (unsigned (set_y) >= 30 - 1) then
            set_y <= (others => '0');
        else
            set_y <= std_logic_vector(unsigned(set_y) + 1);
        end if;
        set_ascii <= '1';
    end if;
  end if;
  
  end process;

end arch;