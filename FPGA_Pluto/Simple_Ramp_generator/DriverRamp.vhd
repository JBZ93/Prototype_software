-- Generate the signal command to control charging and discharging

-- LIBRARY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- ENTITY DECLARATION
entity DriverRamp is
port (
	start : in std_logic; -- start signal
	S1 : out std_logic;
	S2: out std_logic
);
end entity;

-- ARCHITECTURE DECLARATION
architecture behav of DriverRamp is

begin

	process (start)
	begin
		if (start = '0') then -- generate the ramp (charging)
			S1 <= '1'; -- connect to R1
			S2 <= 'Z'; -- High Impedence
		
		else -- start '1' (discharging)
			S1 <= 'Z';
			S2 <= '0'; -- connect to R2
		end if;
	end process;


end architecture;