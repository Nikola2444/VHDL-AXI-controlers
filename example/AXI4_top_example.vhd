library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AXI4_top_example is
  generic (
    -- Users to add parameters here

    -- User parameters ends
    -- Do not modify the parameters beyond this line
    -- Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
    C_M_AXI_BURST_LEN    : integer := 256;
    -- Thread ID Width
    C_M_AXI_ID_WIDTH     : integer := 1;
    -- Width of Address Bus
    C_M_AXI_ADDR_WIDTH   : integer := 32;
    -- Width of Data Bus
    C_M_AXI_DATA_WIDTH   : integer := 32;
    -- Width of User Write Address Bus
    C_M_AXI_AWUSER_WIDTH : integer := 0;
    -- Width of User Read Address Bus
    C_M_AXI_ARUSER_WIDTH : integer := 0;
    -- Width of User Write Data Bus
    C_M_AXI_WUSER_WIDTH  : integer := 0;
    -- Width of User Read Data Bus
    C_M_AXI_RUSER_WIDTH  : integer := 0;
    -- Width of User Response Bus
    C_M_AXI_BUSER_WIDTH  : integer := 0
    );
  port (
    -- Users to add ports here if needed


    -- User ports ends

    -- Global Clock Signal.
    M_AXI_ACLK    : in  std_logic;
    -- Global Reset Singal. This Signal is Active Low
    M_AXI_ARESETN : in  std_logic;
    -- Master Interface Write Address ID
    M_AXI_AWID    : out std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
    -- Master Interface Write Address
    M_AXI_AWADDR  : out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
    -- Burst length. The burst length gives the exact number of transfers in a burst
    M_AXI_AWLEN   : out std_logic_vector(7 downto 0);
    -- Burst size. This signal indicates the size of each transfer in the burst
    M_AXI_AWSIZE  : out std_logic_vector(2 downto 0);
    -- Burst type. The burst type and the size information, 
    -- determine how the address for each transfer within the burst is calculated.
    M_AXI_AWBURST : out std_logic_vector(1 downto 0);
    -- Lock type. Provides additional information about the
    -- atomic characteristics of the transfer.
    M_AXI_AWLOCK  : out std_logic;
    -- Memory type. This signal indicates how transactions
    -- are required to progress through a system.
    M_AXI_AWCACHE : out std_logic_vector(3 downto 0);
    -- Protection type. This signal indicates the privilege
    -- and security level of the transaction, and whether
    -- the transaction is a data access or an instruction access.
    M_AXI_AWPROT  : out std_logic_vector(2 downto 0);
    -- Quality of Service, QoS identifier sent for each write transaction.
    M_AXI_AWQOS   : out std_logic_vector(3 downto 0);
    -- Optional User-defined signal in the write address channel.
    M_AXI_AWUSER  : out std_logic_vector(C_M_AXI_AWUSER_WIDTH-1 downto 0);
    -- Write address valid. This signal indicates that
    -- the channel is signaling valid write address and control information.
    M_AXI_AWVALID : out std_logic;
    -- Write address ready. This signal indicates that
    -- the slave is ready to accept an address and associated control signals
    M_AXI_AWREADY : in  std_logic;
    -- Master Interface Write Data.
    M_AXI_WDATA   : out std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
    -- Write strobes. This signal indicates which byte
    -- lanes hold valid data. There is one write strobe
    -- bit for each eight bits of the write data bus.
    M_AXI_WSTRB   : out std_logic_vector(C_M_AXI_DATA_WIDTH/8-1 downto 0);
    -- Write last. This signal indicates the last transfer in a write burst.
    M_AXI_WLAST   : out std_logic;
    -- Optional User-defined signal in the write data channel.
    M_AXI_WUSER   : out std_logic_vector(C_M_AXI_WUSER_WIDTH-1 downto 0);
    -- Write valid. This signal indicates that valid write
    -- data and strobes are available
    M_AXI_WVALID  : out std_logic;
    -- Write ready. This signal indicates that the slave
    -- can accept the write data.
    M_AXI_WREADY  : in  std_logic;
    -- Master Interface Write Response.
    M_AXI_BID     : in  std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
    -- Write response. This signal indicates the status of the write transaction.
    M_AXI_BRESP   : in  std_logic_vector(1 downto 0);
    -- Optional User-defined signal in the write response channel
    M_AXI_BUSER   : in  std_logic_vector(C_M_AXI_BUSER_WIDTH-1 downto 0);
    -- Write response valid. This signal indicates that the
    -- channel is signaling a valid write response.
    M_AXI_BVALID  : in  std_logic;
    -- Response ready. This signal indicates that the master
    -- can accept a write response.
    M_AXI_BREADY  : out std_logic;
    -- Master Interface Read Address.
    M_AXI_ARID    : out std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
    -- Read address. This signal indicates the initial
    -- address of a read burst transaction.
    M_AXI_ARADDR  : out std_logic_vector(C_M_AXI_ADDR_WIDTH-1 downto 0);
    -- Burst length. The burst length gives the exact number of transfers in a burst
    M_AXI_ARLEN   : out std_logic_vector(7 downto 0);
    -- Burst size. This signal indicates the size of each transfer in the burst
    M_AXI_ARSIZE  : out std_logic_vector(2 downto 0);
    -- Burst type. The burst type and the size information, 
    -- determine how the address for each transfer within the burst is calculated.
    M_AXI_ARBURST : out std_logic_vector(1 downto 0);
    -- Lock type. Provides additional information about the
    -- atomic characteristics of the transfer.
    M_AXI_ARLOCK  : out std_logic;
    -- Memory type. This signal indicates how transactions
    -- are required to progress through a system.
    M_AXI_ARCACHE : out std_logic_vector(3 downto 0);
    -- Protection type. This signal indicates the privilege
    -- and security level of the transaction, and whether
    -- the transaction is a data access or an instruction access.
    M_AXI_ARPROT  : out std_logic_vector(2 downto 0);
    -- Quality of Service, QoS identifier sent for each read transaction
    M_AXI_ARQOS   : out std_logic_vector(3 downto 0);
    -- Optional User-defined signal in the read address channel.
    M_AXI_ARUSER  : out std_logic_vector(C_M_AXI_ARUSER_WIDTH-1 downto 0);
    -- Write address valid. This signal indicates that
    -- the channel is signaling valid read address and control information
    M_AXI_ARVALID : out std_logic;
    -- Read address ready. This signal indicates that
    -- the slave is ready to accept an address and associated control signals
    M_AXI_ARREADY : in  std_logic;
    -- Read ID tag. This signal is the identification tag
    -- for the read data group of signals generated by the slave.
    M_AXI_RID     : in  std_logic_vector(C_M_AXI_ID_WIDTH-1 downto 0);
    -- Master Read Data
    M_AXI_RDATA   : in  std_logic_vector(C_M_AXI_DATA_WIDTH-1 downto 0);
    -- Read response. This signal indicates the status of the read transfer
    M_AXI_RRESP   : in  std_logic_vector(1 downto 0);
    -- Read last. This signal indicates the last transfer in a read burst
    M_AXI_RLAST   : in  std_logic;
    -- Optional User-defined signal in the read address channel.
    M_AXI_RUSER   : in  std_logic_vector(C_M_AXI_RUSER_WIDTH-1 downto 0);
    -- Read valid. This signal indicates that the channel
    -- is signaling the required read data.
    M_AXI_RVALID  : in  std_logic;
    -- Read ready. This signal indicates that the master can
    -- accept the read data and response information.
    M_AXI_RREADY  : out std_logic
    );
