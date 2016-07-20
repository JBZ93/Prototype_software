-- Verify if the global module work fine.
-- You must have in output a counter between 0 to X value

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;

entity Ramp_tb is
end entity;

architecture behav of Ramp_tb is 
signal clk: std_logic:='0';
signal S: std_logic_vector(8-1 downto 0);
begin
	
	Test: entity work.Ramp(behav)
	generic map(8)
	port map(clk=>clk,S=>S);
	
	clk<=not(clk) after 20ns;


end architecture;
