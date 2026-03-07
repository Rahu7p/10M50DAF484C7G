LIBRARY	ieee;
USE 		ieee.std_logic_1164.all;

-- Simple entity that connects your design with the FPGA pins
ENTITY DE10_Lite IS
	PORT(	
		MAX10_CLK_50	:	IN  std_logic;
		KEY				    :	IN	 std_logic_vector( 1 downto 0 );
		SW					  : 	IN  std_logic_vector( 9 downto 0 );
		LEDR				  :	OUT std_logic_vector( 9 downto 0 );
		HEX0				  :	OUT std_logic_vector( 7 downto 0 )
	);
END DE10_Lite;

ARCHITECTURE structural OF DE10_Lite IS

	COMPONENT UpCounter IS
		PORT(
    		clk, rst, cnt	:  IN	 std_logic;
    		C					:  OUT std_logic_vector( 3 downto 0 );
			tc					:  OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT hex7seg IS
		PORT ( 
			hex      : IN  std_logic_vector(3 downto 0);
			display  : OUT std_logic_vector(7 downto 0) 
		);
	END COMPONENT;
	
	COMPONENT clock_divider IS
		PORT( 
			clk, rst	:	IN  std_logic;
			clk_out	: 	OUT std_logic 
		);
	END COMPONENT;
	
BEGIN

	LEDR( 9 DOWNTO 1 ) <= ( OTHERS => '0' );

	
END structural;