end AXI4_top_example;


architecture beh of AXI4_top_example is

  signal axi_base_address_i  : std_logic_vector(31 downto 0);
  signal axi_write_address_i : std_logic_vector(31 downto 0);
  signal axi_write_init_i    : std_logic;
  signal axi_write_data_i    : std_logic_vector(31 downto 0);
  signal axi_write_vld_i     : std_logic;
  signal axi_write_rdy_o     : std_logic;
  signal axi_write_done_o    : std_logic;
  signal axi_read_address_i  : std_logic_vector(31 downto 0);
  signal axi_read_init_i     : std_logic;
  signal axi_read_data_o     : std_logic_vector(31 downto 0);
  signal axi_read_vld_o      : std_logic;
  signal axi_read_rdy_i      : std_logic;
  signal axi_read_last_o     : std_logic;

  signal axi_rready_s : std_logic;

  signal bram_w_addr_cnt : std_logic_vector(8 downto 0);
  signal bram_r_addr_cnt : std_logic_vector(8 downto 0);
  signal bram_wdata      : std_logic_vector(31 downto 0);
  signal bram_wea        : std_logic_vector(3 downto 0);
  signal bram_en        : std_logic;
  signal bram_rdata     : std_logic_vector(31 downto 0);
begin

  RISCV_AXI_v2_0_AXIF_M_1 : entity work.RISCV_AXI_v2_0_AXIF_M
    generic map (
      C_M_AXI_BURST_LEN    => C_M_AXI_BURST_LEN,
      C_M_AXI_ID_WIDTH     => C_M_AXI_ID_WIDTH,
      C_M_AXI_ADDR_WIDTH   => C_M_AXI_ADDR_WIDTH,
      C_M_AXI_DATA_WIDTH   => C_M_AXI_DATA_WIDTH,
      C_M_AXI_AWUSER_WIDTH => C_M_AXI_AWUSER_WIDTH,
      C_M_AXI_ARUSER_WIDTH => C_M_AXI_ARUSER_WIDTH,
      C_M_AXI_WUSER_WIDTH  => C_M_AXI_WUSER_WIDTH,
      C_M_AXI_RUSER_WIDTH  => C_M_AXI_RUSER_WIDTH,
      C_M_AXI_BUSER_WIDTH  => C_M_AXI_BUSER_WIDTH)
    port map (
      -- User data
      -- Write channel
      axi_base_address_i  => axi_base_address_i,
      axi_write_address_i => axi_write_address_i,
      axi_write_init_i    => axi_write_init_i,
      axi_write_data_i    => axi_write_data_i,
      axi_write_vld_i     => axi_write_vld_i,
      axi_write_rdy_o     => axi_write_rdy_o,
      -- Read channel     
      axi_write_done_o    => axi_write_done_o,
      axi_read_address_i  => axi_read_address_i,
      axi_read_init_i     => axi_read_init_i,
      axi_read_data_o     => axi_read_data_o,
      axi_read_vld_o      => axi_read_vld_o,
      axi_read_rdy_i      => axi_read_rdy_i,
      axi_read_last_o     => axi_read_last_o,
      --AXI4 signals
      M_AXI_ACLK          => M_AXI_ACLK,
      M_AXI_ARESETN       => M_AXI_ARESETN,
      M_AXI_AWID          => M_AXI_AWID,
      M_AXI_AWADDR        => M_AXI_AWADDR,
      M_AXI_AWLEN         => M_AXI_AWLEN,
      M_AXI_AWSIZE        => M_AXI_AWSIZE,
      M_AXI_AWBURST       => M_AXI_AWBURST,
      M_AXI_AWLOCK        => M_AXI_AWLOCK,
      M_AXI_AWCACHE       => M_AXI_AWCACHE,
      M_AXI_AWPROT        => M_AXI_AWPROT,
      M_AXI_AWQOS         => M_AXI_AWQOS,
      M_AXI_AWUSER        => M_AXI_AWUSER,
      M_AXI_AWVALID       => M_AXI_AWVALID,
      M_AXI_AWREADY       => M_AXI_AWREADY,
      M_AXI_WDATA         => M_AXI_WDATA,
      M_AXI_WSTRB         => M_AXI_WSTRB,
      M_AXI_WLAST         => M_AXI_WLAST,
      M_AXI_WUSER         => M_AXI_WUSER,
      M_AXI_WVALID        => M_AXI_WVALID,
      M_AXI_WREADY        => M_AXI_WREADY,
      M_AXI_BID           => M_AXI_BID,
      M_AXI_BRESP         => M_AXI_BRESP,
      M_AXI_BUSER         => M_AXI_BUSER,
      M_AXI_BVALID        => M_AXI_BVALID,
      M_AXI_BREADY        => M_AXI_BREADY,
      M_AXI_ARID          => M_AXI_ARID,
      M_AXI_ARADDR        => M_AXI_ARADDR,
      M_AXI_ARLEN         => M_AXI_ARLEN,
      M_AXI_ARSIZE        => M_AXI_ARSIZE,
      M_AXI_ARBURST       => M_AXI_ARBURST,
      M_AXI_ARLOCK        => M_AXI_ARLOCK,
      M_AXI_ARCACHE       => M_AXI_ARCACHE,
      M_AXI_ARPROT        => M_AXI_ARPROT,
      M_AXI_ARQOS         => M_AXI_ARQOS,
      M_AXI_ARUSER        => M_AXI_ARUSER,
      M_AXI_ARVALID       => M_AXI_ARVALID,
      M_AXI_ARREADY       => M_AXI_ARREADY,
      M_AXI_RID           => M_AXI_RID,
      M_AXI_RDATA         => M_AXI_RDATA,
      M_AXI_RRESP         => M_AXI_RRESP,
      M_AXI_RLAST         => M_AXI_RLAST,
      M_AXI_RUSER         => M_AXI_RUSER,
      M_AXI_RVALID        => M_AXI_RVALID,
      M_AXI_RREADY        => M_AXI_RREADY);



  axi_read_rdy_i      <= '1';
  axi_base_address_i  <= x"01001000";
  axi_write_address_i <= x"00000400";
  axi_read_address_i  <= x"00000000";

  process (M_AXI_ACLK)is
  begin
    --counter which shows where in BRAM to write
    if (rising_edge(M_AXI_ACLK)) then
      if (M_AXI_ARESETN = '0' or axi_read_init_i = '1') then
        bram_w_addr_cnt <= (others => '0');
      elsif (axi_read_vld_o = '1' and axi_read_rdy_i = '1') then
        bram_w_addr_cnt <= std_logic_vector(unsigned(bram_w_addr_cnt) + to_unsigned(1, 8));
      end if;

      if (M_AXI_ARESETN = '0') then
        axi_write_init_i <= '1';
      elsif (axi_read_last_o = '1' and axi_write_init_i = '0') then
        axi_write_init_i <= '1';
      else
        axi_write_init_i <= '0';
      end if;

      if (M_AXI_ARESETN = '0' or axi_write_done_o = '1') then
        axi_read_init_i <= '1';
      elsif (axi_read_init_i = '1') then
        axi_read_init_i <= '0';
      end if;
    end if;
  end process;


  bram_wdata <= std_logic_vector(unsigned(axi_read_data_o) + to_unsigned(10, 32));

  process (M_AXI_ACLK)is
  begin
    if (rising_edge(M_AXI_ACLK)) then
      if (M_AXI_ARESETN = '0' or axi_write_done_o = '1') then
        bram_r_addr_cnt <= (others => '0');
        axi_write_data_i <= (others => '0');
      elsif (axi_write_rdy_o = '1' or axi_write_init_i = '1') then
        axi_write_data_i <= bram_rdata;
        bram_r_addr_cnt <= std_logic_vector(unsigned(bram_r_addr_cnt) + to_unsigned(1, 8));
      end if;
    end if;
  end process;

  process (M_AXI_ACLK)is
  begin
    if (rising_edge(M_AXI_ACLK)) then
      if (M_AXI_ARESETN = '0' or axi_write_done_o = '1') then
        axi_write_vld_i <= '0';
      elsif (axi_write_init_i = '1') then
        axi_write_vld_i <= '1';
      end if;
    end if;
    
    
  end process;

  bram_wea <= (others => axi_read_vld_o);
  bram_en <= '1';
  -- BRAM MEM
  bytewrite_tdp_ram_rf_1 : entity work.bytewrite_tdp_ram_rf
    generic map (
      SIZE       => 256,
      ADDR_WIDTH => 8,
      COL_WIDTH  => 8,
      NB_COL     => 4)
    port map (
      clka  => M_AXI_ACLK,
      ena   => '1',
      wea   => bram_wea,
      addra => bram_w_addr_cnt(7 downto 0),
      dia   => bram_wdata,
      doa   => open,
      clkb  => M_AXI_ACLK,
      enb   => bram_en,
      web   => "0000",
      addrb => bram_r_addr_cnt (7 downto 0),
      dib   => (others => '0'),
      dob   => bram_rdata);
end beh;
