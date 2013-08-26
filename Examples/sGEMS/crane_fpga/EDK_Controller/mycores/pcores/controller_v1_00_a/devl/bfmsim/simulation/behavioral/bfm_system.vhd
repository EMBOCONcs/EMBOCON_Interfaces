-------------------------------------------------------------------------------
-- bfm_system.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity bfm_system is
  port (
    sys_reset : in std_logic;
    sys_clk : in std_logic
  );
end bfm_system;

architecture STRUCTURE of bfm_system is

  component bfm_system_bfm_processor_wrapper is
    port (
      M_AXI_LITE_ACLK : in std_logic;
      M_AXI_LITE_ARESETN : in std_logic;
      M_AXI_LITE_AWADDR : out std_logic_vector(31 downto 0);
      M_AXI_LITE_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_LITE_AWVALID : out std_logic;
      M_AXI_LITE_AWREADY : in std_logic;
      M_AXI_LITE_WDATA : out std_logic_vector(31 downto 0);
      M_AXI_LITE_WSTRB : out std_logic_vector(3 downto 0);
      M_AXI_LITE_WVALID : out std_logic;
      M_AXI_LITE_WREADY : in std_logic;
      M_AXI_LITE_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_LITE_BVALID : in std_logic;
      M_AXI_LITE_BREADY : out std_logic;
      M_AXI_LITE_ARADDR : out std_logic_vector(31 downto 0);
      M_AXI_LITE_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_LITE_ARVALID : out std_logic;
      M_AXI_LITE_ARREADY : in std_logic;
      M_AXI_LITE_RDATA : in std_logic_vector(31 downto 0);
      M_AXI_LITE_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_LITE_RVALID : in std_logic;
      M_AXI_LITE_RREADY : out std_logic
    );
  end component;

  component bfm_system_axi4lite_bus_wrapper is
    port (
      INTERCONNECT_ACLK : in std_logic;
      INTERCONNECT_ARESETN : in std_logic;
      S_AXI_ARESET_OUT_N : out std_logic_vector(0 to 0);
      M_AXI_ARESET_OUT_N : out std_logic_vector(0 to 0);
      IRQ : out std_logic;
      S_AXI_ACLK : in std_logic_vector(0 to 0);
      S_AXI_AWID : in std_logic_vector(0 to 0);
      S_AXI_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_AWLEN : in std_logic_vector(7 downto 0);
      S_AXI_AWSIZE : in std_logic_vector(2 downto 0);
      S_AXI_AWBURST : in std_logic_vector(1 downto 0);
      S_AXI_AWLOCK : in std_logic_vector(1 downto 0);
      S_AXI_AWCACHE : in std_logic_vector(3 downto 0);
      S_AXI_AWPROT : in std_logic_vector(2 downto 0);
      S_AXI_AWQOS : in std_logic_vector(3 downto 0);
      S_AXI_AWUSER : in std_logic_vector(0 to 0);
      S_AXI_AWVALID : in std_logic_vector(0 to 0);
      S_AXI_AWREADY : out std_logic_vector(0 to 0);
      S_AXI_WID : in std_logic_vector(0 to 0);
      S_AXI_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_WSTRB : in std_logic_vector(3 downto 0);
      S_AXI_WLAST : in std_logic_vector(0 to 0);
      S_AXI_WUSER : in std_logic_vector(0 to 0);
      S_AXI_WVALID : in std_logic_vector(0 to 0);
      S_AXI_WREADY : out std_logic_vector(0 to 0);
      S_AXI_BID : out std_logic_vector(0 to 0);
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BUSER : out std_logic_vector(0 to 0);
      S_AXI_BVALID : out std_logic_vector(0 to 0);
      S_AXI_BREADY : in std_logic_vector(0 to 0);
      S_AXI_ARID : in std_logic_vector(0 to 0);
      S_AXI_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_ARLEN : in std_logic_vector(7 downto 0);
      S_AXI_ARSIZE : in std_logic_vector(2 downto 0);
      S_AXI_ARBURST : in std_logic_vector(1 downto 0);
      S_AXI_ARLOCK : in std_logic_vector(1 downto 0);
      S_AXI_ARCACHE : in std_logic_vector(3 downto 0);
      S_AXI_ARPROT : in std_logic_vector(2 downto 0);
      S_AXI_ARQOS : in std_logic_vector(3 downto 0);
      S_AXI_ARUSER : in std_logic_vector(0 to 0);
      S_AXI_ARVALID : in std_logic_vector(0 to 0);
      S_AXI_ARREADY : out std_logic_vector(0 to 0);
      S_AXI_RID : out std_logic_vector(0 to 0);
      S_AXI_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RLAST : out std_logic_vector(0 to 0);
      S_AXI_RUSER : out std_logic_vector(0 to 0);
      S_AXI_RVALID : out std_logic_vector(0 to 0);
      S_AXI_RREADY : in std_logic_vector(0 to 0);
      M_AXI_ACLK : in std_logic_vector(0 to 0);
      M_AXI_AWID : out std_logic_vector(0 to 0);
      M_AXI_AWADDR : out std_logic_vector(31 downto 0);
      M_AXI_AWLEN : out std_logic_vector(7 downto 0);
      M_AXI_AWSIZE : out std_logic_vector(2 downto 0);
      M_AXI_AWBURST : out std_logic_vector(1 downto 0);
      M_AXI_AWLOCK : out std_logic_vector(1 downto 0);
      M_AXI_AWCACHE : out std_logic_vector(3 downto 0);
      M_AXI_AWPROT : out std_logic_vector(2 downto 0);
      M_AXI_AWREGION : out std_logic_vector(3 downto 0);
      M_AXI_AWQOS : out std_logic_vector(3 downto 0);
      M_AXI_AWUSER : out std_logic_vector(0 to 0);
      M_AXI_AWVALID : out std_logic_vector(0 to 0);
      M_AXI_AWREADY : in std_logic_vector(0 to 0);
      M_AXI_WID : out std_logic_vector(0 to 0);
      M_AXI_WDATA : out std_logic_vector(31 downto 0);
      M_AXI_WSTRB : out std_logic_vector(3 downto 0);
      M_AXI_WLAST : out std_logic_vector(0 to 0);
      M_AXI_WUSER : out std_logic_vector(0 to 0);
      M_AXI_WVALID : out std_logic_vector(0 to 0);
      M_AXI_WREADY : in std_logic_vector(0 to 0);
      M_AXI_BID : in std_logic_vector(0 to 0);
      M_AXI_BRESP : in std_logic_vector(1 downto 0);
      M_AXI_BUSER : in std_logic_vector(0 to 0);
      M_AXI_BVALID : in std_logic_vector(0 to 0);
      M_AXI_BREADY : out std_logic_vector(0 to 0);
      M_AXI_ARID : out std_logic_vector(0 to 0);
      M_AXI_ARADDR : out std_logic_vector(31 downto 0);
      M_AXI_ARLEN : out std_logic_vector(7 downto 0);
      M_AXI_ARSIZE : out std_logic_vector(2 downto 0);
      M_AXI_ARBURST : out std_logic_vector(1 downto 0);
      M_AXI_ARLOCK : out std_logic_vector(1 downto 0);
      M_AXI_ARCACHE : out std_logic_vector(3 downto 0);
      M_AXI_ARPROT : out std_logic_vector(2 downto 0);
      M_AXI_ARREGION : out std_logic_vector(3 downto 0);
      M_AXI_ARQOS : out std_logic_vector(3 downto 0);
      M_AXI_ARUSER : out std_logic_vector(0 to 0);
      M_AXI_ARVALID : out std_logic_vector(0 to 0);
      M_AXI_ARREADY : in std_logic_vector(0 to 0);
      M_AXI_RID : in std_logic_vector(0 to 0);
      M_AXI_RDATA : in std_logic_vector(31 downto 0);
      M_AXI_RRESP : in std_logic_vector(1 downto 0);
      M_AXI_RLAST : in std_logic_vector(0 to 0);
      M_AXI_RUSER : in std_logic_vector(0 to 0);
      M_AXI_RVALID : in std_logic_vector(0 to 0);
      M_AXI_RREADY : out std_logic_vector(0 to 0);
      S_AXI_CTRL_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_AWVALID : in std_logic;
      S_AXI_CTRL_AWREADY : out std_logic;
      S_AXI_CTRL_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_WVALID : in std_logic;
      S_AXI_CTRL_WREADY : out std_logic;
      S_AXI_CTRL_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_BVALID : out std_logic;
      S_AXI_CTRL_BREADY : in std_logic;
      S_AXI_CTRL_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_CTRL_ARVALID : in std_logic;
      S_AXI_CTRL_ARREADY : out std_logic;
      S_AXI_CTRL_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_CTRL_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_CTRL_RVALID : out std_logic;
      S_AXI_CTRL_RREADY : in std_logic;
      INTERCONNECT_ARESET_OUT_N : out std_logic;
      DEBUG_AW_TRANS_SEQ : out std_logic_vector(7 downto 0);
      DEBUG_AW_ARB_GRANT : out std_logic_vector(7 downto 0);
      DEBUG_AR_TRANS_SEQ : out std_logic_vector(7 downto 0);
      DEBUG_AR_ARB_GRANT : out std_logic_vector(7 downto 0);
      DEBUG_AW_TRANS_QUAL : out std_logic_vector(0 to 0);
      DEBUG_AW_ACCEPT_CNT : out std_logic_vector(7 downto 0);
      DEBUG_AW_ACTIVE_THREAD : out std_logic_vector(15 downto 0);
      DEBUG_AW_ACTIVE_TARGET : out std_logic_vector(7 downto 0);
      DEBUG_AW_ACTIVE_REGION : out std_logic_vector(7 downto 0);
      DEBUG_AW_ERROR : out std_logic_vector(7 downto 0);
      DEBUG_AW_TARGET : out std_logic_vector(7 downto 0);
      DEBUG_AR_TRANS_QUAL : out std_logic_vector(0 to 0);
      DEBUG_AR_ACCEPT_CNT : out std_logic_vector(7 downto 0);
      DEBUG_AR_ACTIVE_THREAD : out std_logic_vector(15 downto 0);
      DEBUG_AR_ACTIVE_TARGET : out std_logic_vector(7 downto 0);
      DEBUG_AR_ACTIVE_REGION : out std_logic_vector(7 downto 0);
      DEBUG_AR_ERROR : out std_logic_vector(7 downto 0);
      DEBUG_AR_TARGET : out std_logic_vector(7 downto 0);
      DEBUG_B_TRANS_SEQ : out std_logic_vector(7 downto 0);
      DEBUG_R_BEAT_CNT : out std_logic_vector(7 downto 0);
      DEBUG_R_TRANS_SEQ : out std_logic_vector(7 downto 0);
      DEBUG_AW_ISSUING_CNT : out std_logic_vector(7 downto 0);
      DEBUG_AR_ISSUING_CNT : out std_logic_vector(7 downto 0);
      DEBUG_W_BEAT_CNT : out std_logic_vector(7 downto 0);
      DEBUG_W_TRANS_SEQ : out std_logic_vector(7 downto 0);
      DEBUG_BID_TARGET : out std_logic_vector(7 downto 0);
      DEBUG_BID_ERROR : out std_logic;
      DEBUG_RID_TARGET : out std_logic_vector(7 downto 0);
      DEBUG_RID_ERROR : out std_logic;
      DEBUG_SR_SC_ARADDR : out std_logic_vector(31 downto 0);
      DEBUG_SR_SC_ARADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_SR_SC_AWADDR : out std_logic_vector(31 downto 0);
      DEBUG_SR_SC_AWADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_SR_SC_BRESP : out std_logic_vector(4 downto 0);
      DEBUG_SR_SC_RDATA : out std_logic_vector(31 downto 0);
      DEBUG_SR_SC_RDATACONTROL : out std_logic_vector(5 downto 0);
      DEBUG_SR_SC_WDATA : out std_logic_vector(31 downto 0);
      DEBUG_SR_SC_WDATACONTROL : out std_logic_vector(6 downto 0);
      DEBUG_SC_SF_ARADDR : out std_logic_vector(31 downto 0);
      DEBUG_SC_SF_ARADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_SC_SF_AWADDR : out std_logic_vector(31 downto 0);
      DEBUG_SC_SF_AWADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_SC_SF_BRESP : out std_logic_vector(4 downto 0);
      DEBUG_SC_SF_RDATA : out std_logic_vector(31 downto 0);
      DEBUG_SC_SF_RDATACONTROL : out std_logic_vector(5 downto 0);
      DEBUG_SC_SF_WDATA : out std_logic_vector(31 downto 0);
      DEBUG_SC_SF_WDATACONTROL : out std_logic_vector(6 downto 0);
      DEBUG_SF_CB_ARADDR : out std_logic_vector(31 downto 0);
      DEBUG_SF_CB_ARADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_SF_CB_AWADDR : out std_logic_vector(31 downto 0);
      DEBUG_SF_CB_AWADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_SF_CB_BRESP : out std_logic_vector(4 downto 0);
      DEBUG_SF_CB_RDATA : out std_logic_vector(31 downto 0);
      DEBUG_SF_CB_RDATACONTROL : out std_logic_vector(5 downto 0);
      DEBUG_SF_CB_WDATA : out std_logic_vector(31 downto 0);
      DEBUG_SF_CB_WDATACONTROL : out std_logic_vector(6 downto 0);
      DEBUG_CB_MF_ARADDR : out std_logic_vector(31 downto 0);
      DEBUG_CB_MF_ARADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_CB_MF_AWADDR : out std_logic_vector(31 downto 0);
      DEBUG_CB_MF_AWADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_CB_MF_BRESP : out std_logic_vector(4 downto 0);
      DEBUG_CB_MF_RDATA : out std_logic_vector(31 downto 0);
      DEBUG_CB_MF_RDATACONTROL : out std_logic_vector(5 downto 0);
      DEBUG_CB_MF_WDATA : out std_logic_vector(31 downto 0);
      DEBUG_CB_MF_WDATACONTROL : out std_logic_vector(6 downto 0);
      DEBUG_MF_MC_ARADDR : out std_logic_vector(31 downto 0);
      DEBUG_MF_MC_ARADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_MF_MC_AWADDR : out std_logic_vector(31 downto 0);
      DEBUG_MF_MC_AWADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_MF_MC_BRESP : out std_logic_vector(4 downto 0);
      DEBUG_MF_MC_RDATA : out std_logic_vector(31 downto 0);
      DEBUG_MF_MC_RDATACONTROL : out std_logic_vector(5 downto 0);
      DEBUG_MF_MC_WDATA : out std_logic_vector(31 downto 0);
      DEBUG_MF_MC_WDATACONTROL : out std_logic_vector(6 downto 0);
      DEBUG_MC_MP_ARADDR : out std_logic_vector(31 downto 0);
      DEBUG_MC_MP_ARADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_MC_MP_AWADDR : out std_logic_vector(31 downto 0);
      DEBUG_MC_MP_AWADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_MC_MP_BRESP : out std_logic_vector(4 downto 0);
      DEBUG_MC_MP_RDATA : out std_logic_vector(31 downto 0);
      DEBUG_MC_MP_RDATACONTROL : out std_logic_vector(5 downto 0);
      DEBUG_MC_MP_WDATA : out std_logic_vector(31 downto 0);
      DEBUG_MC_MP_WDATACONTROL : out std_logic_vector(6 downto 0);
      DEBUG_MP_MR_ARADDR : out std_logic_vector(31 downto 0);
      DEBUG_MP_MR_ARADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_MP_MR_AWADDR : out std_logic_vector(31 downto 0);
      DEBUG_MP_MR_AWADDRCONTROL : out std_logic_vector(23 downto 0);
      DEBUG_MP_MR_BRESP : out std_logic_vector(4 downto 0);
      DEBUG_MP_MR_RDATA : out std_logic_vector(31 downto 0);
      DEBUG_MP_MR_RDATACONTROL : out std_logic_vector(5 downto 0);
      DEBUG_MP_MR_WDATA : out std_logic_vector(31 downto 0);
      DEBUG_MP_MR_WDATACONTROL : out std_logic_vector(6 downto 0)
    );
  end component;

  component bfm_system_controller_inst_wrapper is
    port (
      S_AXI_ACLK : in std_logic;
      S_AXI_ARESETN : in std_logic;
      S_AXI_AWADDR : in std_logic_vector(31 downto 0);
      S_AXI_AWVALID : in std_logic;
      S_AXI_WDATA : in std_logic_vector(31 downto 0);
      S_AXI_WSTRB : in std_logic_vector(3 downto 0);
      S_AXI_WVALID : in std_logic;
      S_AXI_BREADY : in std_logic;
      S_AXI_ARADDR : in std_logic_vector(31 downto 0);
      S_AXI_ARVALID : in std_logic;
      S_AXI_RREADY : in std_logic;
      S_AXI_ARREADY : out std_logic;
      S_AXI_RDATA : out std_logic_vector(31 downto 0);
      S_AXI_RRESP : out std_logic_vector(1 downto 0);
      S_AXI_RVALID : out std_logic;
      S_AXI_WREADY : out std_logic;
      S_AXI_BRESP : out std_logic_vector(1 downto 0);
      S_AXI_BVALID : out std_logic;
      S_AXI_AWREADY : out std_logic
    );
  end component;

  -- Internal signals

  signal axi4lite_bus_M_ARADDR : std_logic_vector(31 downto 0);
  signal axi4lite_bus_M_ARESETN : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_ARREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_ARVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_AWADDR : std_logic_vector(31 downto 0);
  signal axi4lite_bus_M_AWREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_AWVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_BREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_BRESP : std_logic_vector(1 downto 0);
  signal axi4lite_bus_M_BVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_RDATA : std_logic_vector(31 downto 0);
  signal axi4lite_bus_M_RREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_RRESP : std_logic_vector(1 downto 0);
  signal axi4lite_bus_M_RVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_WDATA : std_logic_vector(31 downto 0);
  signal axi4lite_bus_M_WREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_M_WSTRB : std_logic_vector(3 downto 0);
  signal axi4lite_bus_M_WVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_ARADDR : std_logic_vector(31 downto 0);
  signal axi4lite_bus_S_ARESETN : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_ARPROT : std_logic_vector(2 downto 0);
  signal axi4lite_bus_S_ARREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_ARVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_AWADDR : std_logic_vector(31 downto 0);
  signal axi4lite_bus_S_AWPROT : std_logic_vector(2 downto 0);
  signal axi4lite_bus_S_AWREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_AWVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_BREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_BRESP : std_logic_vector(1 downto 0);
  signal axi4lite_bus_S_BVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_RDATA : std_logic_vector(31 downto 0);
  signal axi4lite_bus_S_RREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_RRESP : std_logic_vector(1 downto 0);
  signal axi4lite_bus_S_RVALID : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_WDATA : std_logic_vector(31 downto 0);
  signal axi4lite_bus_S_WREADY : std_logic_vector(0 to 0);
  signal axi4lite_bus_S_WSTRB : std_logic_vector(3 downto 0);
  signal axi4lite_bus_S_WVALID : std_logic_vector(0 to 0);
  signal net_gnd0 : std_logic;
  signal net_gnd1 : std_logic_vector(0 to 0);
  signal net_gnd2 : std_logic_vector(1 downto 0);
  signal net_gnd3 : std_logic_vector(2 downto 0);
  signal net_gnd4 : std_logic_vector(3 downto 0);
  signal net_gnd8 : std_logic_vector(7 downto 0);
  signal net_gnd32 : std_logic_vector(31 downto 0);
  signal pgassign1 : std_logic_vector(0 to 0);
  signal pgassign2 : std_logic_vector(0 to 0);

