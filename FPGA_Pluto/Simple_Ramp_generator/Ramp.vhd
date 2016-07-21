-- Connect all modules

--LIBRARY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- ENTITY DECLARATION
entity Ramp is 
port (
	clk : in std_logic;
	S1 : out std_logic;
	S2: out std_logic
);
end entity ;

-- ARCHITECTURE DECLARATION
architecture behav of Ramp is 

component DriverRamp
port(start : in std_logic;
	S1 : out std_logic;
	S2: out std_logic
);
end component; 

component TempoRamp
port(clk: in std_logic; -- clock signal input
	S: out std_logic -- output
);
end component; 

signal start : std_logic := '1';
begin

	durationRamp: TempoRamp
	port map (clk=>clk,S=>start);
	
	driver: DriverRamp
	port map (start=>start,S1=>S1,S2=>S2);

end architecture;
