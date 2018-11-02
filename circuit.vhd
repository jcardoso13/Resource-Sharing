library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity circuit is

port(
clk, rst: in std_logic;
instr: in std_logic_vector(3 downto 0);
data_in: in std_logic_vector(12 downto 0); -- -4,095 to 4,095
result: out std_logic_vector(16 downto 0); -- -65 535 to 65 535
reg1: out std_logic_vector(12 downto 0);
start: in std_logic
);
end circuit;


architecture Behavioral of circuit is

component control_unit
port(
	clk: in std_logic;
	rst: in std_logic;
	instr: in std_logic_vector(3 downto 0);
	start: in std_logic;
	sel_op: out std_logic;
	sel_alu: out std_logic_vector(1 downto 0);
	load1: out std_logic;
	load2: out std_logic_vector(1 downto 0)
);
end component;

component datapath_unit
port(
	clk: in std_logic;
	rst: in std_logic;
	data_in: in std_logic_vector(12 downto 0);
	sel_op: in std_logic;
	sel_alu: in std_logic_vector(1 downto 0);
	load1: in std_logic;
	load2: in std_logic_vector(1 downto 0);
	result: out std_logic_vector(16 downto 0);
	reg1:	out std_logic_vector(12 downto 0)
);
end component;

signal sel_op: std_logic;
signal load1: std_logic;
signal load2: std_logic_vector(1 downto 0);
signal sel_alu: std_logic_vector (1 downto 0);


begin

inst_control: control_unit port map (
	clk => clk,
	rst => rst,
	instr => instr,
	start => start,
	sel_op => sel_op,
	sel_alu => sel_alu,
	load1 =>load1,
	load2 =>load2
);

inst_datapath: datapath_unit port map (
	clk => clk,
	rst => rst,
	data_in => data_in,
	sel_op => sel_op,
	sel_alu => sel_alu,
	load1 => load1,
	load2 => load2,
	result => result,
	reg1 => reg1
);

end Behavioral;
