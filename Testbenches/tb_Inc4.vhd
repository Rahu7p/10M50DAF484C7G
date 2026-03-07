LIBRARY ieee;
USE		  ieee.std_logic_1164.ALL;
USE		  ieee.numeric_std.ALL;

ENTITY tb_Inc4 IS
END	   tb_Inc4;

ARCHITECTURE testbench OF tb_Inc4 IS
	
  COMPONENT Inc4 IS
		PORT(
				a	:  IN	 std_logic_vector( 3 downto 0 );
				s	:  OUT std_logic_vector( 3 downto 0 ) 
		);
	END COMPONENT;
	
	SIGNAL	a	 		  :	std_logic_vector( 3 downto 0 );
	SIGNAL	s	 		  :	std_logic_vector( 3 downto 0 );
	SIGNAL	expect	:	std_logic_vector( 3 downto 0 );

	BEGIN
		DUT	:	Inc4 PORT MAP( a, s );
	
		PROCESS
			VARIABLE var_a : unsigned( 3 downto 0 );
		BEGIN
			FOR i IN 0 TO 15 LOOP 
				a <= std_logic_vector( to_unsigned( i, 4 ) );
				var_a := to_unsigned( i, 4 );
				expect <= std_logic_vector( var_a + 1 );
				WAIT FOR 10 ns;
				ASSERT( s = expect ) REPORT "Failed for a = "& integer'IMAGE( i ) SEVERITY error;
			END LOOP;
			WAIT;
		END PROCESS;

END ARCHITECTURE;
