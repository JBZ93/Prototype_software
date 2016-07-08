--This driver increases the instruction to drive the dutty cycle and so drive the PWM
-- the instruction has a linear evolution ( equivalent to a ramp) 

-- LIBRAIRY DECLARATION 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

-- ramp evolution : 0V a 1V 
-- range in output of the FPGA : 3.3V
-- ramp duration : 200us
-- X is the number of value to reach 1V (start is 0V) with 8bits resolution
-- -> X values for 8bits  200us/X -> /40ns --> limit count --> Y bits
-- ->80 values pour 8bits    2,5us -> 62,5 --> 6 bits

--entity declaration 
entity DriverRamp is
generic (	N : integer := 8; -- resolution
			N_CNT : integer := 6 -- number of bit to count until 62
);
port (	clk : in std_logic; -- clock signal
		reset : in std_logic; -- reset signal
		S : out std_logic_vector(N-1 downto 0) -- instruction signal
);
end entity;

--architecture declaration
architecture behav of DriverRamp is
signal cnt: std_logic_vector(N_CNT -1 downto 0):= "000000";
signal consigne: std_logic_vector(N-1 downto 0):= "00000000"; 
begin
	process (clk,reset)
	begin
		if ( reset = '1' ) then -- reinitialization
				cnt <= std_logic_vector(to_unsigned(0,N_CNT)); -- put at 0
				consigne <= std_logic_vector(to_unsigned(0,N)); -- put at 0
		
		elsif (clk='1' and clk'event) then --every rising edge
			cnt <= std_logic_vector(unsigned(cnt) + to_unsigned(1, N_CNT)); -- incrementation
			if (cnt = 62) then -- every 2,5 us
				consigne <= std_logic_vector(unsigned(consigne) + to_unsigned(1, N)); -- instruction incrementation
				cnt <= std_logic_vector(to_unsigned(0,N_CNT)); -- reset the counter
			end if;
		end if;
	end process;
S <= not consigne; -- invert the instruction for comparison module
end architecture;