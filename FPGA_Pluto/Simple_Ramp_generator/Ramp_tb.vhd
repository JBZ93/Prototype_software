-- Simulate all the project

--LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
LIBRARY work;

-- ENTITY DECLARATION
entity Ramp_tb is --always empty for a testbench
end entity;

-- ARCHITECTURE DECLARATION
architecture behav_tb of Ramp_tb is
signal clk: std_logic:='0';
signal S1: std_logic;
signal S2: std_logic;
begin
	Test: entity work.Ramp(behav)
	port map(clk=>clk,S1=>S1,S2=>S2);
	
	clk <= NOT(clk) after 20 ns;

end architecture;