-- Figure 4.3 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY inv IS
    PORT (
        a : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END;
ARCHITECTURE synth OF inv IS
BEGIN
    y <= NOT a;
END;

-- Figure 4.4
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY gates IS
    PORT (
        a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        y1, y2, y3, y4,
        y5 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END;
ARCHITECTURE synth OF gates IS
BEGIN
    –– five different two - input logic gates
    –– acting ON 4 - BIT busses
    y1 <= a AND b;
    y2 <= a OR b;
    y3 <= a XOR b;
    y4 <= a NAND b;
    y5 <= a NOR b;
END;

-- Figure 4.5
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY and8 IS
    PORT (
        a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        y : OUT STD_LOGIC);
END;
ARCHITECTURE synth OF and8 IS
BEGIN
    y <= AND a;
    –– AND a IS much easier TO write than
    –– y <= a(7) AND a(6) AND a(5) AND a(4) AND
    –– a(3) AND a(2) AND a(1) AND a(0);
END;

-- Figure 4.6
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY mux2 IS
    PORT (
        d0, d1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s : IN STD_LOGIC;
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END;
ARCHITECTURE synth OF mux2 IS
BEGIN
    y <= d1 WHEN s ELSE
        d0;
END;

-- Figure 4.7
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY mux4 IS
    PORT (
        d0, d1,
        d2, d3 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END;
ARCHITECTURE synth1 OF mux4 IS
BEGIN
    y <= d0 WHEN s = "00" ELSE
        d1 WHEN s = "01" ELSE
        d2 WHEN s = "10" ELSE
        d3;
END;

-- 

ARCHITECTURE synth2 OF mux4 IS
BEGIN
    WITH s SELECT y <=
        d0 WHEN "00",
        d1 WHEN "01",
        d2 WHEN "10",
        d3 WHEN OTHERS;
END;

-- Figure 4.8
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY fulladder IS
    PORT (
        a, b, cin : IN STD_LOGIC;
        s, cout : OUT STD_LOGIC);
END;
ARCHITECTURE synth OF fulladder IS
    SIGNAL p, g : STD_LOGIC;
BEGIN
    p <= a XOR b;
    g <= a AND b;
    s <= p XOR cin;
    cout <= g OR (p AND cin);
END;

-- Figure 4.11
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY mux4 IS
    PORT (
        d0, d1,
        d2, d3 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        s : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END;
ARCHITECTURE struct OF mux4 IS
    COMPONENT mux2
        PORT (
            d0,
            d1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            s : IN STD_LOGIC;
            y : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;
    SIGNAL low, high : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    lowmux : mux2 PORT MAP(d0, d1, s(0), low);
    highmux : mux2 PORT MAP(d2, d3, s(0), high);
    finalmux : mux2 PORT MAP(low, high, s(1), y);
END;