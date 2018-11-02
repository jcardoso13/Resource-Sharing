LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY circuit_tb IS
END circuit_tb;
 
ARCHITECTURE behavior OF circuit_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT circuit
    port(
    clk, rst: in std_logic
    );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';


 	--Outputs
   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: circuit port map(
      clk => clk,
      rst => rst
        );

   -- Clock definition
   clk <= not clk after clk_period/2;

    -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      -- note that input signals should never change at the positive edge of the clock

      wait;
   end process;

END;
