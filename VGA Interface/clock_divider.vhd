LIBRARY 	ieee;
USE 		ieee.std_logic_1164.all;
USE 		ieee.numeric_std.all;

ENTITY clock_divider IS
   PORT( 
		clk, rst:	IN  std_logic;
     	clk_out	: 	OUT std_logic 
	);
END ENTITY;

ARCHITECTURE behavioral OF clock_divider IS
	
	SIGNAL count : positive;
	SIGNAL tmp   : std_logic := '0';

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
	
END ARCHITECTURE;
