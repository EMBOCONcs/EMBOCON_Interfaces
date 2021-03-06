-- ==============================================================
-- File generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2012.2
-- Copyright (C) 2012 Xilinx Inc. All rights reserved.
-- 
-- ==============================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;


entity funeval_theta_V_core  is
    generic(READ_PORT_COUNT  : NATURAL := 1;
            WRITE_PORT_COUNT : NATURAL := 1;
            DATA_WIDTH       : NATURAL := 8;
            ADDRESS_WIDTH    : NATURAL := 8;
            WORD_COUNT       : NATURAL := 256);
    port ( ra     : in  std_logic_vector(READ_PORT_COUNT*ADDRESS_WIDTH-1 downto 0);
           ce     : in  std_logic_vector(READ_PORT_COUNT-1 downto 0);
           d      : in  std_logic_vector(WRITE_PORT_COUNT*DATA_WIDTH-1 downto 0);
           wa     : in  std_logic_vector(WRITE_PORT_COUNT*ADDRESS_WIDTH-1 downto 0);
           we     : in  std_logic_vector(WRITE_PORT_COUNT-1 downto 0);
           reset    : in  std_logic;
           clk    : in  std_logic;
           q      : out std_logic_vector(READ_PORT_COUNT*DATA_WIDTH-1 downto 0));
end entity;


architecture rtl of funeval_theta_V_core is

