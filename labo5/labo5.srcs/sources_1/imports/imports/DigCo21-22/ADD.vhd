----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: firstname lastname and other guy/girl/...
-- 
-- Module Name: ADD - Structural
-- Course Name: Lab Digital Design
--
-- Description:
--  n-bit ripple carry adder
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ADD is
	generic(
       C_DATA_WIDTH : natural := 4
	);
	port(
                a : in  std_logic_vector((C_DATA_WIDTH-1) downto 0); -- input var 1
                b : in  std_logic_vector((C_DATA_WIDTH-1) downto 0); -- input var 2
         carry_in : in  std_logic;                                   -- input carry
           result : out std_logic_vector((C_DATA_WIDTH-1) downto 0); -- alu operation result
        carry_out : out std_logic                                    -- carry
	);
end entity;

architecture LDD1 of ADD is
    
	-- TODO: list of signals and signal
	-- signals
	signal c_i : std_logic_vector (C_DATA_WIDTH downto 0) := (others => '0');
	
	-- components
    component FA1B IS 
	PORT(
		-- TODO: complete entity declaration
		a : in  std_logic;
		b : in std_logic;
		cin : in std_logic;
		cout : out std_logic;
		f : out std_logic
	);
    END component;

begin
	-- TODO: complete architecture description
	ripple_carry_adder:
   for i in 0 to C_DATA_WIDTH-1 generate
   begin
   single_bit : FA1B
        PORT map(
            -- TODO: complete entity declaration
            a => a(i),
            b => b(i),
            cin => c_i(i),
            cout => c_i(i+1),
            f => result(i)
        );
   end generate;
   
   c_i(0) <= carry_in;
   carry_out <= c_i(C_DATA_WIDTH);
   
			
	
	
	
end LDD1;
