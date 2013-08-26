-- Version: release . Copyright (C) 2011 XILINX, Inc.

-------------------------------------------------------------------------------
-- Add.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Add_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Add_comb;

architecture rtl of ACMP_Add_comb is

    component AESL_Add is
      generic (
        NUM_STAGE : INTEGER := 1;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Add_U : component AESL_Add
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout); 
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Add is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Add;

architecture rtl of ACMP_Add is

    component AESL_Add is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Add_U : component AESL_Add
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout); 
end rtl;


-------------------------------------------------------------------------------
-- Sub.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Sub_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Sub_comb;

architecture rtl of ACMP_Sub_comb is
    component AESL_Sub is
      generic (
        NUM_STAGE : INTEGER := 1;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;
begin
    ACMP_Sub_U: component AESL_Sub
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Sub is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Sub;

architecture rtl of ACMP_Sub is
    component AESL_Sub is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;
begin
    ACMP_Sub_U: component AESL_Sub
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


-------------------------------------------------------------------------------
-- Mul.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Mul_ss is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Mul_ss;

architecture rtl of ACMP_Mul_ss is
    component AESL_Mul_ss is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_ss
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Mul_us is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Mul_us;

architecture rtl of ACMP_Mul_us is
    component AESL_Mul_us is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_us
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Mul_su is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Mul_su;

architecture rtl of ACMP_Mul_su is
    component AESL_Mul_su is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_su
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_Mul_uu is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_Mul_uu;

architecture rtl of ACMP_Mul_uu is
    component AESL_Mul_uu is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_uu
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


-------------------------------------------------------------------------------
-- Single Cycle Mul.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_smul_ss is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_smul_ss;

architecture rtl of ACMP_smul_ss is
    component AESL_Mul_ss is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_ss
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '0',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_smul_us is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_smul_us;

architecture rtl of ACMP_smul_us is
    component AESL_Mul_us is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_us
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_smul_su is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_smul_su;

architecture rtl of ACMP_smul_su is
    component AESL_Mul_su is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_su
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_smul_uu is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_smul_uu;

architecture rtl of ACMP_smul_uu is
    component AESL_Mul_uu is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_Mul_U: component AESL_Mul_uu
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


-------------------------------------------------------------------------------
-- SDivide.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_sdiv_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_sdiv_comb;

architecture rtl of ACMP_sdiv_comb is

    component AESL_sdiv is
      generic (
        NUM_STAGE : INTEGER := 1;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_sdiv_U : component AESL_sdiv
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_sdiv is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_sdiv;

architecture rtl of ACMP_sdiv is

    component AESL_sdiv is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_sdiv_U : component AESL_sdiv
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


-------------------------------------------------------------------------------
-- UDivide.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_udiv_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_udiv_comb;

architecture rtl of ACMP_udiv_comb is

    component AESL_udiv is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_udiv_U : component AESL_udiv
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_udiv is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_udiv;

architecture rtl of ACMP_udiv is

    component AESL_udiv is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_udiv_U : component AESL_udiv
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


-------------------------------------------------------------------------------
-- SRem
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_srem_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_srem_comb;

architecture rtl of ACMP_srem_comb is

    component AESL_srem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_srem_U : component AESL_srem
    generic map(
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_srem is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_srem;

architecture rtl of ACMP_srem is

    component AESL_srem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_srem_U : component AESL_srem
    generic map(
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;



-------------------------------------------------------------------------------
-- URem
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_urem_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_urem_comb;

architecture rtl of ACMP_urem_comb is
    component AESL_urem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_urem_U : component AESL_urem
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_urem is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_urem;

architecture rtl of ACMP_urem is
    component AESL_urem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_urem_U : component AESL_urem
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;




-------------------------------------------------------------------------------
-- SDiv/SRem
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_sdivsrem_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    opcode : in std_logic_vector(1 downto 0);
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_sdivsrem_comb;

architecture rtl of ACMP_sdivsrem_comb is

    component AESL_sdivsrem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        opcode : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_sdivsrem_U : component AESL_sdivsrem
    generic map(
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        opcode => opcode(0),
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;



Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_sdivsrem is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    opcode : in std_logic_vector(1 downto 0);
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_sdivsrem;

architecture rtl of ACMP_sdivsrem is

    component AESL_sdivsrem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        opcode : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_sdivsrem_U : component AESL_sdivsrem
    generic map(
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        opcode => opcode(0),
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;



-------------------------------------------------------------------------------
-- UDiv/URem
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_udivurem_comb is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    opcode : in std_logic_vector(1 downto 0);
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_udivurem_comb;

architecture rtl of ACMP_udivurem_comb is
    component AESL_udivurem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        opcode : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_udivurem_U : component AESL_udivurem
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => '1',
        reset => '1',
        ce => '1',
        opcode => opcode(0),
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity ACMP_udivurem is
  generic (
    ID : INTEGER := 0;
    NUM_STAGE : INTEGER := 2;
    din0_WIDTH : INTEGER := 32;
    din1_WIDTH : INTEGER := 32;
    dout_WIDTH : INTEGER := 32);
  port  (
    clk, reset, ce : std_logic;
    opcode : in std_logic_vector(1 downto 0);
    din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
    din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
    dout : out std_logic_vector(dout_WIDTH-1 downto 0));
end ACMP_udivurem;

architecture rtl of ACMP_udivurem is
    component AESL_udivurem is
      generic (
        NUM_STAGE : INTEGER := 2;
        din0_WIDTH : INTEGER := 32;
        din1_WIDTH : INTEGER := 32;
        dout_WIDTH : INTEGER := 32);
      port  (
        clk, reset, ce : std_logic;
        opcode : std_logic;
        din0 : in std_logic_vector(din0_WIDTH-1 downto 0);
        din1 : in std_logic_vector(din1_WIDTH-1 downto 0);
        dout : out std_logic_vector(dout_WIDTH-1 downto 0));
    end component;

begin
    ACMP_udivurem_U : component AESL_udivurem
    generic map (
        NUM_STAGE => NUM_STAGE,
        din0_WIDTH => din0_WIDTH,
        din1_WIDTH => din1_WIDTH,
        dout_WIDTH => dout_WIDTH)
    port map (
        clk => clk,
        reset => reset,
        ce => ce,
        opcode => opcode(0),
        din0 => din0,
        din1 => din1,
        dout => dout);
end rtl;


