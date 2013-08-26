------------------------------------------------------------------------------
-- user_logic.vhd - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          user_logic.vhd
-- Version:           1.00.a
-- Description:       User logic.
-- Date:              Mon Jun 17 15:20:54 2013 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

-- DO NOT EDIT BELOW THIS LINE --------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library proc_common_v3_00_a;
use proc_common_v3_00_a.proc_common_pkg.all;

-- DO NOT EDIT ABOVE THIS LINE --------------------

--USER libraries added here

------------------------------------------------------------------------------
-- Entity section
------------------------------------------------------------------------------
-- Definition of Generics:
--   C_NUM_REG                    -- Number of software accessible registers
--   C_SLV_DWIDTH                 -- Slave interface data bus width
--
-- Definition of Ports:
--   Bus2IP_Clk                   -- Bus to IP clock
--   Bus2IP_Resetn                -- Bus to IP reset
--   Bus2IP_Data                  -- Bus to IP data bus
--   Bus2IP_BE                    -- Bus to IP byte enables
--   Bus2IP_RdCE                  -- Bus to IP read chip enable
--   Bus2IP_WrCE                  -- Bus to IP write chip enable
--   IP2Bus_Data                  -- IP to Bus data bus
--   IP2Bus_RdAck                 -- IP to Bus read transfer acknowledgement
--   IP2Bus_WrAck                 -- IP to Bus write transfer acknowledgement
--   IP2Bus_Error                 -- IP to Bus error response
------------------------------------------------------------------------------

entity user_logic is
  generic
  (
    -- ADD USER GENERICS BELOW THIS LINE ---------------
    --USER generics added here
    -- ADD USER GENERICS ABOVE THIS LINE ---------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol parameters, do not add to or delete
    C_NUM_REG                      : integer              := 4;
    C_SLV_DWIDTH                   : integer              := 32
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );
  port
  (
    -- ADD USER PORTS BELOW THIS LINE ------------------
    --USER ports added here
    -- ADD USER PORTS ABOVE THIS LINE ------------------

    -- DO NOT EDIT BELOW THIS LINE ---------------------
    -- Bus protocol ports, do not add to or delete
    Bus2IP_Clk                     : in  std_logic;
    Bus2IP_Resetn                  : in  std_logic;
    Bus2IP_Data                    : in  std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    Bus2IP_BE                      : in  std_logic_vector(C_SLV_DWIDTH/8-1 downto 0);
    Bus2IP_RdCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    Bus2IP_WrCE                    : in  std_logic_vector(C_NUM_REG-1 downto 0);
    IP2Bus_Data                    : out std_logic_vector(C_SLV_DWIDTH-1 downto 0);
    IP2Bus_RdAck                   : out std_logic;
    IP2Bus_WrAck                   : out std_logic;
    IP2Bus_Error                   : out std_logic
    -- DO NOT EDIT ABOVE THIS LINE ---------------------
  );

  attribute MAX_FANOUT : string;
  attribute SIGIS : string;

  attribute SIGIS of Bus2IP_Clk    : signal is "CLK";
  attribute SIGIS of Bus2IP_Resetn : signal is "RST";