begin

  -- Internal assignments

  pgassign1(0) <= sys_clk;
  pgassign2(0) <= sys_clk;
  net_gnd0 <= '0';
  net_gnd1(0 to 0) <= B"0";
  net_gnd2(1 downto 0) <= B"00";
  net_gnd3(2 downto 0) <= B"000";
  net_gnd32(31 downto 0) <= B"00000000000000000000000000000000";
  net_gnd4(3 downto 0) <= B"0000";
  net_gnd8(7 downto 0) <= B"00000000";

  bfm_processor : bfm_system_bfm_processor_wrapper
    port map (
      M_AXI_LITE_ACLK => pgassign1(0),
      M_AXI_LITE_ARESETN => axi4lite_bus_S_ARESETN(0),
      M_AXI_LITE_AWADDR => axi4lite_bus_S_AWADDR,
      M_AXI_LITE_AWPROT => axi4lite_bus_S_AWPROT,
      M_AXI_LITE_AWVALID => axi4lite_bus_S_AWVALID(0),
      M_AXI_LITE_AWREADY => axi4lite_bus_S_AWREADY(0),
      M_AXI_LITE_WDATA => axi4lite_bus_S_WDATA,
      M_AXI_LITE_WSTRB => axi4lite_bus_S_WSTRB,
      M_AXI_LITE_WVALID => axi4lite_bus_S_WVALID(0),
      M_AXI_LITE_WREADY => axi4lite_bus_S_WREADY(0),
      M_AXI_LITE_BRESP => axi4lite_bus_S_BRESP,
      M_AXI_LITE_BVALID => axi4lite_bus_S_BVALID(0),
      M_AXI_LITE_BREADY => axi4lite_bus_S_BREADY(0),
      M_AXI_LITE_ARADDR => axi4lite_bus_S_ARADDR,
      M_AXI_LITE_ARPROT => axi4lite_bus_S_ARPROT,
      M_AXI_LITE_ARVALID => axi4lite_bus_S_ARVALID(0),
      M_AXI_LITE_ARREADY => axi4lite_bus_S_ARREADY(0),
      M_AXI_LITE_RDATA => axi4lite_bus_S_RDATA,
      M_AXI_LITE_RRESP => axi4lite_bus_S_RRESP,
      M_AXI_LITE_RVALID => axi4lite_bus_S_RVALID(0),
      M_AXI_LITE_RREADY => axi4lite_bus_S_RREADY(0)
    );

  axi4lite_bus : bfm_system_axi4lite_bus_wrapper
    port map (
      INTERCONNECT_ACLK => pgassign1(0),
      INTERCONNECT_ARESETN => sys_reset,
      S_AXI_ARESET_OUT_N => axi4lite_bus_S_ARESETN(0 to 0),
      M_AXI_ARESET_OUT_N => axi4lite_bus_M_ARESETN(0 to 0),
      IRQ => open,
      S_AXI_ACLK => pgassign1(0 to 0),
      S_AXI_AWID => net_gnd1(0 to 0),
      S_AXI_AWADDR => axi4lite_bus_S_AWADDR,
      S_AXI_AWLEN => net_gnd8,
      S_AXI_AWSIZE => net_gnd3,
      S_AXI_AWBURST => net_gnd2,
      S_AXI_AWLOCK => net_gnd2,
      S_AXI_AWCACHE => net_gnd4,
      S_AXI_AWPROT => axi4lite_bus_S_AWPROT,
      S_AXI_AWQOS => net_gnd4,
      S_AXI_AWUSER => net_gnd1(0 to 0),
      S_AXI_AWVALID => axi4lite_bus_S_AWVALID(0 to 0),
      S_AXI_AWREADY => axi4lite_bus_S_AWREADY(0 to 0),
      S_AXI_WID => net_gnd1(0 to 0),
      S_AXI_WDATA => axi4lite_bus_S_WDATA,
      S_AXI_WSTRB => axi4lite_bus_S_WSTRB,
      S_AXI_WLAST => net_gnd1(0 to 0),
      S_AXI_WUSER => net_gnd1(0 to 0),
      S_AXI_WVALID => axi4lite_bus_S_WVALID(0 to 0),
      S_AXI_WREADY => axi4lite_bus_S_WREADY(0 to 0),
      S_AXI_BID => open,
      S_AXI_BRESP => axi4lite_bus_S_BRESP,
      S_AXI_BUSER => open,
      S_AXI_BVALID => axi4lite_bus_S_BVALID(0 to 0),
      S_AXI_BREADY => axi4lite_bus_S_BREADY(0 to 0),
      S_AXI_ARID => net_gnd1(0 to 0),
      S_AXI_ARADDR => axi4lite_bus_S_ARADDR,
      S_AXI_ARLEN => net_gnd8,
      S_AXI_ARSIZE => net_gnd3,
      S_AXI_ARBURST => net_gnd2,
      S_AXI_ARLOCK => net_gnd2,
      S_AXI_ARCACHE => net_gnd4,
      S_AXI_ARPROT => axi4lite_bus_S_ARPROT,
      S_AXI_ARQOS => net_gnd4,
      S_AXI_ARUSER => net_gnd1(0 to 0),
      S_AXI_ARVALID => axi4lite_bus_S_ARVALID(0 to 0),
      S_AXI_ARREADY => axi4lite_bus_S_ARREADY(0 to 0),
      S_AXI_RID => open,
      S_AXI_RDATA => axi4lite_bus_S_RDATA,
      S_AXI_RRESP => axi4lite_bus_S_RRESP,
      S_AXI_RLAST => open,
      S_AXI_RUSER => open,
      S_AXI_RVALID => axi4lite_bus_S_RVALID(0 to 0),
      S_AXI_RREADY => axi4lite_bus_S_RREADY(0 to 0),
      M_AXI_ACLK => pgassign2(0 to 0),
      M_AXI_AWID => open,
      M_AXI_AWADDR => axi4lite_bus_M_AWADDR,
      M_AXI_AWLEN => open,
      M_AXI_AWSIZE => open,
      M_AXI_AWBURST => open,
      M_AXI_AWLOCK => open,
      M_AXI_AWCACHE => open,
      M_AXI_AWPROT => open,
      M_AXI_AWREGION => open,
      M_AXI_AWQOS => open,
      M_AXI_AWUSER => open,
      M_AXI_AWVALID => axi4lite_bus_M_AWVALID(0 to 0),
      M_AXI_AWREADY => axi4lite_bus_M_AWREADY(0 to 0),
      M_AXI_WID => open,
      M_AXI_WDATA => axi4lite_bus_M_WDATA,
      M_AXI_WSTRB => axi4lite_bus_M_WSTRB,
      M_AXI_WLAST => open,
      M_AXI_WUSER => open,
      M_AXI_WVALID => axi4lite_bus_M_WVALID(0 to 0),
      M_AXI_WREADY => axi4lite_bus_M_WREADY(0 to 0),
      M_AXI_BID => net_gnd1(0 to 0),
      M_AXI_BRESP => axi4lite_bus_M_BRESP,
      M_AXI_BUSER => net_gnd1(0 to 0),
      M_AXI_BVALID => axi4lite_bus_M_BVALID(0 to 0),
      M_AXI_BREADY => axi4lite_bus_M_BREADY(0 to 0),
      M_AXI_ARID => open,
      M_AXI_ARADDR => axi4lite_bus_M_ARADDR,
      M_AXI_ARLEN => open,
      M_AXI_ARSIZE => open,
      M_AXI_ARBURST => open,
      M_AXI_ARLOCK => open,
      M_AXI_ARCACHE => open,
      M_AXI_ARPROT => open,
      M_AXI_ARREGION => open,
      M_AXI_ARQOS => open,
      M_AXI_ARUSER => open,
      M_AXI_ARVALID => axi4lite_bus_M_ARVALID(0 to 0),
      M_AXI_ARREADY => axi4lite_bus_M_ARREADY(0 to 0),
      M_AXI_RID => net_gnd1(0 to 0),
      M_AXI_RDATA => axi4lite_bus_M_RDATA,
      M_AXI_RRESP => axi4lite_bus_M_RRESP,
      M_AXI_RLAST => net_gnd1(0 to 0),
      M_AXI_RUSER => net_gnd1(0 to 0),
      M_AXI_RVALID => axi4lite_bus_M_RVALID(0 to 0),
      M_AXI_RREADY => axi4lite_bus_M_RREADY(0 to 0),
      S_AXI_CTRL_AWADDR => net_gnd32,
      S_AXI_CTRL_AWVALID => net_gnd0,
      S_AXI_CTRL_AWREADY => open,
      S_AXI_CTRL_WDATA => net_gnd32,
      S_AXI_CTRL_WVALID => net_gnd0,
      S_AXI_CTRL_WREADY => open,
      S_AXI_CTRL_BRESP => open,
      S_AXI_CTRL_BVALID => open,
      S_AXI_CTRL_BREADY => net_gnd0,
      S_AXI_CTRL_ARADDR => net_gnd32,
      S_AXI_CTRL_ARVALID => net_gnd0,
      S_AXI_CTRL_ARREADY => open,
      S_AXI_CTRL_RDATA => open,
      S_AXI_CTRL_RRESP => open,
      S_AXI_CTRL_RVALID => open,
      S_AXI_CTRL_RREADY => net_gnd0,
      INTERCONNECT_ARESET_OUT_N => open,
      DEBUG_AW_TRANS_SEQ => open,
      DEBUG_AW_ARB_GRANT => open,
      DEBUG_AR_TRANS_SEQ => open,
      DEBUG_AR_ARB_GRANT => open,
      DEBUG_AW_TRANS_QUAL => open,
      DEBUG_AW_ACCEPT_CNT => open,
      DEBUG_AW_ACTIVE_THREAD => open,
      DEBUG_AW_ACTIVE_TARGET => open,
      DEBUG_AW_ACTIVE_REGION => open,
      DEBUG_AW_ERROR => open,
      DEBUG_AW_TARGET => open,
      DEBUG_AR_TRANS_QUAL => open,
      DEBUG_AR_ACCEPT_CNT => open,
      DEBUG_AR_ACTIVE_THREAD => open,
      DEBUG_AR_ACTIVE_TARGET => open,
      DEBUG_AR_ACTIVE_REGION => open,
      DEBUG_AR_ERROR => open,
      DEBUG_AR_TARGET => open,
      DEBUG_B_TRANS_SEQ => open,
      DEBUG_R_BEAT_CNT => open,
      DEBUG_R_TRANS_SEQ => open,
      DEBUG_AW_ISSUING_CNT => open,
      DEBUG_AR_ISSUING_CNT => open,
      DEBUG_W_BEAT_CNT => open,
      DEBUG_W_TRANS_SEQ => open,
      DEBUG_BID_TARGET => open,
      DEBUG_BID_ERROR => open,
      DEBUG_RID_TARGET => open,
      DEBUG_RID_ERROR => open,
      DEBUG_SR_SC_ARADDR => open,
      DEBUG_SR_SC_ARADDRCONTROL => open,
      DEBUG_SR_SC_AWADDR => open,
      DEBUG_SR_SC_AWADDRCONTROL => open,
      DEBUG_SR_SC_BRESP => open,
      DEBUG_SR_SC_RDATA => open,
      DEBUG_SR_SC_RDATACONTROL => open,
      DEBUG_SR_SC_WDATA => open,
      DEBUG_SR_SC_WDATACONTROL => open,
      DEBUG_SC_SF_ARADDR => open,
      DEBUG_SC_SF_ARADDRCONTROL => open,
      DEBUG_SC_SF_AWADDR => open,
      DEBUG_SC_SF_AWADDRCONTROL => open,
      DEBUG_SC_SF_BRESP => open,
      DEBUG_SC_SF_RDATA => open,
      DEBUG_SC_SF_RDATACONTROL => open,
      DEBUG_SC_SF_WDATA => open,
      DEBUG_SC_SF_WDATACONTROL => open,
      DEBUG_SF_CB_ARADDR => open,
      DEBUG_SF_CB_ARADDRCONTROL => open,
      DEBUG_SF_CB_AWADDR => open,
      DEBUG_SF_CB_AWADDRCONTROL => open,
      DEBUG_SF_CB_BRESP => open,
      DEBUG_SF_CB_RDATA => open,
      DEBUG_SF_CB_RDATACONTROL => open,
      DEBUG_SF_CB_WDATA => open,
      DEBUG_SF_CB_WDATACONTROL => open,
      DEBUG_CB_MF_ARADDR => open,
      DEBUG_CB_MF_ARADDRCONTROL => open,
      DEBUG_CB_MF_AWADDR => open,
      DEBUG_CB_MF_AWADDRCONTROL => open,
      DEBUG_CB_MF_BRESP => open,
      DEBUG_CB_MF_RDATA => open,
      DEBUG_CB_MF_RDATACONTROL => open,
      DEBUG_CB_MF_WDATA => open,
      DEBUG_CB_MF_WDATACONTROL => open,
      DEBUG_MF_MC_ARADDR => open,
      DEBUG_MF_MC_ARADDRCONTROL => open,
      DEBUG_MF_MC_AWADDR => open,
      DEBUG_MF_MC_AWADDRCONTROL => open,
      DEBUG_MF_MC_BRESP => open,
      DEBUG_MF_MC_RDATA => open,
      DEBUG_MF_MC_RDATACONTROL => open,
      DEBUG_MF_MC_WDATA => open,
      DEBUG_MF_MC_WDATACONTROL => open,
      DEBUG_MC_MP_ARADDR => open,
      DEBUG_MC_MP_ARADDRCONTROL => open,
      DEBUG_MC_MP_AWADDR => open,
      DEBUG_MC_MP_AWADDRCONTROL => open,
      DEBUG_MC_MP_BRESP => open,
      DEBUG_MC_MP_RDATA => open,
      DEBUG_MC_MP_RDATACONTROL => open,
      DEBUG_MC_MP_WDATA => open,
      DEBUG_MC_MP_WDATACONTROL => open,
      DEBUG_MP_MR_ARADDR => open,
      DEBUG_MP_MR_ARADDRCONTROL => open,
      DEBUG_MP_MR_AWADDR => open,
      DEBUG_MP_MR_AWADDRCONTROL => open,
      DEBUG_MP_MR_BRESP => open,
      DEBUG_MP_MR_RDATA => open,
      DEBUG_MP_MR_RDATACONTROL => open,
      DEBUG_MP_MR_WDATA => open,
      DEBUG_MP_MR_WDATACONTROL => open
    );

  controller_inst : bfm_system_controller_inst_wrapper
    port map (
      S_AXI_ACLK => pgassign1(0),
      S_AXI_ARESETN => axi4lite_bus_M_ARESETN(0),
      S_AXI_AWADDR => axi4lite_bus_M_AWADDR,
      S_AXI_AWVALID => axi4lite_bus_M_AWVALID(0),
      S_AXI_WDATA => axi4lite_bus_M_WDATA,
      S_AXI_WSTRB => axi4lite_bus_M_WSTRB,
      S_AXI_WVALID => axi4lite_bus_M_WVALID(0),
      S_AXI_BREADY => axi4lite_bus_M_BREADY(0),
      S_AXI_ARADDR => axi4lite_bus_M_ARADDR,
      S_AXI_ARVALID => axi4lite_bus_M_ARVALID(0),
      S_AXI_RREADY => axi4lite_bus_M_RREADY(0),
      S_AXI_ARREADY => axi4lite_bus_M_ARREADY(0),
      S_AXI_RDATA => axi4lite_bus_M_RDATA,
      S_AXI_RRESP => axi4lite_bus_M_RRESP,
      S_AXI_RVALID => axi4lite_bus_M_RVALID(0),
      S_AXI_WREADY => axi4lite_bus_M_WREADY(0),
      S_AXI_BRESP => axi4lite_bus_M_BRESP,
      S_AXI_BVALID => axi4lite_bus_M_BVALID(0),
      S_AXI_AWREADY => axi4lite_bus_M_AWREADY(0)
    );

end architecture STRUCTURE;

