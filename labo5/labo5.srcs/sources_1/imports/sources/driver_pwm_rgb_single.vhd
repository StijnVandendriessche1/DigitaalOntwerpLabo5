----------------------------------------------------------------------------------
-- Company: DRAMCO -- KU Leuven
-- Students: firstname lastname and other guy/girl/...
-- 
-- Module Name: driver_pwm_rgb_single - Behavioral
-- Course Name: Lab Digital Design
--
-- Description: 
--  PWM RGB LED driver
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

entity driver_pwm_rgb_single is
    generic(
          C_F_CLK : natural := 50000000;  -- system clock frequency
        C_F_COUNT : natural := 250000     -- count pulse frequency
    );
    port(
          clk : in  std_logic;                     -- system clock input
        reset : in  std_logic;                     -- async. system reset
         regR : in  std_logic_vector(7 downto 0);  -- PWM red value
         regG : in  std_logic_vector(7 downto 0);  -- PWM green value
         regB : in  std_logic_vector(7 downto 0);  -- PWM blue value
          rgb : out std_logic_vector(2 downto 0)   -- rgb output
    );
end driver_pwm_rgb_single;

architecture Behavioral of driver_pwm_rgb_single is
    constant C_REFRESH_COUNT_MAX : integer := (C_F_CLK / C_F_COUNT) - 1;
    constant C_BIT_RED : natural := 0;
    constant C_BIT_GREEN : natural := 1;
    constant C_BIT_BLUE : natural := 2;

    signal pulse_count_i : std_logic := '0';
    signal pulse_counter_i : std_logic_vector(7 downto 0) := (others=>'0');
    signal rgb_count_i : std_logic_vector(7 downto 0) := (others=>'0');
    signal zero : std_logic_vector(7 downto 0) := (others=>'0');

begin


    -- TODO: write process to generate a count pulse
    gen_count_pulse:process(clk, reset) is
    begin
        if(reset = '1') then
            pulse_counter_i <= zero;
        else
            if(rising_edge(clk)) then
                if(pulse_counter_i = C_REFRESH_COUNT_MAX) then
                    pulse_counter_i <= zero;
                    pulse_count_i <= '1';
                else 
                    pulse_counter_i <= pulse_counter_i + 1;
                    pulse_count_i <= '0';
                end if;
            end if;
        end if;
    end process;
    
    -- TODO: write a process to increase rgb_count_i on every count pulse
    gen_rgb_count:process(pulse_count_i, reset) is
    begin
        if(reset = '1') then
            rgb_count_i <= zero;
        else
            if(rising_edge(pulse_count_i)) then
                rgb_count_i <= rgb_count_i + 1;
            end if;
        end if;
    end process;

    -- TODO: generate pwm output signals based on rgb_count_i and regR/G/B inputs (no process!)
    rgb(C_BIT_RED) <= '0' when rgb_count_i > regR else '1';
    rgb(C_BIT_GREEN) <= '0' when rgb_count_i > regG else '1';
    rgb(C_BIT_BLUE) <= '0' when rgb_count_i > regB else '1';

end Behavioral;