end entity user_logic;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of user_logic is

  --USER signal declarations added here, as needed for user logic
  
	COMPONENT funeval
	PORT(
		ap_clk : IN std_logic;
		ap_rst : IN std_logic;
		ap_start : IN std_logic;
		x_in_V_q0 : IN std_logic_vector(17 downto 0);          
		ap_done : OUT std_logic;
		ap_idle : OUT std_logic;
		x_in_V_address0 : OUT std_logic_vector(4 downto 0);
		x_in_V_ce0 : OUT std_logic;
		u_out_V_address0 : OUT std_logic_vector(3 downto 0);
		u_out_V_ce0 : OUT std_logic;
		u_out_V_we0 : OUT std_logic;
		u_out_V_d0 : OUT std_logic_vector(17 downto 0)
		);
	END COMPONENT;
	
	component controller_dcm
	port
	 (-- Clock in ports
	  CLK_IN1           : in     std_logic;
	  -- Clock out ports
	  CLK_OUT1          : out    std_logic;
	  -- Status and control signals
	  RESET             : in     std_logic;
	  LOCKED            : out    std_logic
	 );
	end component;
	
	COMPONENT controller_fifo
	  PORT (
	    rst : IN STD_LOGIC;
	    wr_clk : IN STD_LOGIC;
	    rd_clk : IN STD_LOGIC;
	    din : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
	    wr_en : IN STD_LOGIC;
	    rd_en : IN STD_LOGIC;
	    dout : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
	    full : OUT STD_LOGIC;
	    empty : OUT STD_LOGIC;
	    valid : OUT STD_LOGIC
	  );
	END COMPONENT;

  ------------------------------------------
  -- Signals for user logic slave model s/w accessible register example
  ------------------------------------------
  signal slv_reg0                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg1                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg2                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg3                       : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_reg_write_sel              : std_logic_vector(3 downto 0);
  signal slv_reg_read_sel               : std_logic_vector(3 downto 0);
  signal slv_ip2bus_data                : std_logic_vector(C_SLV_DWIDTH-1 downto 0);
  signal slv_read_ack                   : std_logic;
  signal slv_write_ack                  : std_logic;

	signal controller_clk: std_logic;
	signal controller_rst: std_logic;
	signal controller_rst_int: std_logic;


	signal controller_start: std_logic;
	signal controller_done: std_logic;
	signal controller_x_in_V_ce0: std_logic;
	signal controller_x_in_V_q0: std_logic_vector(17 downto 0);

	signal controller_u_out_V_we0: std_logic;
	signal controller_u_out_V_ce0: std_logic;
	signal controller_u_out_V_d0: std_logic_vector(17 downto 0);

	signal rst_shift_reg	:std_logic_vector(31 downto 0):=(others=>'1');
	signal dcm_reset: std_logic;
	signal dcm_locked: std_logic;
	
	signal start_int1,start_int2,start_int3,start_int4,start_int5: std_logic;
	
	type type_state is (idle,start, processing,done);
	signal state:type_state;
	
	signal input_controller_fifo_din : STD_LOGIC_VECTOR(17 DOWNTO 0);
	signal input_controller_fifo_wr_en :  STD_LOGIC;
	signal input_controller_fifo_rd_en :  STD_LOGIC;
	signal input_controller_fifo_dout :  STD_LOGIC_VECTOR(17 DOWNTO 0);
	signal output_controller_fifo_din : STD_LOGIC_VECTOR(17 DOWNTO 0);
	signal output_controller_fifo_wr_en :  STD_LOGIC;
	signal output_controller_fifo_rd_en :  STD_LOGIC;
	signal output_controller_fifo_dout :  STD_LOGIC_VECTOR(17 DOWNTO 0);
	
	signal done_int: std_logic;
	
	

