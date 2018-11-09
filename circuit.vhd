library IEEE;

use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity circuit is

port(
clk, rst: in std_logic
);
end circuit;


architecture Behavioral of circuit is

component control_unit
port(
	clk: in std_logic;
	rst: in std_logic; 
	init: in std_logic;
	sel_reg1: out std_logic_vector(2 downto 0);
	sel_reg2: out std_logic_vector(2 downto 0);
	sel_reg3: out std_logic_vector(2 downto 0);
	sel_reg4: out std_logic_vector(2 downto 0);
	sel_reg5: out std_logic_vector(1 downto 0);
	sel_reg6: out std_logic_vector(1 downto 0);
	sel_out1: out std_logic_vector(1 downto 0);
	sel_out2: out std_logic_vector(1 downto 0);
	sel_out3: out std_logic_vector(1 downto 0);
	sel_out4: out std_logic_vector(1 downto 0);
	load: out std_logic_vector(3 downto 0);
	sel_add: out std_logic_vector(1 downto 0);
	trunc: out std_logic_vector(1 downto 0);
	seq: out std_logic
);
end component;

component datapath_unit is
port(
	clk: in std_logic;
	rst: in std_logic;
	sel_op: in std_logic;
	sel_op1: in std_logic_vector(2 downto 0);
	sel_op2: in std_logic_vector(2 downto 0);
	sel_op3: in std_logic_vector(2 downto 0);
	sel_op4: in std_logic_vector(2 downto 0);
	sel_op5: in std_logic_vector(2 downto 0);
	sel_op6: in std_logic_vector(2 downto 0);
	sel_out1: in std_logic_vector(1 downto 0);
	sel_out2: in std_logic_vector(1 downto 0);
	sel_out3: in std_logic_vector(1 downto 0);
	sel_out4: in std_logic_vector(1 downto 0);
	load: in std_logic_vector(3 downto 0);
	seq: in std_logic;
	sel_add: in std_logic_vector(1 downto 0);
	trunc: in std_logic_vector(1 downto 0)
);
end component;


begin

inst_control: control_unit port map (
	clk => clk,
	rst => rst,
	init => init
);

inst_datapath: datapath_unit port map (
	clk => clk,
	rst => rst,
	sel_op1 => sel_reg1,
	sel_op2 => sel_reg2,
	sel_op3 => sel_reg3,
	sel_op4 => sel_reg4,
	sel_op5 => sel_reg5,
	sel_op6 => sel_reg6,
	sel_out1 => sel_out1,
	sel_out2 => sel_out2,
	sel_out3 => sel_out3,
	sel_out4 => sel_out4,
	load => load,
	sel_add => sel_add, 
	trunc => trunc,
	seq => seq
);

end Behavioral;
