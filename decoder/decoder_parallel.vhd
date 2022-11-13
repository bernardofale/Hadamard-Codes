LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

--Decoder to find particular bit in m
ENTITY bit_decoder IS 
	PORT(	y7, y6, y5, y4, y3, y2, y1, y0: IN STD_LOGIC; --Message bits
			o: OUT STD_LOGIC;  --Output bit
			v: OUT STD_LOGIC); --Validation bit
END bit_decoder;

ARCHITECTURE structure OF bit_decoder IS
	--Components that the bit decoder utilizes are XOR2 Gates, AND3 gates, OR4 gates, and NOT gates

	COMPONENT gateAND3 
		PORT (x2, x1, x0 : IN STD_LOGIC;
				y : OUT STD_LOGIC);
	END COMPONENT;


	COMPONENT gateOR4
		PORT (x3, x2, x1, x0 : IN STD_LOGIC;
				y : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateXOR2 
		PORT (x1, x0 : IN STD_LOGIC;
				y : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT gateNOT
		PORT (x0 : IN STD_LOGIC;
				y : OUT STD_LOGIC);
	END COMPONENT;
	
	--Signals
	
	SIGNAL m : STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL m0_and1, m0_and2, m0_and3, m0_and4 : STD_LOGIC; --Used for boolean function of zeros
	SIGNAL m1_and1, m1_and2, m1_and3, m1_and4 : STD_LOGIC; --Used for boolean function of ones
	SIGNAL m_zero, m_one 							: STD_LOGIC; --Particular bit, used for output bit and for the validation bit
	SIGNAL not_x0, not_x1, not_x2, not_x3 		: STD_LOGIC; 
	
	
	BEGIN
		
		--First step, assign pair (4 in total) for each i (in m).
		x0 : gateXOR2 PORT MAP (y0, y1, m(0));
		x1 : gateXOR2 PORT MAP (y2, y3, m(1));
		x2 : gateXOR2 PORT MAP (y4, y5, m(2));
		x3 : gateXOR2 PORT MAP (y6, y7, m(3));
		
		--Second step, assert the value of a particular bit using the majority rule
			--Compute zeros 
		
		notx0 : gateNOT PORT MAP (m(0), not_x0); 
		notx1 : gateNOT PORT MAP (m(1), not_x1); 
		notx2 : gateNOT PORT MAP (m(2), not_x2); 
		notx3 : gateNOT PORT MAP (m(3), not_x3); 		m0and1 : gateAND3 PORT MAP (not_x3, not_x1, not_x0, m0_and1);
		m0and2 : gateAND3 PORT MAP (not_x3, not_x2, not_x1, m0_and2);
		m0and3 : gateAND3 PORT MAP (not_x2, not_x1, not_x0, m0_and3);
		m0and4 : gateAND3 PORT MAP (not_x3, not_x2, not_x0, m0_and4);
			
			--Compute ones
			
		m1and1 : gateAND3 PORT MAP (m(3), m(2), m(0), m1_and1);
		m1and2 : gateAND3 PORT MAP (m(2), m(1), m(0), m1_and2);
		m1and3 : gateAND3 PORT MAP (m(3), m(1), m(0), m1_and3);
		m1and4 : gateAND3 PORT MAP (m(3), m(2), m(1), m1_and4);
		
		--Third step, compute value bit and validty bit
		mzero : gateOR4 PORT MAP (m0_and1, m0_and2, m0_and3, m0_and4, m_zero);
		mone  : gateOR4 PORT MAP (m1_and1, m1_and2, m1_and3, m1_and4, m_one );
		mv 	: gateXOR2 PORT MAP(m_zero, m_one, v);
		
		--Fourth step, copy to output value
		o <= m_one;
	
END structure;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

--Parallel decoder
ENTITY decoder_parallel IS
	PORT( 	y: IN STD_LOGIC_VECTOR(7 DOWNTO 0); --Encoded message
				m: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --Decoded message
				v: OUT STD_LOGIC); --Code validation bit
END decoder_parallel;

ARCHITECTURE structure OF decoder_parallel IS

       --Components
		
		COMPONENT bit_decoder
			PORT (y7, y6, y5, y4, y3, y2, y1, y0 : IN STD_LOGIC;
					o								 		 : OUT STD_LOGIC;
					v										 : OUT STD_LOGIC);
		END COMPONENT;
		
		COMPONENT gateAND3 
			PORT (x2, x1, x0 : IN STD_LOGIC;
					y 			  		: OUT STD_LOGIC);
		END COMPONENT;
		
		COMPONENT gateAND2 
			PORT (x1, x0 : IN STD_LOGIC;
					y 			  		: OUT STD_LOGIC);
		END COMPONENT;
		
		COMPONENT gateOR3 
			PORT (x2, x1, x0 : IN STD_LOGIC;
					y 			  		: OUT STD_LOGIC);
		END COMPONENT;
		
		COMPONENT gateXOR4
			PORT (x3, x2, x1, x0 : IN STD_LOGIC;
					y 			  		: OUT STD_LOGIC);
		END COMPONENT;
		
		COMPONENT gateXOR2
			PORT (x1, x0 : IN STD_LOGIC;
					y 			  		: OUT STD_LOGIC);
		END COMPONENT;
		
		COMPONENT gateNOT
		PORT (x0 : IN STD_LOGIC;
				y : OUT STD_LOGIC);
		END COMPONENT;
	
		
		--Signals
			--Message particular and validation bits
		SIGNAL m4_b, m4_v: STD_LOGIC;
		SIGNAL m3_b, m3_v: STD_LOGIC;
		SIGNAL m2_b, m2_v: STD_LOGIC;
		SIGNAL m1_b, m1_v: STD_LOGIC;
		SIGNAL d1,d2,d3,d,d_n,c11,c12,c13,c14,c22,c23,c24,c32,c33,c34 : STD_LOGIC;
		SIGNAL frag1, frag2: STD_LOGIC;
 
BEGIN
	
		--Get particular bit 4 of m (Majority rule)
		m1: bit_decoder PORT MAP (y(0), y(1), y(2), y(3), y(4), y(5), y(6), y(7), m1_b, m1_v);
		
		--Get particular bit 3 of m (Majority rule)
		m2: bit_decoder PORT MAP (y(0), y(2), y(1), y(3), y(4), y(6), y(5), y(7), m2_b, m2_v);
		
		--Get particular bit 2 of m (Majority rule)
		m3: bit_decoder PORT MAP (y(0), y(4), y(1), y(5), y(2), y(6), y(3), y(7), m3_b, m3_v);
		
		--Get particular bit 1 of m (Nearest neighbour rule) 
		c_11: gateXOR2 PORT MAP(y(0), y(1), c11);
		
		c_12: gateXOR2 PORT MAP(y(2), y(3), c12);
		c_13: gateXOR2 PORT MAP(y(4), y(5), c13);
		c_14: gateXOR2 PORT MAP(y(6), y(7), c14);
		
		c_22: gateXOR2 PORT MAP(y(1), y(3), c22);
		c_23: gateXOR2 PORT MAP(y(4), y(6), c23);
		c_24: gateXOR2 PORT MAP(y(5), y(7), c24);
		
		c_32: gateXOR2 PORT MAP(y(1), y(5), c32);
		c_33: gateXOR2 PORT MAP(y(2), y(6), c33);
		c_34: gateXOR2 PORT MAP(y(3), y(7), c34);
		
		d_1 : gateXOR4 PORT MAP(c12, c13, c14, m1_b, d1); 
		d_2 : gateXOR4 PORT MAP(c22, c23, c24, m2_b, d2); 
		d_3 : gateXOR4 PORT MAP(c32, c33, c34, m3_b, d3);
		
		dist_n: gateOR3 PORT MAP(d1, d2, d3, d_n);
		dist : gateNOT PORT MAP(d_n, d);
		
		frag_1: gateXOR2 PORT MAP(c11, m1_b, frag1);
		frag_2: gateAND2 PORT MAP(d, frag1, frag2);
		
		m4  : gateXOR2 PORT MAP(frag2, y(0), m4_b);
		
				--Decoded message and validation bit
		validity : gateAND3 PORT MAP (m3_v, m2_v, m1_v, v);
		
		m <= m1_b & m2_b & m3_b & m4_b;

END structure;