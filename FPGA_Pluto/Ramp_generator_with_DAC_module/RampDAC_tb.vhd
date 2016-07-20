-- You must see a counter driver in the output from the input command

-- LIBRARY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library work;

--ENTITY DECLARATION
entity RampDAC_tb is
end entity;

--ARCHITECTURE DECLARATION
architecture behav of RampDAC_tb is 
signal S: std_logic_vector(8-1 downto 0);
signal en: std_logic:='0';
signal rst: std_logic:='1';
signal count: std_logic_vector(8-1 downto 0);
begin
	
	Test: entity work.RampDAC(behav)
	generic map(8)
	port map(en=>en,rst=>rst,S=>S);
	
	process
	begin
		wait for 20ns;
		rst <= '0';
		wait for 20ns;
		
		for count in 1 to 8 loop
			en <= '1';
			wait for 20ns;
			en <= '0';
			wait for 20ns;
		
		end loop;
		rst <='1';
		wait for 500ns;
	end process;


end architecture;
