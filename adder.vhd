library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adder is
port(
	A: in signed(20 downto 0);
	B: in signed(20 downto 0);
	C: out signed(20 downto 0);
	sel_add: in std_logic;
	trunc: in std_logic
	);
end adder;


architecture Behavioral of adder is
signal aux: signed(20 downto 0);


begin
aux <= A+B when sel_add='0' else A-B;
C <= (20 downto 16 => aux(20)) & aux(20 downto 5) when trunc='1' else aux;

end Behavioral;
