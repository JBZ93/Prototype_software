-- This module allows incrementation of a counter 

-- LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--entity declaration
entity incr is
generic (N: integer := 8); -- bus size
port( clk : in std_logic; -- clock signal
	S : out std_logic_vector(N-1 downto 0) -- output

);
end incr;

-- architecture declaration
architecture behav of incr is
signal cnt : std_logic_vector(N-1 downto 0) := "00000000"; -- counter initialization  
begin
	process(clk) 
	begin
		if(clk = '1' and clk'event ) then --every rising edge
			cnt <= cnt + std_logic_vector(to_unsigned(1,N)); -- cnt +1 = incrementation
		end if;
	end process;
S<=cnt; -- put the counter in output
end behav;