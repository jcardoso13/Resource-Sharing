library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
port(
	A: in signed(9 downto 0);
	B: in signed(9 downto 0);
	C: out signed(9 downto 0);
	trunc: in std_logic
	);
end mult;


architecture Behavioral of mult is
signal aux: signed(19 downto 0);
signal aux2: signed(19 downto 0);

begin
aux <= A*B;
aux2 <= (19 downto 15 => aux(19)) & aux(19 downto 5) when trunc='1' else aux;
C<= aux2(9 downto 0);

end Behavioral;
