LIBRARY  ieee;
USE      ieee.std_logic_1164.ALL;
USE      ieee.numeric_std.ALL;

--Entity: no port list!
ENTITY tb_ALU_2bits IS
END tb_ALU_2bits;

--Architecture
ARCHITECTURE test_arch OF tb_ALU_2bits IS

	COMPONENT ALU_2bits
		PORT( 
			a, b:	IN		std_logic_vector( 1 DOWNTO 0 );	
			w, x:	IN 	std_logic;
			s: 	OUT	std_logic_vector( 1 DOWNTO 0 )
		);
	END COMPONENT;
	
SIGNAL	a_tb, b_tb	:	std_logic_vector( 1 DOWNTO 0 );	--INPUT
SIGNAL	w_tb, x_tb  :	std_logic;								--INPUT
SIGNAL	s_tb			:	std_logic_vector( 1 DOWNTO 0 );	--OUTPUT
SIGNAL	expect		:	unsigned( 1 DOWNTO 0 ); 			--expected
BEGIN

	--DUT Instantiation
	DUT	:	ALU_2bits PORT MAP( a_tb, b_tb, w_tb, x_tb, s_tb );
	--Expected stimulus
	loop_proc	:	PROCESS
						VARIABLE i, j, k, l						: integer;
						VARIABLE a_var, b_var, w_vtb, x_vtb	: std_logic_vector(1 DOWNTO 0);
						BEGIN
							WAIT FOR 0 ns;
								FOR i IN 0 TO 3 LOOP
									a_var := std_logic_vector( to_unsigned( i, a_tb'LENGTH ));
									a_tb	<= a_var;
									FOR j IN 0 TO 3 LOOP
										b_var	:= std_logic_vector( to_unsigned( j, b_tb'LENGTH ));
										b_tb	<= b_var;
										FOR k IN 0 TO 1 LOOP
											w_vtb := std_logic_vector( to_unsigned( k, w_vtb'LENGTH ));
											w_tb	<= w_vtb(0);
											FOR l in 0 TO 1 LOOP
												x_vtb	:= std_logic_vector( to_unsigned( l, x_vtb'LENGTH ));
												x_tb	<= x_vtb(0);
												IF( w_vtb(0) = '1' and x_vtb(0) = '1' )THEN
													expect <= unsigned( a_var );
												ELSIF( w_vtb(0) = '1' and x_vtb(0) = '0' )THEN
													expect <= unsigned( a_var and b_var );
												ELSIF( w_vtb(0) = '0' and x_vtb(0) = '1' )THEN
													expect <= unsigned( a_var ) - unsigned( b_var );
												ELSE
													expect <= unsigned( a_var ) + unsigned( b_var );
												END IF;
												WAIT FOR 10 ns;
											END LOOP;
										END LOOP;
									END LOOP;
								END LOOP;
							WAIT;
						END PROCESS;
END ARCHITECTURE;
