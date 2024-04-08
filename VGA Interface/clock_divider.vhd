LIBRARY 	ieee;
USE 		ieee.std_logic_1164.all;
USE 		ieee.std_logic_unsigned.all;

ENTITY clock_divider IS
   PORT( 
		clk, rst	:	IN  STD_LOGIC;
      		clk_out		: 	OUT STD_LOGIC 
	);
END clock_divider;


ARCHITECTURE behavior OF clock_divider IS
	SIGNAL count : POSITIVE;
	SIGNAL tmp   : STD_LOGIC := '0';
BEGIN
	PROCESS( clk, rst )
	BEGIN
		IF rst = '0' THEN 
			count <= 1; 
			tmp   <= '0';
		ELSIF rising_edge( clk ) THEN
			count <= count + 1;
			-- ( 50MHz/1Hz ) * 0.5 
			IF( count = 25000000 ) THEN
				tmp   <= NOT tmp;
				count <= 1;
			END IF;
		END IF;
		clk_out <= tmp;
	END PROCESS;
END behavior;
