----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: Jef Jacobs & Stijn Vandendriessche
-- 
-- Module Name: program_counter - Behavioral
-- Course Name: Lab Digital Design
-- 
-- Description: 
--  An n-bit program counter module. The count step is set during instantiation.
--  A new count value can be loaded synchronously (le). Reset is asynchronous.
--  For a synchronous reset -> load "00..0"
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity program_counter is
    generic(
        C_PC_WIDTH : natural := 8;
         C_PC_STEP : natural := 2
    );
    port(
               clk : in  std_logic;
             reset : in  std_logic; -- async. reset
                up : in  std_logic; -- synch. count up
                le : in  std_logic; -- synch. load enable
             pc_in : in  std_logic_vector(C_PC_WIDTH-1 downto 0); -- parallel data in
            pc_out : out std_logic_vector(C_PC_WIDTH-1 downto 0)  -- parallel data out
    );
end program_counter;

architecture Behavioral of program_counter is
    -- TODO: (optionally) declare signals
    signal Q_i : std_logic_vector(C_PC_WIDTH-1 downto 0) := (others => '0');
    signal pc_step : std_logic_vector(integer(ceil(log2(real(C_PC_STEP+1)))) downto 0);
begin
    -- TODO: write VHDL process
    pc_out <= Q_i;
    pc_step <= std_logic_vector(to_unsigned(C_PC_STEP, pc_step'length));
    -- tussen de haakjes (sensitivity list) -> enkel de signalen die een invloed hebben op het proces
    count_process:process(reset, clk) is
    begin
        if(reset='1') then
            Q_i <= (others => '0');
        elsif(rising_edge(clk)) then
            if(up='1') then
                Q_i <= Q_i + pc_step;
            else
                if(le='1') then
                    Q_i <= pc_in;
                end if;
            end if;
        end if;     
    end process;

end Behavioral;