type read_address_type is array (0 to READ_PORT_COUNT-1) of std_logic_vector(ADDRESS_WIDTH-1 downto 0);
type write_address_type is array (0 to WRITE_PORT_COUNT-1) of std_logic_vector(ADDRESS_WIDTH-1 downto 0);
type write_data_type is array (0 to WRITE_PORT_COUNT-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
type ram_type is array (0 to WORD_COUNT-1) of std_logic_vector(DATA_WIDTH-1 downto 0);
signal mem: ram_type;
signal rai, rai_reg: read_address_type;
signal wai: write_address_type;
signal di : write_data_type;
signal qi : std_logic_vector(READ_PORT_COUNT*DATA_WIDTH-1 downto 0);
begin
    -- Split input data
    process(d)
        variable dt : std_logic_vector(DATA_WIDTH-1 downto 0);
    begin
        for i in 0 to (WRITE_PORT_COUNT-1) loop
            for j in 0 to (DATA_WIDTH-1) loop
                dt(j) := d(i*DATA_WIDTH+j);
            end loop;
            di(i) <= dt;
        end loop;
    end process;

    -- Split write addresses
    process(wa)
        variable wat: std_logic_vector(ADDRESS_WIDTH-1 downto 0);
    begin
        for i in 0 to (WRITE_PORT_COUNT-1) loop
            for j in 0 to (ADDRESS_WIDTH-1) loop
                --wat(j) <= wa(i*ADDRESS_WIDTH+j);
                wat(j) := wa(i*ADDRESS_WIDTH+j);
            end loop;
            wai(i) <= wat;
        end loop;
    end process;

    -- Write memory
    process(clk)
        variable waitmp : STD_LOGIC_VECTOR(ADDRESS_WIDTH downto 0);
    begin
        if (clk'event and clk='1') then
            for i in 0 to (WORD_COUNT-1) loop
                portloop :
                for j in 0 to (WRITE_PORT_COUNT-1) loop
                    waitmp(ADDRESS_WIDTH) := '0';
                    waitmp(ADDRESS_WIDTH-1 downto 0) := wai(j);
                    if ( (we(j) = '1') and (CONV_INTEGER(waitmp) = i) ) then
                        mem(i) <= di(j);
                        exit portloop; -- next ports can't write on this address
                    end if;
                end loop;
            end loop;
        end if;
    end process;

    -- Split read addresses
    process(ra)
        variable rat: std_logic_vector(ADDRESS_WIDTH-1 downto 0);
    begin
        for i in 0 to (READ_PORT_COUNT-1) loop
            for j in 0 to (ADDRESS_WIDTH-1) loop
                rat(j) := ra(i*ADDRESS_WIDTH+j);
            end loop;
            rai(i) <= rat;
        end loop;
    end process;

    -- guide read address using CE
    process(clk)
    begin
        if (clk'event and clk='1') then
            for i in 0 to (READ_PORT_COUNT-1) loop
                if (ce(i) = '1') then
                    rai_reg(i) <= rai(i);
                end if;
            end loop;
        end if;
    end process;

    process(rai_reg, mem)
        variable qt : std_logic_vector(DATA_WIDTH-1 downto 0);
        variable raitmp : std_logic_vector(ADDRESS_WIDTH downto 0);
        variable memidx : integer;
    begin
        for i in 0 to (READ_PORT_COUNT-1) loop
            raitmp(ADDRESS_WIDTH) := '0';
            raitmp(ADDRESS_WIDTH-1 downto 0) := rai_reg(i);
            memidx := CONV_INTEGER(raitmp);
            if (memidx >= WORD_COUNT) then
                qt := (others => '0');
            else 
                qt := mem(memidx);
            end if;
            for j in 0 to (DATA_WIDTH-1) loop
                qi(i*DATA_WIDTH+j) <= qt(j);
            end loop;
        end loop;
    end process;
    q <= qi;

end rtl;



library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;


entity funeval_theta_V is
generic (
    DataWidth : integer := 18;
    AddressRange : integer := 40;
    AddressWidth : integer := 6);
port (
    address0 : in STD_LOGIC_VECTOR (AddressWidth-1 DOWNTO 0);
    ce0 : in STD_LOGIC;
    q0 : out STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0);
    we0 : in STD_LOGIC;
    d0 : in STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0);

    address1 : in STD_LOGIC_VECTOR (AddressWidth-1 DOWNTO 0);
    ce1 : in STD_LOGIC;
    we1 : in STD_LOGIC;
    d1 : in STD_LOGIC_VECTOR (DataWidth-1 DOWNTO 0);

    reset : in STD_LOGIC;
    clk : in STD_LOGIC);
end entity funeval_theta_V;


architecture struct of funeval_theta_V is
    signal mem_q : STD_LOGIC_VECTOR  (1 * DataWidth - 1 DOWNTO 0);
    signal mem_ra : STD_LOGIC_VECTOR  (1 * AddressWidth - 1 DOWNTO 0);
    signal mem_ce : STD_LOGIC_VECTOR  (1 - 1 DOWNTO 0);
    signal mem_we : STD_LOGIC_VECTOR  (2 - 1 DOWNTO 0);
    signal mem_wa : STD_LOGIC_VECTOR  (2 * AddressWidth - 1 DOWNTO 0);
    signal mem_d : STD_LOGIC_VECTOR  (2 * DataWidth - 1 DOWNTO 0);

    type addr_type is array (0 to 2-1) of std_logic_vector(AddressWidth-1 downto 0);
    signal \re\   : std_logic_vector(0 to 2-1);
    signal \we\   : std_logic_vector(0 to 2-1);
    signal \addr\ : addr_type;

begin
    core_inst : entity work.funeval_theta_V_core
        generic map(
            READ_PORT_COUNT => 1,
            WRITE_PORT_COUNT => 2,
            DATA_WIDTH => DataWidth,
            ADDRESS_WIDTH => AddressWidth,
            WORD_COUNT => AddressRange)
        port map(
            q => mem_q,
            ra => mem_ra,
            ce => mem_ce,
            d => mem_d,
            wa => mem_wa,
            we => mem_we,
            reset => reset,
            clk => clk);


    q0 <= mem_q( 1 * DataWidth - 1 DOWNTO 0 * DataWidth);


    mem_ra <= address0;

    mem_ce(0) <= ce0;

    mem_we(1) <= we0;

    mem_we(0) <= we1;

    mem_d <= d0 & d1;

    mem_wa <= address0 & address1;



    \re\(0)   <= ce0 and (not we0);
    \we\(0)   <= ce0 and we0;
    \addr\(0) <= address0;
    \re\(1)   <= '0';
    \we\(1)   <= ce1 and we1;
    \addr\(1) <= address1;


    -- check collision
    process(clk)
    begin
        if (clk'event and clk='1') then
            for i in 0 to 0 loop
                for j in (i+1) to 1 loop
                    if (\addr\(i) = \addr\(j)) then
                        if (\we\(i) = '1' and \we\(j) = '1') then
                            report "collision occurred." & CR & LF &
                                "    Port " & integer'image(i) & "  : write" & CR & LF &
                                "    Port " & integer'image(j) & "  : write" & CR & LF &
                                "    Address : " &  integer'image(conv_integer(ieee.std_logic_arith.unsigned(\addr\(i))))
                            severity warning;
                        elsif (\we\(i) = '1' and \re\(j) = '1') then
                            report "collision occurred." & CR & LF &
                                "    Port " & integer'image(i) & "  : write" & CR & LF &
                                "    Port " & integer'image(j) & "  : read" & CR & LF &
                                "    Address : " &  integer'image(conv_integer(ieee.std_logic_arith.unsigned(\addr\(i))))
                            severity warning;
                        elsif (\re\(i) = '1' and \we\(j) = '1') then
                            report "collision occurred." & CR & LF &
                                "    Port " & integer'image(i) & "  : read" & CR & LF &
                                "    Port " & integer'image(j) & "  : write" & CR & LF &
                                "    Address : " &  integer'image(conv_integer(ieee.std_logic_arith.unsigned(\addr\(i))))
                            severity warning;
                        end if;
                    end if;
                end loop;
            end loop;
        end if;
    end process;


end architecture struct;
