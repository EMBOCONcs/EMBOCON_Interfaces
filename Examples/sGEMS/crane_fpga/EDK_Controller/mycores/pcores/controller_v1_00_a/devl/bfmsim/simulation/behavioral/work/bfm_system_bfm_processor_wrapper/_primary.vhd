library verilog;
use verilog.vl_types.all;
entity bfm_system_bfm_processor_wrapper is
    port(
        M_AXI_LITE_ACLK : in     vl_logic;
        M_AXI_LITE_ARESETN: in     vl_logic;
        M_AXI_LITE_AWADDR: out    vl_logic_vector(31 downto 0);
        M_AXI_LITE_AWPROT: out    vl_logic_vector(2 downto 0);
        M_AXI_LITE_AWVALID: out    vl_logic;
        M_AXI_LITE_AWREADY: in     vl_logic;
        M_AXI_LITE_WDATA: out    vl_logic_vector(31 downto 0);
        M_AXI_LITE_WSTRB: out    vl_logic_vector(3 downto 0);
        M_AXI_LITE_WVALID: out    vl_logic;
        M_AXI_LITE_WREADY: in     vl_logic;
        M_AXI_LITE_BRESP: in     vl_logic_vector(1 downto 0);
        M_AXI_LITE_BVALID: in     vl_logic;
        M_AXI_LITE_BREADY: out    vl_logic;
        M_AXI_LITE_ARADDR: out    vl_logic_vector(31 downto 0);
        M_AXI_LITE_ARPROT: out    vl_logic_vector(2 downto 0);
        M_AXI_LITE_ARVALID: out    vl_logic;
        M_AXI_LITE_ARREADY: in     vl_logic;
        M_AXI_LITE_RDATA: in     vl_logic_vector(31 downto 0);
        M_AXI_LITE_RRESP: in     vl_logic_vector(1 downto 0);
        M_AXI_LITE_RVALID: in     vl_logic;
        M_AXI_LITE_RREADY: out    vl_logic
    );
end bfm_system_bfm_processor_wrapper;
