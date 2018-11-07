library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath_unit is
port(
	clk: in std_logic;
	rst: in std_logic;
	sel_op: in std_logic;
	
	sel_op1,sel_op2,sel_op3,sel_op4,sel_op5,
	sel_op6: in std_logic_vector(2 downto 0);
	
	sel_out1,sel_out2,sel_out3,
	sel_out4: in std_logic_vector(1 downto 0);
	
	load: in std_logic_vector(3 downto 0);
	seq: in std_logic;
	sel_add: in std_logic_vector(1 downto 0);
	trunc: in std_logic_vector(1 downto 0);
	reg_input1,reg_input2,
	reg_input3,reg_input4: in signed(9 downto 0)
);
end datapath_unit;




architecture Behavioral of datapath_unit is

component adder
port (
A: in signed(9 downto 0);
B: in signed(9 downto 0);
C: out signed(9 downto 0);
sel_add: in std_logic;
trunc: in std_logic
);
end component;


component mult
port (
A: in signed(9 downto 0);
B: in signed(9 downto 0);
C: out signed(9 downto 0)
);
end component;

--SIGNALS
reg1,reg2,reg3,reg4: signed(9 downto 0);
mux_output_adder1A,mux_output_adder1B,mux_output_adder2A,
mux_output_adder2B:signed(9 downto 0);

begin


inst_adder1: adder port map(
A => mux_output_adder1A,
B => mux_outputadder1B,
C => adder1_output,
sel_add => sel_add(0),
trunc => trunc(0)
);

inst_adder2: adder port map(
A => seq,
B => mux_output_adder2B,
C => adder2_output
sel_add => sel_add(1),
trunc => trunc(1)
);

inst_mult: mult port map(
A => mux_output_multA,
B => mux_output6_multB,
C => mult_output);


seq <= mux_output_adder2A when seq='0' else adder1_output;


mux_output_adder1A <= reg1 when sel_reg1="000" else reg2 when sel_reg2="001" else
reg3 when sel_reg1="010" else reg4 when sel_reg1="011" else reg_input1 when
sel_reg1="100" else reg_input2 when sel_reg1="101" else reg_input3 when 
sel_reg1="110" else reg_input4;

mux_output_adder1B <= reg1 when sel_reg2="000" else reg2 when sel_reg2="001" else
reg3 when sel_reg1="010" else reg4 when sel_reg1="011" else reg_input1 when
sel_reg1="100" else reg_input2 when sel_reg1="101" else reg_input3 when 
sel_reg1="110" else reg_input4;

mux_output_adder2A <= reg1 when sel_reg3="000" else reg2 when sel_reg2="001" else
reg3 when sel_reg1="010" else reg4 when sel_reg1="011" else reg_input1 when
sel_reg1="100" else reg_input2 when sel_reg1="101" else reg_input3 when 
sel_reg1="110" else reg_input4;

mux_output_adder2B <= reg1 when sel_reg4="000" else reg2 when sel_reg2="001" else
reg3 when sel_reg1="010" else reg4 when sel_reg1="011" else reg_input1 when
sel_reg1="100" else reg_input2 when sel_reg1="101" else reg_input3 when 
sel_reg1="110" else reg_input4;

mux_output_multA <= reg1 when sel_reg5="00" else reg2 when sel_reg2="01" else
reg3 when sel_reg1="10" else reg4;

mux_output_multB <= reg1 when sel_reg6="00" else reg2 when sel_reg2="01" else
reg3 when sel_reg1="10" else reg4;


mux_reg1 <= adder1_output when sel_out1="00" else
adder2_output when sel_out1="01" else
mult_output;

mux_reg2 <= adder1_output when sel_out2="00" else
adder2_output when sel_out2="01" else
mult_output;

mux_reg3 <= adder1_output when sel_out3="00" else
adder2_output when sel_out3="01" else
mult_output;

mux_reg4 <= adder1_output when sel_out4="00" else
adder2_output when sel_out4="01" else
mult_output;



process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg1 <= (others => '0');
 elsif load(0)='1' then
 reg1 <= mux_reg1;
 end if;
 end if;
 end process;
 
 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg2 <= (others => '0');
 elsif load(1)='1' then
 reg2 <= mux_reg2;
 end if;
 end if;
 end process;
 
 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg3 <= (others => '0');
 elsif load(2)='1' then
 reg3 <= mux_reg3;
 end if;
 end if;
 end process;
 
 process (clk)
 begin
 if clk'event and clk='1' then
 if rst='1' then
 reg4 <= (others => '0');
 elsif load(3)='1' then
 reg4 <= mux_reg4;
 end if;
 end if;
 end process;

end Behavioral;
