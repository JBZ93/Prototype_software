-- This test generate the output according to the command signal in input

--LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
LIBRARY work;

-- ENTITY DECLARATION
entity DriverRamp_tb is --always empty for a testbench
end entity;

-- ARCHITECTURE DECLARATION
architecture behav_tb of DriverRamp_tb is
signal start: std_logic:='1';
signal S1: std_logic;
signal S2: std_logic;
begin
	Test: entity work.DriverRamp(behav)
	port map(start=>start,S1=>S1,S2=>S2);
	
	STIMULUS : process
	begin
		start <= '1';
		wait for 200 ns;
		start <= '0';
		wait for  200 ns;
		start <= '1';
		wait for  1000 ns;
	end process;

end architecture;