library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mult is
port(
	A: in signed(20 downto 0);
	B: in signed(20 downto 0);
	C: out signed(20 downto 0)
	);
end mult;


architecture Behavioral of mult is
signal aux: signed(41 downto 0);

begin
aux <= A*B;
C<= aux(20 downto 0);

end Behavioral;
