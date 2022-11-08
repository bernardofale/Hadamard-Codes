-- Imports
LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.simpleLogic.all;

LIBRARY control;
USE control.control.all;

LIBRARY storeDev;
USE storeDev.storeDev.all;

-- Entity declaration
ENTITY encoder_serial IS
    PORT(
        nGRst: IN STD_LOGIC;
        clk : IN STD_LOGIC;
        m : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        x : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        v : OUT STD_LOGIC;
    );
END encoder_serial;

-- Encoder serial
ARCHITECTURE structure of encoder_serial is
    -- Signals
    SIGNAL s_NSetO, s_NRst, s_Q, clkO, s_and_v, s_or_v: STD_LOGIC;
    SIGNAL count:  STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL s_Q8, s_and2xor, s_xorIn, s_xorOut, s_k, s_code: STD_LOGIC_VECTOR (7 DOWNTO 0);

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

    COMPONENT gateAnd8
    PORT(
        x0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        x1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT gateXor8
    PORT(
        x0 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        x1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
    END COMPONENT;

    COMPONENT parReg_8bit 
    PORT(
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
        nRst : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        addr : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        nRst : OUT STD_LOGIC;
        nSet0 : OUT STD_LOGIC;
        clk0 : OUT STD_LOGIC;
    );
    END COMPONENT;

    -- Instances
BEGIN
    flipFlop:  flipFlopDPET PORT MAP (clk, mIn, '1', s_NRst, s_Q);
    s_Q8 <= (OTHERS=>s_Q);
    and8: gateAnd8 PORT MAP (s_Q8, s_k, s_and2xor);
    xor8: gateXor8 PORT MAP (s_and2xor, s_xorIn, s_xorOut);
    ParReg8:  ParReg_8bit PORT MAP ('1', s_NRst, clk, s_xorOut, s_xorIn);
    binCounter3:   binCounter_3bit PORT MAP (s_NRst, clk, count);
    control:  control  PORT MAP (nGRst, clk, count, s_NRst, s_NSetO, s_k, clkO);
    ParReg8O: ParReg_8bit PORT MAP (s_NSetO, '1', clkO, s_xorOut, s_code);

    -- Outputs
    code <= s_code;
    s_and_v: gateAnd2(count(2), count(1));
    s_or_v: gateOr2(s_and_v, clkO, v);
END structure;
    