LIBRARY 	ieee;
USE		    ieee.std_logic_1164.ALL, ieee.numeric_std.ALL;

ENTITY de10lite IS
	PORT(	
		CLOCK_50: IN	std_logic;
		KEY		  : IN 	std_logic_vector( 1 DOWNTO 0 );
		SW			: IN 	std_logic_vector( 9 DOWNTO 0 );
		HEX0		: OUT std_logic_vector( 7 DOWNTO 0 );
		LEDR		: OUT	std_logic_vector( 9 DOWNTO 0 )
	);
END de10lite;

ARCHITECTURE Structural OF de10lite IS	
	
	COMPONENT gumnut_with_mem IS
		GENERIC( 
			IMem_file_name	: string 	:= "gasm_text.dat";
			DMem_file_name : string 	:= "gasm_data.dat";
         debug 			: boolean	:= false 
		);
		PORT( 
			clk_i 			: IN 	std_logic;
         rst_i 			: IN 	std_logic;
         -- I/O port bus
         port_cyc_o 		: OUT	std_logic;
         port_stb_o 		: OUT std_logic;
         port_we_o 		: OUT std_logic;
         port_ack_i 		: IN 	std_logic;
         port_adr_o 		: OUT unsigned(7 DOWNTO 0);
         port_dat_o 		: OUT std_logic_vector(7 DOWNTO 0);
         port_dat_i 		: IN  std_logic_vector(7 DOWNTO 0);
         -- Interrupts
         int_req 			: IN  std_logic;
         int_ack 			: OUT std_logic
		);
	END COMPONENT gumnut_with_mem;
	
	COMPONENT hex7seg IS
		PORT ( 
			hex      : IN  std_logic_vector(3 downto 0);
			display  : OUT std_logic_vector(7 downto 0) 
		);
	END COMPONENT;
	
	SIGNAL clk_i, rst_i				: std_logic; 
	SIGNAL port_cyc_o, port_stb_o	: std_logic;
	SIGNAL port_we_o, port_ack_i	: std_logic;
	SIGNAL int_req, int_ack			: std_logic;
	SIGNAL port_adr_o					: unsigned(7 DOWNTO 0);
	SIGNAL port_dat_o, port_dat_i	: std_logic_vector(7 DOWNTO 0);
	SIGNAL display_7seg				: std_logic_vector( 3 DOWNTO 0 ) := "0000";
	SIGNAL key_i						: std_logic_vector( 7 DOWNTO 0 ) := "00000001";
	SIGNAL sw_i							: std_logic_vector( 7 DOWNTO 0 ) := "00000000";
	
BEGIN
	clk_i 				<= CLOCK_50;
	rst_i					<= not KEY( 0 );
	port_ack_i 		<= '1';
	int_req				<= '0';
	
	gumnut		: gumnut_with_mem 
						PORT MAP(
								clk_i, 
								rst_i, 
								port_cyc_o, 
								port_stb_o, 
								port_we_o, 
								port_ack_i, 
								port_adr_o,
								port_dat_o, 
								port_dat_i,
								int_req, 
								int_ack
						);
	
	display0_de10 : hex7seg
							PORT MAP(
								display_7seg,
								HEX0
							);
	
	-- OUTPUT LEDS => data memory address 0x00 --
	PROCESS( clk_i, rst_i )
		BEGIN
			IF rst_i = '1' THEN
				LEDR( 7 DOWNTO 0 ) <= ( OTHERS => '0' );
			ELSIF rising_edge( clk_i ) THEN 
				IF	port_adr_o = "00000000"	-- address port
					and
				   port_cyc_o = '1' 			-- control signals for I/O
					and 
					port_stb_o = '1' 			-- control signals for I/O
					and 
					port_we_o  = '1' 			-- 'write' operation
				THEN
					LEDR( 7 DOWNTO 0 ) <= port_dat_o;
				END IF;
			END IF;
	END PROCESS;
	
	LEDR(9 DOWNTO 8) 	<= ( OTHERS => '0' );
	
	-- OUTPUT HEX 0 => data memory address 0x01 --
	PROCESS( clk_i, rst_i )
		BEGIN
			IF rst_i = '1' THEN
				display_7seg <= ( OTHERS => '0' );
			ELSIF rising_edge( clk_i ) THEN 
				IF	port_adr_o = "00000001" -- address port 
					and
				   port_cyc_o = '1' 			-- control signals for I/O
					and 
					port_stb_o = '1' 		   -- control signals for I/O
					and 
					port_we_o  = '1' 			-- 'write' operation
				THEN
					display_7seg <= port_dat_o( 3 DOWNTO 0 );
				END IF;
			END IF;
	END PROCESS;							  
							  
	-- INPUT KEY1 => data memory address 0x02 --	
	PROCESS( clk_i, rst_i )
		BEGIN
			IF rst_i = '1' THEN
				key_i <= "00000001";
			ELSIF rising_edge( clk_i ) THEN 
				IF	port_adr_o = "00000010"	-- address port
					and
					port_cyc_o = '1' 			-- control signals for I/O
					and 
					port_stb_o = '1' 			-- control signals for I/O
					and 
					port_we_o  = '0' 			-- 'read' operation
				THEN
					key_i <= "0000000" & KEY(1);
				END IF;
			END IF;
	END PROCESS;
	
	-- INPUT SWITCHES => data memory address 0x03 --	
	PROCESS( clk_i, rst_i )
		BEGIN
			IF rst_i = '1' THEN
				sw_i <= ( OTHERS => '0' );
			ELSIF rising_edge( clk_i ) THEN 
				IF	port_adr_o = "00000011"	-- address port
					and
					port_cyc_o = '1' 			-- control signals for I/O
					and 
					port_stb_o = '1' 			-- control signals for I/O
					and 
					port_we_o  = '0' 			-- 'read' operation
				THEN
					sw_i <= SW( 7 DOWNTO 0 );
				END IF;
			END IF;
	END PROCESS;
	
	-- To select between different INPUTS --
	WITH port_adr_o SELECT
		port_dat_i <=   key_i WHEN "00000010",
						         sw_i WHEN "00000011",
					     UNAFFECTED WHEN     OTHERS;
						  
END Structural;
