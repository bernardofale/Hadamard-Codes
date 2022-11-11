-- Logic needed to implement the parallel decoder
-- AND2
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAND2 IS
	PORT (x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateAND2;

ARCHITECTURE logicFunction OF gateAND2 IS
BEGIN
  y <= x1 AND x0;
END logicFunction;

-- AND3
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAND3 IS
	PORT (x2, x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateAND3;

ARCHITECTURE logicFunction OF gateAND3 IS
BEGIN
  y <= x2 AND x1 AND x0;
END logicFunction;

-- AND4
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAND4 IS
	PORT (x3, x2, x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateAND4;

ARCHITECTURE logicFunction OF gateAND4 IS
BEGIN
  y <= x3 AND x2 AND x1 AND x0;
END logicFunction;

-- OR4
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOR4 IS
  PORT (x3, x2, x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateOR4;

ARCHITECTURE logicFunction OF gateOR4 IS
BEGIN
  y <= x3 OR x2 OR x1 OR x0;
END logicFunction;

-- OR3
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOR3 IS
  PORT (x2, x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateOR3;

ARCHITECTURE logicFunction OF gateOR3 IS
BEGIN
  y <= x2 OR x1 OR x0;
END logicFunction;

-- XOR2
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXOR2 IS
  PORT (x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateXOR2;

ARCHITECTURE logicFunction OF gateXOR2 IS
BEGIN
  y <= x1 XOR x0;
END logicFunction;

-- XOR3
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXOR3 IS
  PORT (x2, x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateXOR3;

ARCHITECTURE logicFunction OF gateXOR3 IS
BEGIN
  y <= x2 XOR x1 XOR x0;
END logicFunction;

-- XOR4
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXOR4 IS
  PORT (x3, x2, x1, x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateXOR4;

ARCHITECTURE logicFunction OF gateXOR4 IS
BEGIN
  y <= x3 XOR x2 XOR x1 XOR x0;
END logicFunction;

-- NOT
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNOT IS
  PORT (x0: IN STD_LOGIC;
        y: OUT STD_LOGIC);
END gateNOT;

ARCHITECTURE logicFunction OF gateNOT IS
BEGIN
  y <= NOT x0;
END logicFunction;

