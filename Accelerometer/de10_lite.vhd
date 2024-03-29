LIBRARY 	ieee;
USE		ieee.std_logic_1164.all;

ENTITY de10_lite IS
	PORT(	CLOCK_50	: IN	std_logic;
		KEY		: IN	std_logic_vector(1 DOWNTO 0);
		GSENSOR_INT	: IN	std_logic_vector(1 DOWNTO 0);
		GSENSOR_SDI	: INOUT	std_logic;
		GSENSOR_SDO	: INOUT	std_logic;
		GSENSOR_CS_N	: OUT	std_logic;
		GSENSOR_SCLK	: OUT	std_logic;
		LEDR		: OUT	std_logic_vector(9 DOWNTO 0)
	);
END;

ARCHITECTURE Structural OF de10_lite IS

COMPONENT reset_delay IS
	PORT( 	iRSTN	: IN std_logic;
		iCLK	: IN std_logic;
		oRST	: OUT	std_logic
	);
END COMPONENT;

COMPONENT spi_pll IS
	PORT( 	areset	: IN std_logic;
		inclk0	: IN std_logic;
		c0	: OUT	std_logic;
		c1	: OUT std_logic
	);
END COMPONENT;

COMPONENT spi_ee_config IS
	PORT( 	iRSTN		: IN std_logic;
		iSPI_CLK	: IN std_logic;
		iSPI_CLK_OUT	: IN	std_logic;
		iG_INT2		: IN std_logic;
		oDATA_L		: OUT std_logic_vector(7 DOWNTO 0);
		oDATA_H		: OUT std_logic_vector(7 DOWNTO 0);
		SPI_SDIO	: INOUT std_logic;
		oSPI_CSN	: OUT std_logic;
		oSPI_CLK	: OUT std_logic
	);
END COMPONENT;
 
COMPONENT led_driver IS
	PORT( 	iRSTN	: IN std_logic;
		iCLK	: IN std_logic;
		iDIG	: IN std_logic_vector(9 DOWNTO 0);
		iG_INT2	: IN std_logic;
		oLED	: OUT std_logic_vector(9 DOWNTO 0)
	);
END COMPONENT;

SIGNAL dly_rst: std_logic;
SIGNAL spi_clk: std_logic;
SIGNAL spi_clk_out: std_logic;
SIGNAL data_x:	std_logic_vector(15 DOWNTO 0);

BEGIN
				--Reset
reset		: reset_delay 	PORT MAP( KEY(0), CLOCK_50, dly_rst );

				--PLL
pll		: spi_pll 	PORT MAP( dly_rst, CLOCK_50, spi_clk, spi_clk_out );

				--Initial Setting and Data Read Back
spi_config	: spi_ee_config	PORT MAP( not dly_rst, spi_clk, spi_clk_out, GSENSOR_INT(0), data_x(7 DOWNTO 0), 
						data_x(15 DOWNTO 8), GSENSOR_SDI, GSENSOR_CS_N, GSENSOR_SCLK );

				--Led
led		: led_driver 	PORT MAP( not dly_rst, CLOCK_50, data_x(9 DOWNTO 0), GSENSOR_INT(0), LEDR );

END Structural;
