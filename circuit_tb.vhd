LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
 
ENTITY circuit_tb IS
END circuit_tb;
 
ARCHITECTURE behavior OF circuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT circuit
    port(
clk, rst,init: in std_logic;
	reg_input_x,reg_input_y,
	reg_input_x0,reg_input_y0,reg_input_Q00,reg_input_Q01,
	reg_input_Q10,reg_input_Q11: in signed(9 downto 0);
	output: out std_logic_vector(20 downto 0)
);
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal init: std_logic:= '0';
   signal reg_input_x,reg_input_y,
       reg_input_x0,reg_input_y0,reg_input_Q00,reg_input_Q01,
       reg_input_Q10,reg_input_Q11: signed(9 downto 0) :=b"0000000000";


 	--Outputs
 	signal output:std_logic_vector(20 downto 0):= (others => '0');
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuit port map(
      clk => clk,
      rst => rst,
      init => init,
      reg_input_x=>reg_input_x,
      reg_input_y=>reg_input_y,
      reg_input_x0=>reg_input_x0,
      reg_input_y0=>reg_input_y0,
      reg_input_Q00=>reg_input_Q00,
      reg_input_Q01=>reg_input_Q01,
      reg_input_Q10=>reg_input_Q10,
      reg_input_Q11=>reg_input_Q11,
      output => output
        );

   -- Clock definition
   clk <= not clk after clk_period/2;

    -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      rst<='1';
      wait for 100 ns;	
      rst<='0';
	  reg_input_x <= X"010" after clk_period; --16
	  reg_input_y <= X"010" after clk_period;
	  reg_input_y0 <= X"000" after clk_period;
	  reg_input_x0 <= X"000" after clk_period;
	  reg_input_Q00 <= X"010" after clk_period;  -- 16
	  reg_input_Q01 <= X"030" after clk_period; -- 64
	  reg_input_Q10 <= X"010" after clk_period; --16
	  reg_input_Q11 <= X"030" after clk_period; -- 64
	  
	  init <= '1' after clk_period*2;
	  
	  
	  wait for 

      wait;
   end process;

END;
