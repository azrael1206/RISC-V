--------------------------------------------------------------------------------
-- Author: Steffen Reith (Steffen.Reith@hs-rm.de)
-- Committer: Steffen Reith
--
-- Create Date:    Tue Oct 20 22:41:01 CEST 2015
-- Module Name:    Memory - Behavioral
-- Project Name:   sCPU - A simple stack based CPU
--
-- Hash: 9bc8030c17c88fa2a15c917ac7db7ce82a1291ec
-- Date: Sat Dec 19 17:31:08 2015 +0100
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;


package Progs is

  -- Test the LED bank
  constant prog1 : memory_t :=
    ( 0 => "00000000000000000000000000010011", -- NOP
      1 => "00000000000000000000000000010011", -- NOP
      2 => "00000000000000000000000000010011", -- NOP
      
     others => (others => '0'));
  

end Progs;
