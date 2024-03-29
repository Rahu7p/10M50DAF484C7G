LIBRARY	ieee;
USE	ieee.std_logic_1164.ALL;

ENTITY mux_4to1 IS
	PORT(
    		x0, x1, x2, x3	:  IN	std_logic;
    		sel		:  IN	std_logic_vector( 1 DOWNTO 0 );
   		y		:  OUT	std_logic 
	);
END ENTITY;

ARCHITECTURE dataflow OF mux_4to1 IS
BEGIN
	y <=	x3 WHEN sel = "11" ELSE
        	x2 WHEN sel = "10" ELSE
		x1 WHEN sel = "01" ELSE
		x0;
END ARCHITECTURE;
