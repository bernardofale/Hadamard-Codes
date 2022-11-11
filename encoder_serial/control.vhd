LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY contMem IS
  PORT (
        -- from bin counter 3 bits 
        add:  IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        -- output from contMem
        dOut: OUT STD_LOGIC_VECTOR (10 DOWNTO 0));
END contMem;

ARCHITECTURE behavior OF contMem IS
BEGIN
  PROCESS (add)
    TYPE CMem IS ARRAY(0 TO 7) OF STD_LOGIC_VECTOR (10 DOWNTO 0);
    VARIABLE prog: CMem := (CONV_STD_LOGIC_VECTOR (16#5#, 11),    -- nRst = 1   nSetO = 0   nEnClk = 1   Start      00000000|101
                            CONV_STD_LOGIC_VECTOR (16#7FF#, 11),  -- nRst = 1   nSetO = 1   nEnClk = 1   M4         11111111|111
                            CONV_STD_LOGIC_VECTOR (16#7F#, 11),   -- nRst = 1   nSetO = 1   nEnClk = 1   M3         00001111|111
                            CONV_STD_LOGIC_VECTOR (16#19F#, 11),  -- nRst = 1   nSetO = 1   nEnClk = 1   M2         00110011|111       
                            CONV_STD_LOGIC_VECTOR (16#2AE#, 11),  -- nRst = 1   nSetO = 1   nEnClk = 0   M1         01010101|110
                            CONV_STD_LOGIC_VECTOR (16#6#, 11),    -- nRst = 1   nSetO = 1   nEnClk = 0   REZ        00000000|110
                            CONV_STD_LOGIC_VECTOR (16#1#, 11),    -- nRst = 0   nSetO = 0   nEnClk = 1   RESET      00000000|001
									 CONV_STD_LOGIC_VECTOR (16#7#, 11)     -- nRst = 1   nSetO = 1   nEnClk = 1   NOP        00000000|111
                            );  
                            
    VARIABLE pos: INTEGER;
  BEGIN
    pos := CONV_INTEGER (add);
    dOut <= prog(pos);
  END PROCESS;
END behavior;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY simpleLogic;
USE simpleLogic.all;

ENTITY control IS
  PORT (nGRst: IN STD_LOGIC;
        clk:   IN STD_LOGIC;
        add:   IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        nRst:  OUT STD_LOGIC;
        nSetO: OUT STD_LOGIC;
        clkO:  OUT STD_LOGIC;
        y:     OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END control;

ARCHITECTURE structure OF control IS
  SIGNAL cLines: STD_LOGIC_VECTOR (10 DOWNTO 0);
  SIGNAL iNRst, iNSetO: STD_LOGIC;
  COMPONENT contMem
    PORT (add:  IN STD_LOGIC_VECTOR (2 DOWNTO 0);
          dOut: OUT STD_LOGIC_VECTOR (10 DOWNTO 0));
  END COMPONENT;
  COMPONENT gateNand2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
  COMPONENT gateNor2
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
  END COMPONENT;
BEGIN
  cMem: contMem   PORT MAP (add, cLines);
  nad1: gateNand2 PORT MAP (nGRst, cLines(2), iNRst);
  nad2: gateNand2 PORT MAP (clk, iNRst, nRst);
  nad3: gateNand2 PORT MAP (nGRst, cLines(1), iNSetO);
  nad4: gateNand2 PORT MAP (clk, iNSetO, nSetO);
  nord: gateNor2  PORT MAP (clk, cLines(0), clkO);
  y <= cLines(10 DOWNTO 3);
END structure;
