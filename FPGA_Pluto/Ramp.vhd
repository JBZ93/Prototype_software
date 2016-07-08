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
	S: out std_logic
);
end Ramp; 

--architecture declaration
architecture behav of Ramp is

--component declaration

component Comparateur
generic (N: integer := 8) ;
port(A: in std_logic_vector(N-1 downto 0);
	B: in std_logic_vector(N-1 downto 0);
	S: out std_logic
);
end component; 

component TempoRamp
port(clk: in std_logic; 
	S: out std_logic
);
end component; 

component DriverRamp 
generic (	N : integer := 8);
port (	clk : in std_logic;
		reset : in std_logic;
		S : out std_logic_vector(N-1 downto 0)
);
end component;

component incr
generic (	N : integer := 8);
port(clk: in std_logic; 
	S: out std_logic_vector(N-1 downto 0)
);
end component; 

signal cnt : std_logic_vector(N-1 downto 0) := "00000000"; 
signal S_ramp : std_logic;
signal consigne: std_logic_vector(N-1 downto 0):= "00001000";

begin
	
	-- connect the different component amongst themselves 
	Compteur: incr
	generic map (N=>N)
	port map (clk=>clk,S=>cnt);
	
	Comp: Comparateur
	generic map(N=>N)
	port map(A=>cnt,B=>consigne,S=>S);
	
	PeriodRamp:TempoRamp
	port map(clk=>clk,S=>S_ramp);
	
	Driver: DriverRamp
	generic map (N=>N)
	port map(clk=>clk,reset=>S_ramp,S=>consigne);
	
end behav;