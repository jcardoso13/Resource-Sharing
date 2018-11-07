library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath_unit is
port(
	clk: in std_logic;
	rst: in std_logic;
	seq: in std_logic;
	
	--Selects Operands for Functional Unit
	sel_reg1,sel_reg2,sel_reg3,sel_reg4,sel_reg5,
	sel_reg6: in std_logic_vector(2 downto 0); 
	
	--Selects the Functional Unit that will write to each Register
	sel_out1,sel_out2,sel_out3,
	sel_out4: in std_logic_vector(1 downto 0);
	
	--Enable of the r/w Registers
	load: in std_logic_vector(3 downto 0);
	--Selects ADD(0) or SUB(1)
	sel_add: in std_logic_vector(1 downto 0);
	--Truncates the result of the sum/sub if =1 
	trunc: in std_logic_vector(1 downto 0);
	--Inputs
	reg_input_x,reg_input_y,
	reg_input_x0,reg_input_y0,reg_input_Q00,reg_input_Q01,
	reg_input_Q10,reg_input_Q11: in signed(9 downto 0)
);
end datapath_unit;




architecture Behavioral of datapath_unit is

component adder
port(
A: in signed(9 downto 0);
B: in signed(9 downto 0);
C: out signed(9 downto 0);
sel_add: in std_logic;
trunc: in std_logic
);
end component;


component mult
port(
A: in signed(9 downto 0);
B: in signed(9 downto 0);
C: out signed(9 downto 0)
);
end component;

--SIGNALS
signal reg1, reg2, reg3, reg4: signed(9 downto 0);
signal mux_output_adder1A,mux_output_adder1B,mux_output_adder2A,
mux_output_adder2B: signed(9 downto 0);
signal rw_reg_mux1A,rw_reg_mux2A,rw_reg_mux1B,rw_reg_mux2B: signal(9 downto 0);
signal input_mux_adder1A,input_mux_adder2A,input_mux_adder1B,
input_mux_adder2B:signed(9 downto 0);
signal input_mux: signed(9 downto 0);
signal rw_reg_mux:signed(9 downto 0);
signal seq_input :signed(9 downto 0);
signal mux_output_multA,mux_output_multB:signed(9 downto 0);
signal adder1_output,adder2_output,mult_output:signed(9 downto 0);
signal mux_reg1,mux_reg2,mux_reg3,mux_reg4:signed(9 downto 0);

begin


inst_adder1: adder port map(
A => mux_output_adder1A,
B => mux_output_adder1B,
C => adder1_output,
sel_add => sel_add(0),
trunc => trunc(0)
);

inst_adder2: adder port map(
A => seq_input,
B => mux_output_adder2B,
C => adder2_output,
sel_add => sel_add(1),
trunc => trunc(1)
);

inst_mult: mult port map(
A => mux_output_multA,
B => mux_output_multB,
C => mult_output);


seq_input<= mux_output_adder2A when seq='0' else adder1_output;


--SIGNAL that enters Adder1 Port A
mux_output_adder1A <= rw_reg_mux1A when sel_reg1(2)='0' else 
input_mux_adder1A;
--Signal from the 4 r/w Reg
rw_reg_mux1A <= reg1 when sel_reg1(1 downto 0)="00" else reg2 when sel_reg1(1 downto 0)="01" else
reg3 when sel_reg1(1 downto 0)="10" else reg4;
--Signal from 4 of the Input Reg
input_mux_adder1A <= reg_input_y when sel_reg1(1 downto 0)="00" else reg_input_x when sel_reg1(1 downto 0)="01" else
reg_input_Q10 when sel_reg1(1 downto 0)="10" else reg_input_Q11;


--SIGNAL that enters Adder1 Port B
mux_output_adder1B <= rw_reg_mux1B when sel_reg2(2)='0' else input_mux_adder1B;
--Signal from the 4 r/w Reg
rw_reg_mux1B <= reg1 when sel_reg2(1 downto 0)="00" else reg2 when sel_reg2(1 downto 0)="01" else
reg3 when sel_reg2(1 downto 0)="10" else reg4;
--Signal from 4 of the Input Reg
input_mux_adder1B <= reg_input_y0 when sel_reg2(1 downto 0)="00" else reg_input_x0 when sel_reg2(1 downto 0)="01" else
reg_input_Q00 when sel_reg2(1 downto 0)="10" else reg_input_Q01;

--SIGNAL that enters Adder2Port A
mux_output_adder2A <= rw_reg_mux1A when sel_reg3(2)='0' else 
input_mux_adder2A;
--Signal from the 4 r/w Reg
rw_reg_mux2A <= reg1 when sel_reg3(1 downto 0)="00" else reg2 when sel_reg3(1 downto 0)="01" else
reg3 when sel_reg3(1 downto 0)="10" else reg4;
--Signal from 4 of the Input Reg
input_mux_adder2A <= reg_input_y when sel_reg3(1 downto 0)="00" else reg_input_x when sel_reg3(1 downto 0)="01" else
reg_input_Q10 when sel_reg3(1 downto 0)="10" else reg_input_Q11;



--SIGNAL that enters Adder2 Port B
mux_output_adder2B <= rw_reg_mux1B when sel_reg4(2)='0' else input_mux_adder1B;
--Signal from the 4 r/w Reg
rw_reg_mux2B <= reg1 when sel_reg4(1 downto 0)="00" else reg2 when sel_reg4(1 downto 0)="01" else
reg3 when sel_reg4(1 downto 0)="10" else reg4;
--Signal from 4 of the Input Reg
input_mux_adder2B <= reg_input_y0 when sel_reg4(1 downto 0)="00" else reg_input_x0 when sel_reg4(1 downto 0)="01" else
reg_input_Q00 when sel_reg4(1 downto 0)="10" else reg_input_Q01;




mux_output_multA <= reg1 when sel_reg5="00" else reg2 when sel_reg5="01" else
reg3 when sel_reg5="10" else reg4;

mux_output_multB <= reg1 when sel_reg6="00" else reg2 when sel_reg6="01" else
reg3 when sel_reg6="10" else reg4;


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
