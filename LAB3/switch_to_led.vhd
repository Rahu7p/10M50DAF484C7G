LIBRARY	ieee;
USE 	ieee.std_logic_1164.all;

-- Simple entity that connects the SW switches to the LEDR lights
ENTITY switch_to_led IS
	PORT(	
		SW: 	IN 	std_logic_vector( 9 DOWNTO 0 );
		LEDR:	OUT 	std_logic_vector( 9 DOWNTO 0 )
	);
END switch_to_led;

ARCHITECTURE structural OF switch_to_led IS

	COMPONENT mux_4to1 IS
		PORT(
			x0, x1, x2, x3:	IN 	std_logic;
			sel:		IN	std_logic_vector( 1 DOWNTO 0 );
			y: 		OUT	std_logic 
		);
	END COMPONENT;

BEGIN
	LEDR( 9 DOWNTO 1 ) <= ( OTHERS => '0' );
	MUX:	mux_4to1 PORT MAP( SW(0), SW(1), SW(2), SW(3), SW(5 DOWNTO 4), LEDR(0) ); 
END structural;
