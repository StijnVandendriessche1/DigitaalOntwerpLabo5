----------------------------------------------------------------------------------
-- Institution: KU Leuven
-- Students: firstname lastname and other guy/girl/...
-- 
-- Module Name: register_file - Behavioral
-- Course Name: Lab Digital Design
--
-- Description:
--  Generic register file description. The number of registers and the data width
--  can be set with C_NR_REGS and C_DATA_WIDTH respectively.
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity register_file is
    generic(
        C_DATA_WIDTH : natural := 8;
           C_NR_REGS : natural := 8
    );
    port(
                 clk : in  std_logic;
               reset : in  std_logic;
                  le : in  std_logic;
              in_sel : in  std_logic_vector(C_NR_REGS-1 downto 0);
             out_sel : in  std_logic_vector(C_NR_REGS-1 downto 0);
             data_in : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
            data_out : out std_logic_vector(C_DATA_WIDTH-1 downto 0)
    );
end register_file;

architecture Behavioral of register_file is
    -- TODO: declare what will be used
    -- signal types
    type reg_out_array is array (0 to C_NR_REGS-1) of std_logic_vector(C_DATA_WIDTH-1 downto 0);
    type or_out_array is array(0 to C_NR_REGS-2) of std_logic_vector(C_DATA_WIDTH-1 downto 0);
    -- signals
    signal reg_array : reg_out_array;
    signal zero_vect : std_logic_vector(C_DATA_WIDTH-1 downto 0) := (others => '0');
    signal mux_array : reg_out_array;
    signal or_output : or_out_array;

    -- components
    component basic_register is
    generic(
        C_DATA_WIDTH : natural := 8
    );
    port(
                 clk : in  std_logic;
               reset : in  std_logic;
                  le : in  std_logic;
             data_in : in  std_logic_vector(C_DATA_WIDTH-1 downto 0);
            data_out : out std_logic_vector(C_DATA_WIDTH-1 downto 0)
    );
    end component;
begin
    -- TODO: describe how it's all connected and how it behaves
    GEN_REG:
        for I in 0 to C_NR_REGS-1 generate
            regI : basic_register port map
                (clk, reset, le and in_sel(I), data_in, reg_array(I));
    END generate GEN_REG;
    
    GEN_REG_OUT:
        for I in 0 to C_NR_REGS-1 generate
            with out_sel(I) select mux_array(I) <= reg_array(I) when '1', zero_vect when others;
            end generate GEN_REG_OUT;
            
    or_output(0) <= mux_array(1) or mux_array(0);
    GEN_DATA_OUT:
        for I in 1 to C_NR_REGS-2 generate
            or_output(I) <= mux_array(I+1) or or_output(I-1);
            end generate GEN_DATA_OUT;
    data_out <= or_output(C_NR_REGS-2);
            
end Behavioral;