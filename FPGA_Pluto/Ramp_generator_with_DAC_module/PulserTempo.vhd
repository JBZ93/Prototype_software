-- Generate the pulser command for the RampDAC module
-- The duration between the pulse is little => RampDAC module count a lot
-- The duration between the pulse is growth => RampDAC module count a little

-- LIBRAIRY DECLARATION 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--ENTITY DECLARATION
entity PulserTempo is
generic (N : integer :=8);
port (
	clk: in std_logic;
	pulse: out std_logic
);
end entity;

--ARCHITECTURE DECLARATION
architecture behav of PulserTempo is
signal cnt: std_logic_vector(N-1 downto 0):= std_logic_vector(to_unsigned(0,N));
begin
	process (clk)
	begin
		if (cnt = 151) then --reset
			cnt <= std_logic_vector(to_unsigned(0,N));
			pulse <= '0';
		elsif (clk ='1' and clk'event) then
			cnt <= std_logic_vector(unsigned(cnt) + to_unsigned(1,N));
			if (cnt = 150) then -- 150 rising edge for evolution between 0V and 1V
				pulse <= '1'; -- set the command for RampDAC module
			end if;
		end if;
	end process;

end architecture;