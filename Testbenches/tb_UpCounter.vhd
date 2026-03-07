LIBRARY ieee;
USE		  ieee.std_logic_1164.ALL;
USE		  ieee.numeric_std.ALL;

ENTITY tb_UpCounter IS
END	   tb_UpCounter;

ARCHITECTURE testbench OF tb_UpCounter IS

	COMPONENT UpCounter IS
		PORT(
    		clk, rst, cnt	:  IN	 std_logic;
    		C				    	:  OUT std_logic_vector( 3 downto 0 );
			  tc					  :  OUT std_logic
		);
	END COMPONENT;
	
	SIGNAL	clk, rst, cnt, tc	: std_logic;
	SIGNAL	C		 				    : std_logic_vector( 3 downto 0 );
	SIGNAL	expect_C				: std_logic_vector( 3 downto 0 );
	SIGNAL	expect_tc			  : std_logic;
	SIGNAL	stop_clk				: std_logic := '0';

	BEGIN
		DUT	:	UpCounter PORT MAP( clk, rst, cnt, C, tc );
		
		PROCESS -- clock process
		BEGIN
			WHILE stop_clk = '0' LOOP
				clk <= '0';
            WAIT FOR 5 ns;
            clk <= '1';
            WAIT FOR 5 ns;
			END LOOP;
			WAIT;  -- stop the process
		END PROCESS;
	
		PROCESS
			VARIABLE var_a : unsigned( 3 downto 0 );
		BEGIN
				rst <= '0'; cnt <= '0'; 
				expect_C <= "0000";
				expect_tc <= '0';
			WAIT UNTIL rising_edge( clk );
				rst <= '1';
				cnt <= '1';
			FOR i IN 0 TO 14 LOOP 
				var_a := to_unsigned( i, 4 );
				expect_C <= std_logic_vector( var_a );
				WAIT UNTIL rising_edge( clk );
				ASSERT( C = expect_C ) REPORT "Failed for Count = "& integer'IMAGE( i ) SEVERITY error;
				ASSERT( tc = expect_tc ) REPORT "Failed for Count = "& integer'IMAGE( i ) SEVERITY error;
			END LOOP;	
				expect_C <= "1111";
				expect_tc <= '1';
				stop_clk <= '1';
			WAIT UNTIL rising_edge( clk );
			ASSERT( C = expect_C ) REPORT "Failed for Count = 15" SEVERITY error;
			ASSERT( tc = expect_tc ) REPORT "Failed for Count = 15" SEVERITY error;
			WAIT;
		END PROCESS;
		
END ARCHITECTURE;
