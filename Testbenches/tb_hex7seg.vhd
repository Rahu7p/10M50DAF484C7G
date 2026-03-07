LIBRARY ieee;
USE		  ieee.std_logic_1164.ALL;
USE		  ieee.numeric_std.ALL;

ENTITY tb_hex7seg IS
END	   tb_hex7seg;

ARCHITECTURE testbench OF tb_hex7seg IS

	COMPONENT hex7seg IS
		PORT ( 
			hex      : IN  std_logic_vector(3 downto 0);
			display  : OUT std_logic_vector(7 downto 0) 
		);
	END COMPONENT;
	
	SIGNAL	hex	 	  :	std_logic_vector( 3 downto 0 );
	SIGNAL	display	:	std_logic_vector( 7 downto 0 );
	SIGNAL	expect	:	std_logic_vector( 7 downto 0 );

	BEGIN
		DUT	:	hex7seg PORT MAP( hex, display );
		
		PROCESS
			TYPE disp_array is array ( 0 to 15 ) of std_logic_vector( 7 downto 0 );
			variable var_disp : disp_array := ( 	"11000000", "11111001", "10100100", "10110000", 
																"10011001", "10010010", "10000010", "11111000", 
																"10000000", "10010000", "10001000", "10000011", 
																"11000110", "10100001", "10000110", "10001110" );
		BEGIN
			FOR i IN 0 TO 15 LOOP 
				hex <= std_logic_vector( to_unsigned( i, 4 ) );
				expect <= var_disp( i );
				WAIT FOR 10 ns;
				ASSERT( display = expect ) REPORT "Failed for a = "& integer'IMAGE( i ) SEVERITY error;
			END LOOP;
			WAIT;
		END PROCESS;

END ARCHITECTURE;
