library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity presetable_updown_counter is
port(
-- INPUTS --
clk :in std_logic; -- clock
reset :in std_logic; -- ansynchronous clear
enb :in std_logic; -- enable signal
ud :in std_logic; -- up down selection
in_data :in std_logic_vector(3 downto 0); -- initial value

-- OUTPUTS --
out_data :out std_logic_vector(3 downto 0); -- counter output value
rco :out std_logic -- rco
); 
end;

architecture behavioral of presetable_updown_counter is
signal count:std_logic_vector(3 downto 0); -- internal counter

begin

	p:process(clk,reset,ud)
	

	begin
		
		if reset='1' then --if0
		count<= in_data;
		elsif (clk'event and clk='1') then
			if enb='1' then  -- if1
				if count="1001" and ud = '1' then --if2
				count<= "0000";
				rco<= '1';
				elsif count= "0000" and ud = '0' then
				count<= "1001";
				rco<= '1';
				else
					if ud = '1' then --if3
					count<= count + 1;
					rco <= '0';
					else
					count <= count - 1;
					rco <= '0';
					end if; --if3
				end if; --if2
			else
			count<= count + 0;
			end if; --if1
		end if; --if0
	end process p;
	out_data<= count;
end behavioral;
