library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
port(
	A: in signed(10 downto 0);
	B: in signed(10 downto 0);
	C: out signed(10 downto 0);
	trunc: in std_logic
	);
end mult;


architecture Behavioral of mult is
signal aux: signed(21 downto 0);
signal aux2: signed(21 downto 0);

begin
aux <= A*B;
aux2 <= (21 downto 17 => aux(21)) & aux(21 downto 5) when trunc='1' else aux;
C<= aux2(10 downto 0);

end Behavioral;
