-- LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
LIBRARY work;
use work.all;

-- TEST BENCH
-- Simulation of the behaviour of the incr module
-- View the result on ModelSim-Altera

--entity declaration
entity incr_tb is
end entity; -- always empty for a testbench

--architecture declaration
architecture behav_tb of incr_tb is
signal clk: std_logic:='0';
signal S: std_logic_vector(7 downto 0);
begin
	Test: entity work.incr(behav)
	generic map(N=>8)
	port map(clk=>clk,S=>S);
	
	clk <= NOT(clk) after 20 ns; --simulate the clock signal

end architecture;