begin

  --USER logic implementation added here

  ------------------------------------------
  -- Example code to read/write user logic slave model s/w accessible registers
  -- 
  -- Note:
  -- The example code presented here is to show you one way of reading/writing
  -- software accessible registers implemented in the user logic slave model.
  -- Each bit of the Bus2IP_WrCE/Bus2IP_RdCE signals is configured to correspond
  -- to one software accessible register by the top level template. For example,
  -- if you have four 32 bit software accessible registers in the user logic,
  -- you are basically operating on the following memory mapped registers:
  -- 
  --    Bus2IP_WrCE/Bus2IP_RdCE   Memory Mapped Register
  --                     "1000"   C_BASEADDR + 0x0
  --                     "0100"   C_BASEADDR + 0x4
  --                     "0010"   C_BASEADDR + 0x8
  --                     "0001"   C_BASEADDR + 0xC
  -- 
  ------------------------------------------
  slv_reg_write_sel <= Bus2IP_WrCE(3 downto 0);
  slv_reg_read_sel  <= Bus2IP_RdCE(3 downto 0);
  slv_write_ack     <= Bus2IP_WrCE(0) or Bus2IP_WrCE(1) or Bus2IP_WrCE(2) or Bus2IP_WrCE(3);
  slv_read_ack      <= Bus2IP_RdCE(0) or Bus2IP_RdCE(1) or Bus2IP_RdCE(2) or Bus2IP_RdCE(3);

  -- implement slave model software accessible register(s)
  SLAVE_REG_WRITE_PROC : process( Bus2IP_Clk ) is
  begin

    if Bus2IP_Clk'event and Bus2IP_Clk = '1' then
      if Bus2IP_Resetn = '0' then
        slv_reg0 <= (others => '0');
        slv_reg1 <= (others => '0');
	input_controller_fifo_wr_en<='0';
        -- slv_reg2 <= (others => '0');
        -- slv_reg3 <= (others => '0');
      else
	  
		slv_reg0 <= (others => '0'); --start
		input_controller_fifo_wr_en<='0';
		
        case slv_reg_write_sel is
          when "1000" => --start
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg0(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              end if;
            end loop;
          when "0100" => --input data
            for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              if ( Bus2IP_BE(byte_index) = '1' ) then
                slv_reg1(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
		input_controller_fifo_wr_en<='1';
              end if;
            end loop;
          -- when "0010" =>
            -- for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              -- if ( Bus2IP_BE(byte_index) = '1' ) then
                -- slv_reg2(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              -- end if;
            -- end loop;
          -- when "0001" =>
            -- for byte_index in 0 to (C_SLV_DWIDTH/8)-1 loop
              -- if ( Bus2IP_BE(byte_index) = '1' ) then
                -- slv_reg3(byte_index*8+7 downto byte_index*8) <= Bus2IP_Data(byte_index*8+7 downto byte_index*8);
              -- end if;
            -- end loop;
          when others => null;
        end case;
      end if;
    end if;

  end process SLAVE_REG_WRITE_PROC;

  -- implement slave model software accessible register(s) read mux
  SLAVE_REG_READ_PROC : process( slv_reg_read_sel, slv_reg0, slv_reg1, slv_reg2, slv_reg3 ) is
  begin

    case slv_reg_read_sel is
      -- when "1000" => slv_ip2bus_data <= slv_reg0;
      -- when "0100" => slv_ip2bus_data <= slv_reg1;
      when "0010" => slv_ip2bus_data <= slv_reg2; --output data
      when "0001" => slv_ip2bus_data <= slv_reg3; -- timer & elaboration compleated
      when others => slv_ip2bus_data <= (others => '0');
    end case;

  end process SLAVE_REG_READ_PROC;
  
 slv_reg3(0)<= done_int;
 
 

  ------------------------------------------
  -- Example code to drive IP to Bus signals
  ------------------------------------------
  IP2Bus_Data  <= slv_ip2bus_data when slv_read_ack = '1' else
                  (others => '0');

  IP2Bus_WrAck <= slv_write_ack;
  IP2Bus_RdAck <= slv_read_ack;
  IP2Bus_Error <= '0';
  
  ------------------------------------------
  -- Controller interface
  ------------------------------------------

  
	--auto reset
	process(Bus2IP_Clk)
	begin
		if rising_edge(Bus2IP_Clk) then
			rst_shift_reg<='0'&rst_shift_reg(31 downto 1);
			start_int1<=slv_reg0(0);
			start_int2<=start_int1;
			start_int3<=start_int2;
			start_int4<=start_int3;
			start_int5<=start_int1 or start_int2 or start_int3 or start_int4;
		end if;
	end process;
	
	dcm_reset<=rst_shift_reg(0);
  
  
  Inst_controller_dcm : controller_dcm
  port map
   (-- Clock in ports
    CLK_IN1 => Bus2IP_Clk,
    -- Clock out ports
    CLK_OUT1 => controller_clk,
    -- Status and control signals
    RESET  => dcm_reset,
    LOCKED => dcm_locked);
	
	
	process(Bus2IP_Clk)
	variable shift_reg	:std_logic_vector(31 downto 0):=(others=>'1');
	begin
		if rising_edge(Bus2IP_Clk) then
			if dcm_locked='0' or Bus2IP_Resetn='0' then
				shift_reg:=(others=>'1');
			else
				shift_reg:='0'&shift_reg(31 downto 1);
			end if;
			controller_rst_int<= shift_reg(0);
		end if;
	end process;
	
	process(controller_clk)
	begin
		if rising_edge(controller_clk) then
			controller_rst<= controller_rst_int;
		end if;
	end process;
	


--write input fifo
input_controller_fifo_din<=slv_reg1(17 downto 0);
	
input_controller_fifo : controller_fifo
  PORT MAP (
    rst => controller_rst_int,
    wr_clk => Bus2IP_Clk,
    rd_clk => controller_clk,
    din => input_controller_fifo_din,
    wr_en => input_controller_fifo_wr_en,
    rd_en => input_controller_fifo_rd_en,
    dout => input_controller_fifo_dout,
    full => open,
    empty => open,
    valid => open
  );
  
 
--read input fifo 
input_controller_fifo_rd_en<=controller_x_in_V_ce0;

process(controller_clk)
begin
	if rising_edge(controller_clk) then
		if controller_rst='1' then
			controller_x_in_V_q0<=(others=>'0');
		else
			controller_x_in_V_q0<=input_controller_fifo_dout;
		end if;
	end if;
end process;


	Inst_funeval: funeval PORT MAP(
		ap_clk => controller_clk,
		ap_rst => controller_rst,
		ap_start => controller_start,
		ap_done => controller_done,
		ap_idle => open,
		x_in_V_address0 => open,
		x_in_V_ce0 => controller_x_in_V_ce0,
		x_in_V_q0 => controller_x_in_V_q0,
		u_out_V_address0 => open,
		u_out_V_ce0 => controller_u_out_V_we0,
		u_out_V_we0 => controller_u_out_V_ce0,
		u_out_V_d0 => controller_u_out_V_d0
	);
  
  
	process(controller_clk)
	begin
		if rising_edge(controller_clk) then
			if controller_rst='1' then
				controller_start<='0';
				state<=idle;
				done_int<='0';
			else
				
				case state is
					when idle =>
						controller_start<='0';
						if start_int5='1' then
							state<=start;
						else
							state<=idle;
						end if;
					when start =>
						done_int<='0';
						controller_start<='1';
						state<=processing;
					when processing =>
						controller_start<='0';
						if controller_done='1' then
							state<=done;
						else
							state<=processing;
						end if;
					when done =>
						done_int<='1';
						state<=idle;
					
					when others =>
						null;
				end case;
			
			end if;
		end if;
	end process;



output_controller_fifo_wr_en<=controller_u_out_V_we0;
output_controller_fifo_din<=controller_u_out_V_d0;
  
output_controller_fifo : controller_fifo
  PORT MAP (
    rst => controller_rst_int,
    wr_clk => controller_clk,
    rd_clk => Bus2IP_Clk,
    din => output_controller_fifo_din,
    wr_en => output_controller_fifo_wr_en,
    rd_en => output_controller_fifo_rd_en,
    dout => output_controller_fifo_dout,
    full => open,
    empty => open,
    valid => open
  );
  

 --sign extension
slv_reg2(31)<=output_controller_fifo_dout(17);
slv_reg2(30)<=output_controller_fifo_dout(17);
slv_reg2(29)<=output_controller_fifo_dout(17);
slv_reg2(28)<=output_controller_fifo_dout(17);
slv_reg2(27)<=output_controller_fifo_dout(17);
slv_reg2(26)<=output_controller_fifo_dout(17);
slv_reg2(25)<=output_controller_fifo_dout(17);
slv_reg2(24)<=output_controller_fifo_dout(17);
slv_reg2(23)<=output_controller_fifo_dout(17);
slv_reg2(22)<=output_controller_fifo_dout(17);
slv_reg2(21)<=output_controller_fifo_dout(17);
slv_reg2(20)<=output_controller_fifo_dout(17);
slv_reg2(19)<=output_controller_fifo_dout(17);
slv_reg2(18)<=output_controller_fifo_dout(17);
slv_reg2(17 downto 0)<=output_controller_fifo_dout(17 downto 0);

output_controller_fifo_rd_en<=slv_reg_read_sel(1);
  
  

end IMP;
