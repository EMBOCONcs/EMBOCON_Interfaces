-------------------------------------------------------------------------------
-- bfm_system_tb.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

-- START USER CODE (Do not remove this line)

-- User: Put your libraries here. Code in this
--       section will not be overwritten.

-- END USER CODE (Do not remove this line)

entity bfm_system_tb is
end bfm_system_tb;

architecture STRUCTURE of bfm_system_tb is

  constant sys_clk_PERIOD : time := 10000.000000 ps;

  component bfm_system is
    port (
      sys_reset : in std_logic;
      sys_clk : in std_logic
    );
  end component;

  -- Internal signals

  signal sys_clk : std_logic;
  signal sys_reset : std_logic;

  -- START USER CODE (Do not remove this line)

  -- User: Put your signals here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

begin

  dut : bfm_system
    port map (
      sys_reset => sys_reset,
      sys_clk => sys_clk
    );

  -- Clock generator for sys_clk

  process
  begin
    sys_clk <= '0';
    loop
      wait for (sys_clk_PERIOD/2);
      sys_clk <= not sys_clk;
    end loop;
  end process;

  -- START USER CODE (Do not remove this line)

  -- User: Put your stimulus here. Code in this
  --       section will not be overwritten.

  -- END USER CODE (Do not remove this line)

end architecture STRUCTURE;

