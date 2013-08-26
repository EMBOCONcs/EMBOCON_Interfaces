-- Version: release . Copyright (C) 2011 XILINX, Inc.

-------------------------------------------------------------------------------
-- Add.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_Add is
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
end AESL_Add;

architecture rtl of AESL_Add is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_Add(din0_reg, din1_reg);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


-------------------------------------------------------------------------------
-- Sub.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_Sub is
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
end AESL_Sub;

architecture rtl of AESL_Sub is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
begin
    dout_tmp <= esl_sub(din0_reg, din1_reg);
    din0_reg <= din0;
    din1_reg <= din1;
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;




-------------------------------------------------------------------------------
-- Mul.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_Mul_ss is
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
end AESL_Mul_ss;

architecture rtl of AESL_Mul_ss is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_mul_ss(din0_reg, din1_reg, dout_WIDTH);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_Mul_us is
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
end AESL_Mul_us;

architecture rtl of AESL_Mul_us is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_mul_us(din0_reg, din1_reg, dout_WIDTH);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_Mul_su is
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
end AESL_Mul_su;

architecture rtl of AESL_Mul_su is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_mul_su(din0_reg, din1_reg, dout_WIDTH);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_Mul_uu is
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
end AESL_Mul_uu;

architecture rtl of AESL_Mul_uu is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_mul_uu(din0_reg, din1_reg, dout_WIDTH);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


-------------------------------------------------------------------------------
-- SDivide.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_sdiv is
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
end AESL_sdiv;

architecture rtl of AESL_sdiv is
    type buff_type is array (0 to NUM_STAGE - 2) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_sdiv(din0_reg, din1_reg);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


-------------------------------------------------------------------------------
-- UDivide.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_udiv is
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
end AESL_udiv;

architecture rtl of AESL_udiv is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_udiv(din0_reg, din1_reg);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then 
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


-------------------------------------------------------------------------------
-- SRem
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_srem is
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
end AESL_srem;

architecture rtl of AESL_srem is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_srem(din0_reg, din1_reg);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;


-------------------------------------------------------------------------------
-- URem.
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_urem is
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
end AESL_urem;

architecture rtl of AESL_urem is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_urem(din0_reg, din1_reg);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then 
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;




-------------------------------------------------------------------------------
-- SDiv/SRem
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_sdivsrem is
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
end AESL_sdivsrem;

architecture rtl of AESL_sdivsrem is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_sdiv(din0_reg, din1_reg) when opcode = '0' else
                esl_srem(din0_reg, din1_reg);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;



-------------------------------------------------------------------------------
-- UDiv/URem
-------------------------------------------------------------------------------
Library IEEE;
use IEEE.std_logic_1164.all;
Library work;
use work.all;
use work.AESL_components.all;

entity AESL_udivurem is
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
end AESL_udivurem;

architecture rtl of AESL_udivurem is
    type buff_type is array (0 to NUM_STAGE - 1) of std_logic_vector(dout_WIDTH-1 downto 0);
    signal dout_buff : buff_type;
    signal dout_tmp : std_logic_vector(dout_WIDTH-1 downto 0);
    signal din0_reg : std_logic_vector(din0_WIDTH-1 downto 0);
    signal din1_reg : std_logic_vector(din1_WIDTH-1 downto 0);

begin
    din0_reg <= din0;
    din1_reg <= din1;
    dout_tmp <= esl_udiv(din0_reg, din1_reg) when opcode = '0' else 
                esl_urem(din0_reg, din1_reg);
    
    proc_dout : process(dout_tmp, dout_buff)
    begin
        if (NUM_STAGE > 1) then
            dout <= dout_buff(NUM_STAGE - 2);
        else 
            dout <= dout_tmp;
        end if;
    end process;

    proc_buff : process(clk)
        variable i: integer;
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then 
                if (NUM_STAGE > 1) then
                    for i in 0 to NUM_STAGE - 2 loop
                        if (i = 0) then
                            dout_buff(i) <= dout_tmp;
                        else
                            dout_buff(i) <= dout_buff(i - 1);
                        end if;
                    end loop;
                end if;
            end if;
        end if;
    end process;

end rtl;

