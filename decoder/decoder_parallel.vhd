-- DECODER_PARALLEL
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY decoder_parallel IS
	PORT( 	y: IN STD_LOGIC_VECTOR(8 DOWNTO 0);
			m: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
			v: OUT STD_LOGIC);
END decoder_parallel;

ARCHITECTURE structure OF decoder_parallel IS

		-- signals



        -- gate components
		COMPONENT gateXor2
		PORT( 	x0: IN STD_LOGIC;
				x1: IN STD_LOGIC;
				y: OUT STD_LOGIC);
		END COMPONENT;

		COMPONENT gateNot
		PORT( 	x: IN STD_LOGIC;
				y: OUT STD_LOGIC);
		END COMPONENT;

		COMPONENT gateAnd2
		PORT( 	x0: IN STD_LOGIC;
				x1: IN STD_LOGIC;
				y: OUT STD_LOGIC);
		END COMPONENT;

		COMPONENT gateOr2
		PORT( 	x0: IN STD_LOGIC;
				x1: IN STD_LOGIC;
				y: OUT STD_LOGIC);
		END COMPONENT;

		COMPONENT gateAnd4
		PORT( 	x0: IN STD_LOGIC;
				x1: IN STD_LOGIC;
				x2: IN STD_LOGIC;
				x3: IN STD_LOGIC;
				y: OUT STD_LOGIC);
		END COMPONENT;

		COMPONENT gateConc4
		PORT( 	x0: IN STD_LOGIC;
				x1: IN STD_LOGIC;
				x2: IN STD_LOGIC;
				x3: IN STD_LOGIC;
				y: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
		END COMPONENT;

BEGIN

		-- m computation
		mc0 : gateXor2 PORT MAP(y(0), y(1), mc(0));
		mc1 : gateXor2 PORT MAP(y(2), y(3), mc(1));
		mc2 : gateXor2 PORT MAP(y(4), y(5), mc(2));
		mc3 : gateXor2 PORT MAP(y(6), y(7), mc(3));



