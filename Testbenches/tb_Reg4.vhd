LIBRARY ieee;
USE		ieee.std_logic_1164.ALL;
USE		ieee.numeric_std.ALL;

ENTITY 	tb_Reg4 IS
END	 	tb_Reg4;

ARCHITECTURE testbench OF tb_Reg4 IS
	COMPONENT Reg4 IS
		PORT(
			clk, rst, ld	: IN  std_logic;
			I				: IN  std_logic_vector( 3 downto 0 );
			Q				: OUT std_logic_vector( 3 downto 0 )
		);
	END COMPONENT;
	
	SIGNAL	clk, rst, ld	: std_logic;
	SIGNAL	I, Q	 		: std_logic_vector( 3 downto 0 );
	SIGNAL	expect			: std_logic_vector( 3 downto 0 );
	SIGNAL	stop_clk		: std_logic := '0';

	BEGIN
		DUT	:	Reg4 PORT MAP( clk, rst, ld, I, Q );
		
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
		BEGIN
				rst <= '0'; ld <= '0'; 
				I <= "0000";
				expect <= "0000";
			WAIT UNTIL rising_edge( clk );
			ASSERT( Q = expect ) REPORT "Failed for I = "& integer'IMAGE( to_integer(unsigned(I)) ) SEVERITY error;
				rst <= '1'; ld <= '1';
				I   <= "0011";
				expect <= "0000";
			WAIT UNTIL rising_edge( clk );
			ASSERT( Q = expect ) REPORT "Failed for I = "& integer'IMAGE( to_integer(unsigned(I)) ) SEVERITY error;
				ld <= '0';
				I  <= "1111";
				expect <= "0011";
			WAIT UNTIL rising_edge( clk );
			ASSERT( Q = expect ) REPORT "Failed for I = "& integer'IMAGE( to_integer(unsigned(I)) ) SEVERITY error;
				ld <= '1';
				I  <= "1001";
			WAIT FOR 7 ns;
				rst <= '0';
				expect <= "0000";
			WAIT FOR 2 ns;
				rst <= '1';
			WAIT UNTIL rising_edge( clk );
			ASSERT( Q = expect ) REPORT "Failed for I = "& integer'IMAGE( to_integer(unsigned(I)) ) SEVERITY error;
				stop_clk <= '1';
				expect <= "1001";
			WAIT UNTIL rising_edge( clk );
			ASSERT( Q = expect ) REPORT "Failed for I = "& integer'IMAGE( to_integer(unsigned(I)) ) SEVERITY error;
			WAIT;
		END PROCESS;
		
END ARCHITECTURE;
