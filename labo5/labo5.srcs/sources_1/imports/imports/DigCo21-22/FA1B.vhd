----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: firstname lastname and other guy/girl/...
-- 
-- Module Name: FA1B - Behavioral
-- Course Name: Lab Digital Design
--
-- Description:
--  Full adder (1-bit)
--
----------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FA1B IS 
	PORT(
		-- TODO: complete entity declaration
		a : in  std_logic;
		b : in std_logic;
		cin : in std_logic;
		cout : out std_logic;
		f : out std_logic
	);
END entity;

ARCHITECTURE LDD1 OF FA1B IS
BEGIN
	-- TODO: complete architecture
	f <= cin xor (a xor b);
	cout <= (cin and (a xor b)) or (a and b);
END LDD1;

