-- This module regulates the duration of the ramp
-- a signal give the start and the stop for the duration that you want

--LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- entity declaration
entity TempoRamp is
port(clk: in std_logic; -- clock signal input
	S: out std_logic -- output
);
end TempoRamp; 

--architecture declaration
architecture behav of TempoRamp is
signal cnt: std_logic_vector(13 downto 0):= "00000000000000"; -- counter
signal reset: std_logic:='0'; -- reset signal
begin
	process (clk)
	begin
		if (cnt = 16380) then -- duration for the reset at 1
			reset <= not reset; -- when it finishes put at 0
			cnt <= std_logic_vector(to_unsigned(0,14)); -- reset the counter
			
		elsif(clk='1' and clk'event) then --every rising edge
			cnt <= std_logic_vector(unsigned(cnt) + to_unsigned(1, 14)); -- incrementation
			if (cnt = 5000) then -- 5000 means reset every 200us
				reset <= not reset; -- invert the reset signal : set at 1
			end if;

		end if;
	end process;
S <= reset; -- put the reset signal in output
end behav;