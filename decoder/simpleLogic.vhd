-- AND2
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd2 IS
	PORT (x0, x1: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateAnd2;

ARCHITECTURE logicFunction OF gateAnd2 IS
BEGIN
  y <= x0 AND x1;
END logicFunction;

-- NAND2
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNand2 IS
  PORT (x0, x1: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateNand2;

ARCHITECTURE logicFunction OF gateNand2 IS
BEGIN
  y <= NOT (x0 AND x1);
END logicFunction;

-- NOR2
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNor2 IS
  PORT (x0, x1: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateNor2;

ARCHITECTURE logicFunction OF gateNor2 IS
BEGIN
  y <= NOT (x0 OR x1);
END logicFunction;

-- OR2
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOr2 IS
  PORT (x0, x1: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateOr2;

ARCHITECTURE logicFunction OF gateOr2 IS
BEGIN
  y <= x0 OR x1;
END logicFunction;

-- XOR2
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXOr2 IS
  PORT (x0, x1: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateXOr2;

ARCHITECTURE logicFunction OF gateXOr2 IS
BEGIN
  y <= x0 XOR x1;
END logicFunction;

-- AND4
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd4 IS
  PORT (x0, x1, x2, x3: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateAnd4;

ARCHITECTURE logicFunction OF gateAnd4 IS
BEGIN
  y <= x0 AND x1 AND x2 AND x3;
END logicFunction;

-- NOT
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNot IS
  PORT (x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateNot;

ARCHITECTURE logicFunction OF gateNot IS
BEGIN
  y <= NOT x0;
END logicFunction;

-- CONCATENATE4
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateConc4 IS
  PORT (x0, x1, x2, x3: IN STD_LOGIC;
        y: OUT STD_LOGIC_VECTOR(3 downto 0));
END gateConc4;

ARCHITECTURE logicFunction OF gateConc4 IS
BEGIN
  y <= x0 & x1 & x2 & x3;
END logicFunction;

-- CONCATENATE8
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateConc8 IS
  PORT (x0, x1, x2, x3, x4, x5, x6, x7: IN STD_LOGIC;
        y: OUT STD_LOGIC_VECTOR(7 downto 0));
END gateConc8;

ARCHITECTURE logicFunction OF gateConc8 IS
BEGIN
  y <= x0 & x1 & x2 & x3 & x4 & x5 & x6 & x7;
END logicFunction;
