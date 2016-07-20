-- This module incremente a counter every rising edge in 'en' input
-- the counter means the ramp command for the DAC module


-- LIBRAIRY DECLARATION 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--ENTITY DECLARATION
entity RampDAC is
generic(N : integer := 8); -- bit number of the DAC
port (
	en: in std_logic;
	rst: in std_logic;
	S: out std_logic_vector(N-1 downto 0)
);
end entity;


--ARCHITECTURE DECLARATION
architecture behav of RampDAC is
signal cnt: std_logic_vector(N-1 downto 0):= std_logic_vector(to_unsigned(0,N)); -- beginning at 0
begin
	process (en,rst)
	begin
		if (rst = '1') then --reset
			cnt <= std_logic_vector(to_unsigned(0,N)); -- set at 0
		elsif (en ='1' and en'event) then -- every rising edge
			cnt <= std_logic_vector(unsigned(cnt) + to_unsigned(1,N)); -- incrementation of the counter
		end if;
	end process;

	S <= cnt; -- put the counter value in the output

end architecture;