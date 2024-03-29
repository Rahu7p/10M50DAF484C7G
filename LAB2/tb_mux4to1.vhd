LIBRARY ieee;
USE	ieee.std_logic_1164.ALL;

--Entity: no port list!
ENTITY  tb_mux_4to1 IS
END	tb_mux_4to1;

--Architecture
ARCHITECTURE test_arch OF tb_mux_4to1 IS
	COMPONENT mux_4to1
		PORT(
			x0, x1, x2, x3	:	IN	STD_LOGIC;
			sel		:	IN	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			y		:	OUT	STD_LOGIC
		);
	END COMPONENT;
	
SIGNAL	x0_tb, x1_tb, x2_tb, x3_tb	:	STD_LOGIC;			--INPUT
SIGNAL	sel_tb				:	STD_LOGIC_VECTOR( 1 DOWNTO 0 );	--INPUT
SIGNAL	y_tb				:	STD_LOGIC;			--OUTPUT
SIGNAL	expect				:	STD_LOGIC;			--expected

BEGIN
	--DUT Instantiation
	DUT		:	mux_4to1 PORT MAP( x0_tb, x1_tb, x2_tb, x3_tb, sel_tb, y_tb );
	
	--Stimulus by hand drawn waves, poor coverage
	stim_proc	:	PROCESS
			  		BEGIN
					WAIT FOR 0 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "00"; expect <= '0';
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "01"; expect <= '1';
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "10"; expect <= '0';
					WAIT FOR 10 ns;
						x0_tb <= '0'; x1_tb <= '1'; x2_tb <= '0'; x3_tb <= '1'; sel_tb <= "11"; expect <= '1';
					WAIT FOR 10 ns;
					WAIT;
				END PROCESS;
END ARCHITECTURE;
