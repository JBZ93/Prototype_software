-- The output must have low level during 200us

--LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
LIBRARY work;

-- TEST BENCH
-- Simulation of the behaviour of the TempoRamp module
-- View the result on ModelSim-Altera

-- ENTITY DECLARATION
entity TempoRamp_tb is --always empty for a testbench
end entity;

-- ARCHITECTURE DECLARATION
architecture behav_tb of TempoRamp_tb is
signal clk: std_logic:='0';
signal S: std_logic;
begin
	Test: entity work.TempoRamp(behav)
	port map(clk=>clk,S=>S);
	
clk <= NOT(clk) after 20 ns; -- simulate the clock signal

end architecture;