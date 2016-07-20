-- Verify if the pulser is generated

-- LIBRAIRY DECLARATION 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
library work;

--ENTITY DECLARATION
entity PulserTempo_tb is
end entity;

--ARCHITECTURE DECLARATION
architecture behav of PulserTempo_tb is 
signal clk: std_logic:='0';
signal pulser: std_logic;
begin
	
	Test: entity work.PulserTempo(behav)
	generic map(8)
	port map(clk=>clk,pulse=>pulser);
	
	clk<=not(clk) after 20ns;


end architecture;
