-- Connect the different component of the project

-- LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
LIBRARY work;

-- entity declaration
entity Ramp is
generic (N: integer := 8) ;
port( clk: in std_logic; -- clock signal
	S: out std_logic_vector(N-1 downto 0)
);
end Ramp; 

--architecture declaration
architecture behav of Ramp is

--component declaration

component RampDAC
generic(N : integer := 8); -- bit numbre of the DAC
port (
	en: in std_logic;
	rst: in std_logic;
	S: out std_logic_vector(N-1 downto 0)
);
end component; 

component TempoRamp
port(clk: in std_logic; 
	S: out std_logic
);
end component; 

component PulserTempo
generic (N : integer :=8);
port (
	clk: in std_logic;
	pulse: out std_logic
);
end component;

signal rst: std_logic;
signal pulse: std_logic;
begin
	
	-- connect the different component amongst themselves 
	pulser: PulserTempo
	generic map (N=>N)
	port map (clk=>clk,pulse=>pulse);
	
	driver: RampDAC
	generic map(N=>N)
	port map(en=>pulse,rst=>rst,S=>S);
	
	PeriodRamp:TempoRamp
	port map(clk=>clk,S=>rst);
	
end behav;