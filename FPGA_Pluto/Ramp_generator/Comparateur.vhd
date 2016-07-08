-- This module compares 2 signals and indicate the result in output

--LIBRAIRY DECLARATION
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- entity declaration
entity Comparateur is
generic (N: integer := 8) ;
port(A: in std_logic_vector(N-1 downto 0); -- connect to counter module
	B: in std_logic_vector(N-1 downto 0); -- connect to instruction module
	S: out std_logic -- result of the comparison
);
end Comparateur; 

-- architecture declaration
architecture behav of Comparateur is
begin

S <= '1' when A>B else '0'; -- put the output at 1 when A > B or else the output is 0

end behav;