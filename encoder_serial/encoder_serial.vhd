-- Imports
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

LIBRARY control;
USE control.all;

LIBRARY storeDev;
USE storeDev.all;

-- Entity declaration
ENTITY encoder_serial IS
    PORT(
        nGRst: IN STD_LOGIC;
        clk : IN STD_LOGIC;
        m : IN STD_LOGIC;
        x : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
END encoder_serial;

-- Encoder serial
ARCHITECTURE structure of encoder_serial is

    -- Components
    COMPONENT flipFlopDPET
    PORT(
        clk : IN STD_LOGIC;
        D : IN STD_LOGIC;
        nSet : IN STD_LOGIC;
        nRst : IN STD_LOGIC;
        Q : OUT STD_LOGIC;
        nQ : OUT STD_LOGIC
    );
    END COMPONENT;
	 
	 COMPONENT gateAnd2
    PORT(
        x1 : IN STD_LOGIC;
        x2 : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
    END COMPONENT;
	 
	 COMPONENT gateOr2
    PORT(
        x1 : IN STD_LOGIC;
        x2 : IN STD_LOGIC;
        y : OUT STD_LOGIC
    );
    END COMPONENT;


    COMPONENT gateAnd8
    PORT(
        x1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        x2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT gateXor8
    PORT(
        x1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        x2 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT parReg_8bit 
    PORT(
		  nSet: IN STD_LOGIC;
        nRst: IN STD_LOGIC;
        clk: IN STD_LOGIC;
        D: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        Q: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT binCounter_3bit
    PORT(
        nRst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        c : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT control
    PORT(
        nGRst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        add : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        nRst : OUT STD_LOGIC;
        nSetO : OUT STD_LOGIC;
        clkO : OUT STD_LOGIC;
		  y	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;
	 
	  -- Signals
    SIGNAL s_NSetO, s_NRst, s_Q, clkO: STD_LOGIC;
    SIGNAL count:  STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL s_Q8, s_and2xor, s_xorIn, s_xorOut, s_k, s_code: STD_LOGIC_VECTOR (7 DOWNTO 0);

    -- Instances
BEGIN
    flipFlop:  flipFlopDPET PORT MAP (clk, m, '1', s_NRst, s_Q);
    s_Q8 <= (OTHERS=>s_Q);
    and8: gateAnd8 PORT MAP (s_Q8, s_k, s_and2xor);
    xor8: gateXor8 PORT MAP (s_and2xor, s_xorIn, s_xorOut);
    ParReg8:  ParReg_8bit PORT MAP ('1', s_NRst, clk, s_xorOut, s_xorIn);
    binCounter3:   binCounter_3bit PORT MAP (s_NRst, clk, count);
    control_unit:  control  PORT MAP (nGRst, clk, count, s_NRst, s_NSetO, clkO, s_k);
    ParReg8O: ParReg_8bit PORT MAP (s_NSetO, '1', clkO, s_xorOut, s_code);

    -- Output
    x <= s_code;

END structure;
    