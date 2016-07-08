--LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
LIBRARY work;

-- TEST BENCH
-- Simulation of the behaviour of the Ramp module
-- View the result on ModelSim-Altera

--entity declaration
entity Ramp_tb is --always empty for a testbench
end entity;

--architecture declaration
architecture behav_tb of Ramp_tb is
signal clk: std_logic:='0'; 
signal S: std_logic := '0';
begin
	Test: entity work.Ramp(behav)
	generic map (N=>8) 
	port map(clk=>clk,S=>S);
	
	clk <= NOT(clk) after 20 ns; -- simulate the clock signal

end architecture;