LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;

--Entity: no port list!
ENTITY  tb_mux_4to1 IS
END	tb_mux_4to1;

--Architecture
ARCHITECTURE sim OF tb_mux_4to1 IS
	COMPONENT mux_4to1
		PORT( 
			x0, x1, x2, x3	: IN  std_logic; 	
			sel 			: IN  std_logic_vector( 1 DOWNTO 0 );
          	y 				: OUT std_logic );
	END COMPONENT;

SIGNAL x0, x1, x2, x3 	: 	std_logic; 						--INPUT 
SIGNAL sel 				:	std_logic_vector( 1 DOWNTO 0 ); --INPUT
SIGNAL y 				:	std_logic; 						--OUTPUT
SIGNAL expect 			:	std_logic; 						--expected OUTPUT

BEGIN
	--DUT instantiation
	DUT : mux_4to1 PORT MAP( x0 => x0, x1 => x1, x2 => x2, x3 => x3, sel => sel, y => y );
	--Stimulus, apply inputs one at a time
	PROCESS 
	BEGIN
    		x0 <= '0'; x1 <= '1'; x2 <= '0'; x3 <= '1'; 
    		sel <= "00"; expect <= '0';
    	WAIT FOR 10 ns;
      	ASSERT( y = expect ) REPORT "Mismatch! when sel=0" SEVERITY error; --verify after the WAIT
      		sel <= "01"; expect <= '1';
    	WAIT FOR 10 ns;
      	ASSERT( y = expect ) REPORT "Mismatch! when sel=1" SEVERITY error;      
      		sel <= "10"; expect <= '0';
    	WAIT FOR 10 ns;
      	ASSERT( y = expect ) REPORT "Mismatch! when sel=2" SEVERITY error;
      		sel <= "11"; expect <= '1';
    	WAIT FOR 10 ns;
      	ASSERT( y = expect ) REPORT "Mismatch! when sel=3" SEVERITY error;    
		WAIT; --wait forever!!
  	END PROCESS;
END sim;

