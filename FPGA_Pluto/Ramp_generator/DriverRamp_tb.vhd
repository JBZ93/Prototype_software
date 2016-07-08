--LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
LIBRARY work;

-- TEST BENCH
-- Simulation of the behaviour of the DriverRamp module
-- View the result on ModelSim-Altera

--entity declaration
entity DriverRamp_tb is --always empty for a testbench
end entity;

architecture behav_tb of DriverRamp_tb is
signal clk: std_logic:='0';
signal S: std_logic_vector(7 downto 0);
signal reset: std_logic := '0';
begin
	Test: entity work.DriverRamp(behav)
	generic map (N=>8) 
	port map(clk=>clk,reset=>reset,S=>S);
	
	clk <= NOT(clk) after 20 ns; -- simulate the clock signal

	STIMULUS: process -- simulate the reset signal behaviour
	begin
	reset <= '1';
	wait for 40 ns;
	reset <= '0';
	wait for 200 us;
	reset <= '1';
		
	end process STIMULUS;

end architecture;