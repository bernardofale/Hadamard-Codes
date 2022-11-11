LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY encoder_parallel IS
  PORT (m: IN STD_LOGIC_VECTOR(3 downto 0);
        x:   OUT STD_LOGIC_VECTOR(7 downto 0));
END encoder_parallel;

ARCHITECTURE structure of encoder_parallel IS
SIGNAL sig0,sig1,sig2,sig3,sig4,sig5,sig6,sig7: STD_LOGIC;
BEGIN	
	sig0 <= m(0); 				-- x0 = m4
	sig1 <= m(3) xor sig0;	-- x1 = m1 XOR x0
	sig2 <= m(2) xor sig0;	-- x2 = m2 XOR x0
	sig3 <= m(3) xor sig2;	-- x3 = m1 XOR x2 
	sig4 <= m(1) xor sig0;  -- x4 = m3 XOR x0
	sig5 <= m(3) xor sig4;	-- x5 = m1 XOR x4
	sig6 <= m(2) xor sig4;  -- x6 = m2 XOR x4
	sig7 <= m(3) xor sig6;	-- x7 = m1 XOR x6
	
	x <= sig0 & sig1 & sig2 & sig3 & sig4 & sig5 & sig6 & sig7; 

END structure;