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
    ...

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
    ff: flipFlopDPET PORT MAP(clk, mIn, '1', iNRst, s_Q);
    s_Qto8 <= (OTHERS => s_Q);
    and8: gateAnd8 PORT MAP(s_Qto8, s_k, s_andToXor); 
    xor8: gateXor8 PORT MAP(s_andToXor, s_xorIn, s_xorOut);
    ...
END structure;
    