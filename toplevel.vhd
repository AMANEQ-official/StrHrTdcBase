library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

library mylib;
use mylib.defBCT.all;
use mylib.defBusAddressMap.all;
use mylib.defCDCM.all;
use mylib.defMikumari.all;
use mylib.defMikumariUtil.all;
use mylib.defLaccp.all;
use mylib.defHeartBeatUnit.all;
use mylib.defFreeRunScaler.all;
--use mylib.defSiTCP.all;
use mylib.defRBCP.all;
--use mylib.defMiiRstTimer.all;

use mylib.defMIF.all;
use mylib.defDCT.all;
use mylib.defDDRReceiverV2.all;
use mylib.defSiTCP_XG.all;

use mylib.defDataBusAbst.all;
use mylib.defDelimiter.all;

entity toplevel is
  Port (
    -- System ----------------------------------------------------------------
    BASE_CLKP       : in std_logic;
    BASE_CLKN       : in std_logic;
    LED             : out std_logic_vector(4 downto 1);
    DIP             : in  std_logic_vector(4 downto 1);
    PROGB_ON        : out std_logic;
    USR_RSTB        : in std_logic;
    VP              : in std_logic; -- XADC
    VN              : in std_logic; -- XADC

    -- GTX ------------------------------------------------------------------
    GTX_REFCLK_P    : in std_logic;
    GTX_REFCLK_N    : in std_logic;
    GTX_TX_P        : out std_logic_vector(1 downto 1);
    GTX_TX_N        : out std_logic_vector(1 downto 1);
    GTX_RX_P        : in  std_logic_vector(1 downto 1);
    GTX_RX_N        : in  std_logic_vector(1 downto 1);

    -- SPI flash memory ------------------------------------------------------
    FCSB            : out std_logic;
--    USR_CLK       : out std_logic;
    MOSI            : out std_logic;
    DIN             : in  std_logic;

    -- MIKUMARI PORT -----------------------------------------------------
    MIKUMARI_RXP         : in std_logic;
    MIKUMARI_RXN         : in std_logic;
    MIKUMARI_TXP         : out std_logic;
    MIKUMARI_TXN         : out std_logic;

    -- EEPROM ----------------------------------------------------------------
    EEP_CS	        : out std_logic_vector(1 downto 1);
    EEP_SK          : out std_logic_vector(1 downto 1);
    EEP_DI          : out std_logic_vector(1 downto 1);
    EEP_DO          : in  std_logic_vector(1 downto 1);

    -- User I/O --------------------------------------------------------------
    NIM_IN          : in  std_logic_vector(2 downto 1);
    NIM_OUT         : out std_logic_vector(2 downto 1);

    -- JItter cleaner -------------------------------------------------------
    CDCE_PDB        : out std_logic;
    CDCE_LOCK       : in std_logic;
    CDCE_SCLK       : out std_logic;
    CDCE_SO         : in std_logic;
    CDCE_SI         : out std_logic;
    CDCE_LE         : out std_logic;
    CDCE_REFP       : out std_logic;
    CDCE_REFN       : out std_logic;

    CLK_FASTP       : in std_logic;
    CLK_FASTN       : in std_logic;
    CLK_SLOWP       : in std_logic;
    CLK_SLOWN       : in std_logic;

    -- Main signal input ----------------------------------------------------
--    MAIN_IN_U : in std_logic_vector(kNumInput-1 downto 0); -- 0-31 ch
--    MAIN_IN_D : in std_logic_vector(kNumInput-1 downto 0); -- 32-63 ch

    -- Mezzanine signal ----------------------------------------------------
    -- -- Mezzanine slot-U
    -- MIKUMARI --
    MZNU_CDCM_TXP     : out std_logic;
    MZNU_CDCM_TXN     : out std_logic;
    MZNU_CDCM_RXP     : in std_logic;
    MZNU_CDCM_RXN     : in std_logic;

    -- SYSTEM --
    MZNU_FRST_P       : out std_logic;
    MZNU_FRST_N       : out std_logic;
    MZNU_CLKHUL_P     : out std_logic;
    MZNU_CLKHUL_N     : out std_logic;
    MZNU_SLOT_POS_P   : out std_logic;
    MZNU_SLOT_POS_N   : out std_logic;

    -- Bus Bridge --
    MZNU_PRI_ACTIVE_P : out std_logic;
    MZNU_PRI_ACTIVE_N : out std_logic;
    MZNU_SCN_REQ_P    : in std_logic;
    MZNU_SCN_REQ_N    : in std_logic;
    MZNU_CLK_P        : out std_logic;
    MZNU_CLK_N        : out std_logic;
    MZNU_PISO_P       : in std_logic;
    MZNU_PISO_N       : in std_logic;
    MZNU_POSI_P       : out std_logic;
    MZNU_POSI_N       : out std_logic;

    -- DDR Receiver --
    MZNU_CLKDDR_P    : in std_logic;
    MZNU_CLKDDR_N    : in std_logic;
    MZNU_DDRD_P      : in std_logic_vector(kNumDDR-1 downto 0);
    MZNU_DDRD_N      : in std_logic_vector(kNumDDR-1 downto 0);

    -- Status --
    MZNU_STATUS_IN_P  : in std_logic_vector(kWidthStatusMzn-1 downto 0);
    MZNU_STATUS_IN_N  : in std_logic_vector(kWidthStatusMzn-1 downto 0);
    MZNU_STATUS_OUT_P : out std_logic_vector(kWidthStatusBase-1 downto 0);
    MZNU_STATUS_OUT_N : out std_logic_vector(kWidthStatusBase-1 downto 0);

    -- Mezzanine slot-D --
    -- MIKUMARI --
    MZND_CDCM_TXP     : out std_logic;
    MZND_CDCM_TXN     : out std_logic;
    MZND_CDCM_RXP     : in std_logic;
    MZND_CDCM_RXN     : in std_logic;

    -- System --
    MZND_FRST_P       : out std_logic;
    MZND_FRST_N       : out std_logic;
    MZND_CLKHUL_P     : out std_logic;
    MZND_CLKHUL_N     : out std_logic;
    MZND_SLOT_POS_P   : out std_logic;
    MZND_SLOT_POS_N   : out std_logic;

    -- Bus Bridge --
    MZND_PRI_ACTIVE_P : out std_logic;
    MZND_PRI_ACTIVE_N : out std_logic;
    MZND_SCN_REQ_P    : in std_logic;
    MZND_SCN_REQ_N    : in std_logic;
    MZND_CLK_P        : out std_logic;
    MZND_CLK_N        : out std_logic;
    MZND_PISO_P       : in std_logic;
    MZND_PISO_N       : in std_logic;
    MZND_POSI_P       : out std_logic;
    MZND_POSI_N       : out std_logic;

    -- DDR Receiver --
    MZND_CLKDDR_P    : in std_logic;
    MZND_CLKDDR_N    : in std_logic;
    MZND_DDRD_P      : in std_logic_vector(kNumDDR-1 downto 0);
    MZND_DDRD_N      : in std_logic_vector(kNumDDR-1 downto 0);

    -- Status --
    MZND_STATUS_IN_P  : in std_logic_vector(kWidthStatusMzn-1 downto 0);
    MZND_STATUS_IN_N  : in std_logic_vector(kWidthStatusMzn-1 downto 0);
    MZND_STATUS_OUT_P : out std_logic_vector(kWidthStatusBase-1 downto 0);
    MZND_STATUS_OUT_N : out std_logic_vector(kWidthStatusBase-1 downto 0)

    );
end toplevel;

architecture Behavioral of toplevel is
  attribute mark_debug  : string;
  attribute keep        : string;
  constant  kEnDebugTop : string:= "false";

  -- System ------------------------------------------------------------------
  -- AMANEQ specification
  constant kNumLED     : integer:= 4;
  constant kNumBitDIP  : integer:= 4;
  constant kNumNIM     : integer:= 2;
  constant kNumGtx     : integer:= 1;

  signal async_reset  : std_logic;
  signal system_reset : std_logic;
  signal system_reset_xgmii : std_logic;
  signal pwr_on_reset : std_logic;
  signal user_reset   : std_logic;
  signal bct_reset    : std_logic;

  signal core_master_reset  : std_logic;

  signal emergency_reset : std_logic;
  attribute keep of user_reset        : signal is "true";
  attribute keep of bct_reset         : signal is "true";
  attribute keep of emergency_reset   : signal is "true";
  signal rst_from_bus : std_logic;

  signal force_reset_u : std_logic;
  signal force_reset_d : std_logic;

  signal sync_nim_in      : std_logic_vector(NIM_IN'range);
  signal tmp_nim_out      : std_logic_vector(NIM_OUT'range);

  -- For future extension --
  constant kNumInput    : integer:= 1;

  -- Imple --
  signal idelay_reset       : std_logic;
  signal idelayctrl_ready   : std_logic_vector(4 downto 0);
  signal local_trigger_in   : std_logic;
  signal hbu_reset          : std_logic;
  signal hbu_prim_reset     : std_logic;

  -- DIP ---------------------------------------------------------------------
  signal dip_sw       : std_logic_vector(DIP'range);
  subtype DipID is integer range 1 to 4;
  type regLeaf is record
    Index : DipID;
  end record;
  constant kSiTCP       : regLeaf := (Index => 1);
  constant kStandAlone  : regLeaf := (Index => 2);
  constant kMznDAbs     : regLeaf := (Index => 3);
  constant kTriggerOut  : regLeaf := (Index => 4);

  -- MIKUMARI -----------------------------------------------------------------------------
  attribute IODELAY_GROUP : string;
  attribute IODELAY_GROUP of u_FastDelay : label is "idelay_33";

  function GetIoDelayGroup(index: integer) return string is
  begin
    case index is
      when 0 => return "idelay_12";
      when 1 => return "idelay_13";
      when 2 => return "idelay_14";
      when 3 => return "idelay_32";
      when 4 => return "idelay_33";
      when others => return "idelay_0";
    end case;
  end function;

  constant  kPcbVersion : string:= "GN-2006-4";
  --constant  kPcbVersion : string:= "GN-2006-1";

  function GetMikuIoStd(version: string) return string is
  begin
    case version is
      when  "GN-2006-4" => return "LVDS";
      when others       => return "LVDS_25";
    end case;
  end function;

  function GetMikuIoDelay(version: string) return string is
  begin
    case version is
      when  "GN-2006-4" => return "idelay_32";
      when others       => return "idelay_14";
    end case;
  end function;

  -- Mikumari ports --
  constant kNumMikumari       : integer:= 3;
  constant kIdMikuMznU        : integer:= 0;
  constant kIdMikuMznD        : integer:= 1;
  constant kIdMikuSec         : integer:= 2;


  signal miku_txp, miku_txn, miku_rxp, miku_rxn   : std_logic_vector(kNumMikumari-1 downto 0);

  subtype MikuScalarPort is std_logic_vector(kNumMikumari-1 downto 0);

  function GetEnDebug(index: integer) return boolean is
  begin
    case index is
      when 0  => return true;
      when 1  => return false;
      when 2  => return false;
    end case;
  end function GetEnDebug;

  -- For primary module --
  function GetTxIoStd(version : string; index : integer) return string is
  begin
    if(index = kIdMikuSec) then
      return GetMikuIoStd(version);
    elsif(index = kIdMikuMznU) then
      return "LVDS_25";
    elsif(index = kIdMikuMznD) then
      return "LVDS";
    else
      return "LVDS";
    end if;
  end function;

  function GetRxIoStd(version : string; index : integer) return string is
  begin
    if(index = kIdMikuSec) then
      return GetMikuIoStd(version);
    elsif(index = kIdMikuMznU) then
      return "LVDS_25";
    elsif(index = kIdMikuMznD) then
      return "LVDS";
    else
      return "LVDS";
    end if;
  end function;

  function GetIoGroup(version : string; index : integer) return string is
  begin
    if(index = kIdMikuSec) then
      return GetMikuIoDelay(kPcbVersion);
    elsif(index = kIdMikuMznU) then
      return "idelay_13";
    elsif(index = kIdMikuMznD) then
      return "idelay_32";
    else
      return "idelay_0";
    end if;
  end function;

  -- CDCM --
  signal power_on_init        : std_logic;

  signal cbt_lane_up          : MikuScalarPort;
  signal pattern_error        : MikuScalarPort;
  signal watchdog_error       : MikuScalarPort;

  signal mod_clk, gmod_clk    : std_logic;

  --type TapValueArray  is array(kNumMikumari-1 downto 0) of std_logic_vector(kWidthTap-1 downto 0);
  --type SerdesOffsetArray is array(kNumMikumari-1 downto 0) of signed(kWidthSerdesOffset-1 downto 0);
  signal tap_value_out        : TapArrayType(kNumMikumari-1 downto 0);
  signal bitslip_num_out      : BitslipArrayType(kNumMikumari-1 downto 0);
  signal serdes_offset        : SerdesOfsArrayType(kNumMikumari-1 downto 0);

  attribute mark_debug of power_on_init   : signal is kEnDebugTop;

  -- Mikumari --
  type MikuDataArray is array(kNumMikumari-1 downto 0) of std_logic_vector(7 downto 0);
  type MikuPulseTypeArray is array(kNumMikumari-1 downto 0) of MikumariPulseType;

  signal miku_tx_ack        : MikuScalarPort;
  signal miku_data_tx       : MikuDataArray;
  signal miku_valid_tx      : MikuScalarPort;
  signal miku_last_tx       : MikuScalarPort;
  signal busy_pulse_tx      : MikuScalarPort;

  signal mikumari_link_up   : MikuScalarPort;
  signal miku_data_rx       : MikuDataArray;
  signal miku_valid_rx      : MikuScalarPort;
  signal miku_last_rx       : MikuScalarPort;
  signal checksum_err       : MikuScalarPort;
  signal frame_broken       : MikuScalarPort;
  signal recv_terminated    : MikuScalarPort;

  signal pulse_tx, pulse_rx : MikuScalarPort;
  signal pulse_type_tx, pulse_type_rx  : MikuPulseTypeArray;

 -- LACCP --
  signal laccp_reset         : MikuScalarPort;
  signal laccp_pulse_in      : std_logic_vector(kNumLaccpPulse-1 downto 0);
  signal laccp_pulse_out     : std_logic_vector(kNumLaccpPulse-1 downto 0);
  signal pulse_rejected      : MikuScalarPort;

  signal is_ready_for_daq   : MikuScalarPort;
  signal sync_pulse_out     : std_logic;

  signal is_ready_laccp_intra   : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal valid_laccp_intra_in   : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal valid_laccp_intra_out  : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal data_laccp_intra_in    : ExtIntraType;
  signal data_laccp_intra_out   : ExtIntraType;

  signal prim_is_ready_laccp_intra   : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal prim_valid_laccp_intra_in   : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal prim_valid_laccp_intra_out  : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal prim_data_laccp_intra_in    : ExtIntraType;
  signal prim_data_laccp_intra_out   : ExtIntraType;

  constant kPosMzn              : std_logic_vector(kIdMikuMznD downto kIdMikuMznU):= (others => '0');
  signal is_ready_inter_up, is_ready_inter_down : std_logic_vector(kMaxNumInterconnect-1 downto 0);
  signal valid_inter_in, valid_inter_out        : std_logic_vector(kMaxNumInterconnect-1 downto 0);
  signal data_inter_in, data_inter_out          : ExtInterType;

  signal miku_fanout_reset          : std_logic;

  -- RLIGP --
  --type LinkAddrArray is array(kNumMikumari-1 downto 0) of std_logic_vector(kPosRegister'range);

  signal link_addr_partter  : IpAddrArrayType(kNumMikumari-1 downto 0);
  signal valid_link_addr    : MikuScalarPort;

  -- RCAP --
--  signal idelay_tap_in      : unsigned(tap_value_out'range);

  signal valid_hbc_offset   : std_logic;
  signal hbc_offset         : std_logic_vector(kWidthHbCount-1 downto 0);
  signal laccp_fine_offset  : signed(kWidthLaccpFineOffset-1 downto 0);
  signal local_fine_offset  : signed(kWidthLaccpFineOffset-1 downto 0);

  -- Heartbeat --
  signal hbu_is_synchronized  : std_logic;
  signal heartbeat_signal   : std_logic;
  signal heartbeat_count    : std_logic_vector(kWidthHbCount-1 downto 0);
  signal hbf_number         : std_logic_vector(kWidthHbfNum-1 downto 0);
  signal hbf_state          : HbfStateType;
  signal frame_ctrl_gate    : std_logic;
  signal hbf_num_mismatch   : std_logic;

  signal heartbeat_signal_prim   : std_logic;
  signal heartbeat_count_prim    : std_logic_vector(kWidthHbCount-1 downto 0);
  signal hbf_number_prim         : std_logic_vector(kWidthHbfNum-1 downto 0);

  signal heartbeat_signal_secnd   : std_logic;
  signal heartbeat_count_secnd    : std_logic_vector(kWidthHbCount-1 downto 0);
  signal hbf_number_secnd         : std_logic_vector(kWidthHbfNum-1 downto 0);

  signal hbf_state_prim           : HbfStateType;
  signal hbf_state_secnd          : HbfStateType;

  attribute mark_debug of is_ready_for_daq   : signal is kEnDebugTop;
  attribute mark_debug of link_addr_partter  : signal is kEnDebugTop;
  attribute mark_debug of valid_link_addr    : signal is kEnDebugTop;
  attribute mark_debug of serdes_offset      : signal is kEnDebugTop;
  attribute mark_debug of laccp_fine_offset  : signal is kEnDebugTop;
  attribute mark_debug of local_fine_offset  : signal is kEnDebugTop;

  -- Mikumari Util ------------------------------------------------------------
  signal cbt_init_from_mutil    : MikuScalarPort;
  signal rst_from_miku          : std_logic;
  signal rst_from_miku_xgmii    : std_logic;

  -- Scaler -------------------------------------------------------------------
  constant kNumExtraScr : integer:= 2;-- Trigger ++ TrgRejected
  constant kMsbScr      : integer:= kNumSysInput+kNumExtraScr+kNumInput-1;
  signal scr_en_in      : std_logic_vector(kMsbScr downto 0);

  -- Streaming TDC ------------------------------------------------------------
  signal daq_is_running  : std_logic;

  -- CDCE62002 ---------------------------------------------------------------
  signal c6c_reset    : std_logic;
  signal c6c_refclk   : std_logic;

  -- Main input ports --------------------------------------------------------

  -- Local Bus controll --
  -- MZN-U --
  signal bbpu_prim_active   : std_logic;
  signal bbpu_scnd_req      : std_logic;
  signal bbpu_clk_bridge    : std_logic;
  signal bbpu_piso          : std_logic;
  signal bbpu_posi          : std_logic;

  -- MZN-D --
  signal bbpd_prim_active   : std_logic;
  signal bbpd_scnd_req      : std_logic;
  signal bbpd_clk_bridge    : std_logic;
  signal bbpd_piso          : std_logic;
  signal bbpd_posi          : std_logic;

  -- STATUS --
  signal status_in_mznu   : std_logic_vector(kWidthStatusMzn-1 downto 0);
  signal status_in_mznd   : std_logic_vector(kWidthStatusMzn-1 downto 0);

  signal status_out_mznu  : std_logic_vector(kWidthStatusBase-1 downto 0);
  signal status_out_mznd  : std_logic_vector(kWidthStatusBase-1 downto 0);

  -- DDR receiver --
  constant kInvmaskDDRu        : invMaskDdr :=
    (false, false, false, false, false, false, false, false, false);
  constant kInvmaskDDRd        : invMaskDdr :=
    (true,  false, false, true,  true,  false, false, false, false);

  constant kNumMRGFront     : integer:= 2;
  signal ddrrx_valid_out    : std_logic_vector(kNumMRGFront-1 downto 0);
  signal ddrrx_data_out     : DataArrayType(kNumMRGFront-1 downto 0);

  signal ddrrx_re_fifo      : std_logic_vector(kNumMRGFront-1 downto 0);
  signal ddrrx_rv_fifo      : std_logic_vector(kNumMRGFront-1 downto 0);
  signal ddrrx_empty_fifo   : std_logic_vector(kNumMRGFront-1 downto 0);
  signal ddrrx_aempty_fifo  : std_logic_vector(kNumMRGFront-1 downto 0);
  signal ddrrx_dout_fifo    : DataArrayType(kNumMRGFront-1 downto 0);
  signal ddrrx_pfull        : std_logic_vector(kNumMRGFront-1 downto 0);

  attribute mark_debug of ddrrx_re_fifo       : signal is kEnDebugTop;
  attribute mark_debug of ddrrx_rv_fifo       : signal is kEnDebugTop;
  attribute mark_debug of ddrrx_dout_fifo     : signal is kEnDebugTop;
  attribute mark_debug of ddrrx_empty_fifo    : signal is kEnDebugTop;
  attribute mark_debug of ddrrx_aempty_fifo   : signal is kEnDebugTop;
  attribute mark_debug of ddrrx_pfull         : signal is kEnDebugTop;

  -- TDC ----------------------------------------------------------------------------------
  -- Back Merger --
  signal re_mgr             : std_logic;
  signal valid_mgr          : std_logic;
  signal empty_mgr          : std_logic;
  signal dout_mgr           : std_logic_vector(kWidthData-1 downto 0);

  attribute mark_debug of re_mgr      : signal is kEnDebugTop;
  attribute mark_debug of valid_mgr   : signal is kEnDebugTop;
  attribute mark_debug of empty_mgr   : signal is kEnDebugTop;
  attribute mark_debug of dout_mgr    : signal is kEnDebugTop;

  signal pfull_back_merger  : std_logic;
  signal hbfnum_mismatch    : std_logic;
  signal output_throttling_on : std_logic;
  signal input_throttling_type2_on  : std_logic;

  attribute mark_debug of  pfull_back_merger          : signal is kEnDebugTop;
  --attribute mark_debug of  input_throttling_type2_on  : signal is kEnDebugTop;

  signal din_link_buf       : std_logic_vector(kWidthData-1 downto 0);
  signal pfull_link_buf     : std_logic;

  attribute mark_debug of  pfull_link_buf    : signal is kEnDebugTop;

  COMPONENT LinkBuffer
  PORT (
    rst : IN STD_LOGIC;
    wr_clk : IN STD_LOGIC;
    rd_clk : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    valid : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
  END COMPONENT;

  -- DCT -----------------------------------------------------------------------------------
  signal reg_dct2rcv          : RegDct2RcvArray;
  signal reg_rcv2dct          : RegRcv2DctArray;

  signal frst_from_dct        : std_logic_vector(kNumDaqBlock-1 downto 0);


  -- SDS ---------------------------------------------------------------------
  signal shutdown_over_temp     : std_logic;
  signal uncorrectable_flag     : std_logic;

  -- FMP ---------------------------------------------------------------------

  -- BCT --------------------------------------------------------------------
  signal addr_LocalBus          : LocalAddressType;
  signal data_LocalBusIn        : LocalBusInType;
  signal data_LocalBusOut       : DataArray;
  signal re_LocalBus            : ControlRegArray;
  signal we_LocalBus            : ControlRegArray;
  signal ready_LocalBus         : ControlRegArray;

  -- TSD ---------------------------------------------------------------------
  signal wd_to_tsd                              : std_logic_vector(kWidthDaqData-1 downto 0);
  signal we_to_tsd, empty_to_tsd, re_from_tsd   : std_logic;

  --attribute mark_debug  of we_to_tsd      : signal is kEnDebugTop;
  --attribute mark_debug  of empty_to_tsd   : signal is kEnDebugTop;
  --attribute mark_debug  of re_from_tsd    : signal is kEnDebugTop;

  -- SiTCP-XG -------------------------------------------------------------------------------
  type typeIpAddr  is array(kNumGtx-1 downto 0) of std_logic_vector(31 downto 0);

  signal sitcp_ip_addr  : typeIpAddr;

  signal tcp_is_active, close_req, close_ack    : std_logic;

  signal tcp_tx_afull : std_logic;
  signal tcp_txb      : std_logic_vector(kNumByteTCPXG'range);
  signal tcp_txd      : std_logic_vector(kWidthDataXGMII-1 downto 0);

  signal tcp_rx_clr_enb   : std_logic;
  signal tcp_rx_wadr      : std_logic_vector(kWidthAddrRx-1 downto 0);

  signal rbcp_addr    : std_logic_vector(kWidthAddrRBCP-1 downto 0);
  signal rbcp_wd      : std_logic_vector(kWidthDataRBCP-1 downto 0);
  signal rbcp_we      : std_logic;
  signal rbcp_re      : std_logic;
  signal rbcp_ack     : std_logic;
  signal rbcp_rd      : std_logic_vector(kWidthDataRBCP-1 downto 0);

  signal rbcp_xg_addr    : std_logic_vector(kWidthAddrRBCP-1 downto 0);
  signal rbcp_xg_wd      : std_logic_vector(kWidthDataRBCP-1 downto 0);
  signal rbcp_xg_we      : std_logic;
  signal rbcp_xg_re      : std_logic;
  signal rbcp_xg_ack     : std_logic;
  signal rbcp_xg_rd      : std_logic_vector(kWidthDataRBCP-1 downto 0);


  component WRAP_SiTCPXG_XC7K_128K
    generic(
      RxBufferSize	: string
      );
    port(
      REG_FPGA_VER              : in std_logic_vector(31 downto 0);
      REG_FPGA_ID               : in std_logic_vector(31 downto 0);

      --		==== System I/F ====
      FORCE_DEFAULTn            : in std_logic;
      XGMII_CLOCK               : in std_logic;
      RSTs                      : in std_logic;

      --		==== XGMII I/F ====
      XGMII_RXC 								: in std_logic_vector(7 downto 0);
      XGMII_RXD 								: in std_logic_vector(63 downto 0);
      XGMII_TXC									: out std_logic_vector(7 downto 0);
			XGMII_TXD									: out std_logic_vector(63 downto 0);

      --		==== 93C46 I/F ====
			EEPROM_CS									: out std_logic;
			EEPROM_SK									: out std_logic;
			EEPROM_DI									: out std_logic;
      EEPROM_DO									: in std_logic;

      --		==== User I/F ====
      SiTCP_RESET_OUT	          : out std_logic;
      IP_ADDR                   : out std_logic_vector(31 downto 0);
      --		--- RBCP ---
			RBCP_ACT                  : out std_logic;
			RBCP_ADDR                 : out std_logic_vector(31 downto 0);
			RBCP_WE										: out std_logic;
			RBCP_WD										: out std_logic_vector(7 downto 0);
			RBCP_RE										: out std_logic;
      RBCP_ACK                  : in std_logic;
			RBCP_RD	                  : in std_logic_vector(7 downto 0);
      -- --- TCP ---
      USER_SESSION_OPEN_REQ	    : in std_logic;
		 	USER_SESSION_ESTABLISHED  : out std_logic;
		 	USER_SESSION_CLOSE_REQ    : out std_logic;
      USER_SESSION_CLOSE_ACK    : in std_logic;
      USER_TX_D                 : in std_logic_vector(63 downto 0);
      USER_TX_B	                : in std_logic_vector(3 downto 0);
		 	USER_TX_AFULL             : out std_logic;
      USER_RX_SIZE              : in std_logic_vector(15 downto 0);
		 	USER_RX_CLR_ENB	          : out std_logic;
      USER_RX_CLR_REQ           : in std_logic;
      USER_RX_RADR 							: in std_logic_vector(15 downto 0);
      USER_RX_WADR 							: out std_logic_vector(15 downto 0);
      USER_RX_WENB 							: out std_logic_vector(7 downto 0);
      USER_RX_WDAT 							: out std_logic_vector(63 downto 0)
      );
  end component;

  -- GTX transceiver -----------------------------------------------------------------------
  --  constant kMiiPhyad      : std_logic_vector(kWidthPhyAddr-1 downto 0):= "00000";
  --  signal mii_init_mdc, mii_init_mdio : std_logic;

  signal clk_xgmii        : std_logic;
  signal qpll_locked      : std_logic;

  signal xgmii_rxc        : std_logic_vector(kWidthCtrlXGMII-1 downto 0);
  signal xgmii_rxd        : std_logic_vector(kWidthDataXGMII-1 downto 0);
  signal xgmii_txc        : std_logic_vector(kWidthCtrlXGMII-1 downto 0);
  signal xgmii_txd        : std_logic_vector(kWidthDataXGMII-1 downto 0);

  -- DRP --
  signal drp_req          : std_logic;
  signal drp_den, drp_dwe, drp_drdy : std_logic;
  signal drp_addr         : std_logic_vector(15 downto 0);
  signal drp_di           : std_logic_vector(15 downto 0);
  signal drp_drpdo        : std_logic_vector(15 downto 0);

  COMPONENT ten_gig_eth_pcs_pma
    PORT (
      -- Core block --
      refclk_p              : IN STD_LOGIC;
      refclk_n              : IN STD_LOGIC;
      reset                 : IN STD_LOGIC;
      resetdone_out         : OUT STD_LOGIC;
      coreclk_out           : OUT STD_LOGIC;
      rxrecclk_out          : OUT STD_LOGIC;

      -- Tranceiver --
      txp 									: OUT STD_LOGIC;
      txn 									: OUT STD_LOGIC;
      rxp 									: IN STD_LOGIC;
      rxn 									: IN STD_LOGIC;

      -- SFP+ IF --
      signal_detect         : IN STD_LOGIC;
      tx_disable            : OUT STD_LOGIC;
      tx_fault              : IN STD_LOGIC;

      -- XGMII --
      xgmii_txd             : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
      xgmii_txc             : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      xgmii_rxd             : OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
      xgmii_rxc             : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

      -- MDIO --
      mdc                   : IN STD_LOGIC;
      mdio_in               : IN STD_LOGIC;
      mdio_out              : OUT STD_LOGIC;
      mdio_tri              : OUT STD_LOGIC;
      prtad                 : IN STD_LOGIC_VECTOR(4 DOWNTO 0);

      -- DRP IF --
      dclk                  : IN STD_LOGIC;
      drp_req               : OUT STD_LOGIC;
      drp_gnt               : IN STD_LOGIC;

      drp_den_o             : OUT STD_LOGIC;
      drp_dwe_o             : OUT STD_LOGIC;
      drp_daddr_o           : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      drp_di_o              : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      drp_drdy_o            : OUT STD_LOGIC;
      drp_drpdo_o           : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      drp_den_i             : IN STD_LOGIC;
      drp_dwe_i             : IN STD_LOGIC;
      drp_daddr_i           : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      drp_di_i              : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      drp_drdy_i            : IN STD_LOGIC;
      drp_drpdo_i           : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

      -- mics --
      pma_pmd_type          : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      core_status           : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      sim_speedup_control   : IN STD_LOGIC;

      txusrclk_out          : OUT STD_LOGIC;
      txusrclk2_out         : OUT STD_LOGIC;
      areset_datapathclk_out : OUT STD_LOGIC;
      gttxreset_out         : OUT STD_LOGIC;
      gtrxreset_out         : OUT STD_LOGIC;
      txuserrdy_out         : OUT STD_LOGIC;
      reset_counter_done_out : OUT STD_LOGIC;
      qplllock_out          : OUT STD_LOGIC;
      qplloutclk_out        : OUT STD_LOGIC;
      qplloutrefclk_out     : OUT STD_LOGIC
      );
  END COMPONENT;



  -- Clock -------------------------------------------------------------------
  signal c6c_fast, c6c_slow   : std_logic;
  signal clk_fast, clk_slow   : std_logic;
  signal delay_clk_fast       : std_logic;

  signal clk_sys            : std_logic;
  signal clk_spi            : std_logic;
  signal clk_gbe            : std_logic;

  signal clk_locked         : std_logic_vector(1 downto 0);

  component clk_wiz_0
    port
     (-- Clock in ports
      -- Clock out ports
      clk_sys          : out    std_logic;
      clk_spi          : out    std_logic;
      clk_idelayref    : out    std_logic;
      -- Status and control signals
      reset             : in     std_logic;
      locked            : out    std_logic;
      clk_in1_p         : in     std_logic;
      clk_in1_n         : in     std_logic
     );
    end component;


  -- debug -------------------------------------------------------------------

begin
  -- =========================================================================
  -- body
  -- =========================================================================
  -- Global ------------------------------------------------------------------
  async_reset   <= not USR_RSTB;
  c6c_reset     <= (not clk_locked(0)) or async_reset;

  clk_locked(1) <= CDCE_LOCK;

  pwr_on_reset  <= core_master_reset;
  user_reset    <= system_reset or rst_from_bus or rst_from_miku;
  bct_reset     <= system_reset or rst_from_miku;

  force_reset_u <= frst_from_dct(0) or system_reset;
  force_reset_d <= frst_from_dct(1) or system_reset;

  u_SysReset : entity mylib.SystemReset
    generic map(
      kWidthResetSync => 32
    )
    port map(
      -- Seed of the master reset --
      asyncReset    => async_reset,
      mmcmLocked    => and_reduce(clk_locked),
      -- Async reset to 10GbE_PCSPMA --
      masterReset   => core_master_reset,
      qpllLocked    => qpll_locked and and_reduce(idelayctrl_ready),

      -- System reset --
      clkXgmii        => clk_xgmii,
      clkSys          => clk_slow,
      syncXgmiiReset  => system_reset_xgmii,
      syncSysReset    => system_reset
      );

  u_RstFromMiku : entity mylib.SigStretcher
    generic map(kLength => 8)
    port map(clk_slow, laccp_pulse_out(kDownPulseSysRst), rst_from_miku);

  u_sync_nimin  : entity mylib.synchronizer port map(clk_slow, NIM_IN(2), sync_nim_in(2));
  u_trg_in      : entity mylib.EdgeDetector port map(clk_slow, sync_nim_in(2), local_trigger_in);

  u_nimo_buf : process(clk_slow)
  begin
    if(clk_slow'event and clk_slow = '1') then
      NIM_OUT <= tmp_nim_out;
    end if;
  end process;

  tmp_nim_out(1)  <= laccp_pulse_out(kDownPulseTrigger) when(dip_sw(kTriggerOut.Index) = '1') else heartbeat_signal;
  tmp_nim_out(2)  <= tcp_is_active;

  dip_sw <= DIP;

  daq_is_running  <= '1' when(hbf_state = kActiveFrame and tcp_is_active = '1') else '0';
  LED <= and_reduce(clk_locked) & mikumari_link_up(kIdMikuSec) & is_ready_for_daq(kIdMikuSec) & daq_is_running;


  -- Mezzanine connection --------------------------------------------------------------
  MIKUMARI_TXP  <= miku_txp(kIdMikuSec);
  MIKUMARI_TXN  <= miku_txn(kIdMikuSec);
  miku_rxp(kIdMikuSec)  <= MIKUMARI_RXP;
  miku_rxn(kIdMikuSec)  <= MIKUMARI_RXN;

  MZNU_CDCM_TXP   <= miku_txp(kIdMikuMznU);
  MZNU_CDCM_TXN   <= miku_txn(kIdMikuMznU);
  MZND_CDCM_TXP   <= miku_txp(kIdMikuMznD);
  MZND_CDCM_TXN   <= miku_txn(kIdMikuMznD);

  miku_rxp(kIdMikuMznU)  <= MZNU_CDCM_RXP;
  miku_rxn(kIdMikuMznU)  <= MZNU_CDCM_RXN;
  miku_rxp(kIdMikuMznD)  <= MZND_CDCM_RXP;
  miku_rxn(kIdMikuMznD)  <= MZND_CDCM_RXN;

  -- MIKUMARI --------------------------------------------------------------------------
  u_KeepInit : entity mylib.RstDelayTimer
    port map(system_reset, X"0FFFFFFF", clk_slow, open, power_on_init );

  gen_idleayctrl : for i in 0 to idelayctrl_ready'length-1 generate
    attribute IODELAY_GROUP of u_IDELAYCTRL_inst : label is GetIoDelayGroup(i);
  begin
    u_IDELAYCTRL_inst : IDELAYCTRL
      port map (
        RDY     => idelayctrl_ready(i),
        REFCLK  => clk_gbe,
        RST     => pwr_on_reset
      );
  end generate;


  -- Secondary Links ----------------------------------------------------------------
  laccp_reset(kIdMikuSec) <= system_reset or (not mikumari_link_up(kIdMikuSec));

  laccp_pulse_in(kDownPulseTrigger)   <= local_trigger_in or laccp_pulse_out(kDownPulseTrigger);
  laccp_pulse_in(kDownPulseCntRst)    <= laccp_pulse_out(kDownPulseCntRst);
  laccp_pulse_in(kDownPulseSysRst)    <= laccp_pulse_out(kDownPulseSysRst);
  laccp_pulse_in(kDownPulseRSV3)      <= laccp_pulse_out(kDownPulseRSV3);
  laccp_pulse_in(kDownPulseRSV4)      <= laccp_pulse_out(kDownPulseRSV4);
  laccp_pulse_in(kDownPulseRSV5)      <= laccp_pulse_out(kDownPulseRSV5);
  laccp_pulse_in(kDownPulseRSV6)      <= laccp_pulse_out(kDownPulseRSV6);
  laccp_pulse_in(kDownPulseRSV7)      <= laccp_pulse_out(kDownPulseRSV7);

  u_Miku_Inst : entity mylib.MikumariBlock
    generic map(
      -- CBT generic -------------------------------------------------------------
      -- CDCM-Mod-Pattern --
      kCdcmModWidth    => 8,
      -- CDCM-TX --
      kIoStandardTx    => GetTxIoStd(kPcbVersion, kIdMikuSec),
      kTxPolarity      => FALSE,
      -- CDCM-RX --
      genIDELAYCTRL    => FALSE,
      kDiffTerm        => TRUE,
      kIoStandardRx    => GetRxIoStd(kPcbVersion, kIdMikuSec),
      kRxPolarity      => FALSE,
      kIoDelayGroup    => GetIoGroup(kPcbVersion, kIdMikuSec),
      kFixIdelayTap    => FALSE,
      kFreqFastClk     => 500.0,
      kFreqRefClk      => 200.0,
      -- Encoder/Decoder
      kNumEncodeBits   => 1,
      -- Master/Slave
      kCbtMode         => "Slave",
      -- DEBUG --
      enDebugCBT       => FALSE,

      -- MIKUMARI generic --------------------------------------------------------
      enScrambler      => TRUE,
      kHighPrecision   => FALSE,
      -- DEBUG --
      enDebugMikumari  => FALSE
    )
    port map(
      -- System ports -----------------------------------------------------------
      rst           => system_reset or DIP(kStandAlone.Index),
      pwrOnRst      => pwr_on_reset,
      clkSer        => clk_fast,
      clkPar        => clk_slow,
      clkIndep      => clk_gbe,
      clkIdctrl     => clk_gbe,
      initIn        => power_on_init or cbt_init_from_mutil(kIdMikuSec),

      TXP           => miku_txp(kIdMikuSec),
      TXN           => miku_txn(kIdMikuSec),
      RXP           => miku_rxp(kIdMikuSec),
      RXN           => miku_rxn(kIdMikuSec),
      modClk        => mod_clk,
      tapValueIn    => (others => '0'),
      txBeat        => open,

      -- CBT ports ------------------------------------------------------------
      laneUp        => cbt_lane_up(kIdMikuSec),
      idelayErr     => open,
      bitslipErr    => open,
      pattErr       => pattern_error(kIdMikuSec),
      watchDogErr   => watchdog_error(kIdMikuSec),

      tapValueOut   => tap_value_out(kIdMikuSec),
      bitslipNum    => bitslip_num_out(kIdMikuSec),
      serdesOffset  => serdes_offset(kIdMikuSec),
      firstBitPatt  => open,

      -- Mikumari ports -------------------------------------------------------
      linkUp        => mikumari_link_up(kIdMikuSec),

      -- TX port --
      -- Data I/F --
      dataInTx      => miku_data_tx(kIdMikuSec),
      validInTx     => miku_valid_tx(kIdMikuSec),
      frameLastInTx => miku_last_tx(kIdMikuSec),
      txAck         => miku_tx_ack(kIdMikuSec),

      pulseIn       => pulse_tx(kIdMikuSec),
      pulseTypeTx   => pulse_type_tx(kIdMikuSec),
      pulseRegTx    => "0000",
      busyPulseTx   => busy_pulse_tx(kIdMikuSec),

      -- RX port --
      -- Data I/F --
      dataOutRx   => miku_data_rx(kIdMikuSec),
      validOutRx  => miku_valid_rx(kIdMikuSec),
      frameLastRx => miku_last_rx(kIdMikuSec),
      checksumErr => checksum_err(kIdMikuSec),
      frameBroken => frame_broken(kIdMikuSec),
      recvTermnd  => recv_terminated(kIdMikuSec),

      pulseOut    => pulse_rx(kIdMikuSec),
      pulseTypeRx => pulse_type_rx(kIdMikuSec),
      pulseRegRx  => open

    );

--
--idelay_tap_in   <= unsigned(tap_value_out);

u_LACCP : entity mylib.LaccpMainBlock
  generic map
    (
      kPrimaryMode      => false,
      kNumInterconnect  => 2,
      enDebug           => false
    )
  port map
    (
      -- System --------------------------------------------------------
      rst               => laccp_reset(kIdMikuSec),
      clk               => clk_slow,

      -- User Interface ------------------------------------------------
      isReadyForDaq     => is_ready_for_daq(kIdMikuSec),
      laccpPulsesIn     => (others => '0'),
      laccpPulsesOut    => laccp_pulse_out,
      pulseInRejected   => open,

      -- RLIGP --
      addrMyLink        => sitcp_ip_addr(0),
      validMyLink       => not emergency_reset,
      addrPartnerLink   => link_addr_partter(kIdMikuSec),
      validPartnerLink  => valid_link_addr(kIdMikuSec),

      -- RCAP --
      idelayTapIn       => unsigned(tap_value_out(kIdMikuSec)),
      serdesLantencyIn  => serdes_offset(kIdMikuSec),
      idelayTapOut      => open,
      serdesLantencyOut => open,

      hbuIsSyncedIn     => hbu_is_synchronized,
      syncPulseIn       => '0',
      syncPulseOut      => sync_pulse_out,

      upstreamOffset    => (others => '0'),
      validOffset       => valid_hbc_offset,
      hbcOffset         => hbc_offset,
      fineOffset        => laccp_fine_offset,
      fineOffsetLocal   => local_fine_offset,

      -- LACCP Bus Port ------------------------------------------------
      -- Intra-port--
      isReadyIntraIn    => is_ready_laccp_intra,
      dataIntraIn       => data_laccp_intra_in,
      validIntraIn      => valid_laccp_intra_in,
      dataIntraOut      => data_laccp_intra_out,
      validIntraOut     => valid_laccp_intra_out,

      -- Interconnect --
      isReadyInterIn    => (kPosMzn'range => is_ready_inter_down(kPosMzn'range), others => '0'),
      existInterOut     => is_ready_inter_up,
      dataInterIn       => (kPosMzn'range => data_inter_in(kPosMzn'range), others => (others => '0')),
      validInterIn      => (kPosMzn'range => valid_inter_in(kPosMzn'range), others => '0'),
      dataInterOut      => data_inter_out,
      validInterOut     => valid_inter_out,

      -- MIKUMARI-Link -------------------------------------------------
      mikuLinkUpIn      => mikumari_link_up(kIdMikuSec),

      -- TX port --
      dataTx            => miku_data_tx(kIdMikuSec),
      validTx           => miku_valid_tx(kIdMikuSec),
      frameLastTx       => miku_last_tx(kIdMikuSec),
      txAck             => miku_tx_ack(kIdMikuSec),

      pulseTx           => pulse_tx(kIdMikuSec),
      pulseTypeTx       => pulse_type_tx(kIdMikuSec),
      busyPulseTx       => busy_pulse_tx(kIdMikuSec),

      -- RX port --
      dataRx            => miku_data_rx(kIdMikuSec),
      validRx           => miku_valid_rx(kIdMikuSec),
      frameLastRx       => miku_last_rx(kIdMikuSec),
      checkSumErrRx     => checksum_err(kIdMikuSec),
      frameBrokenRx     => frame_broken(kIdMikuSec),
      recvTermndRx      => recv_terminated(kIdMikuSec),

      pulseRx           => pulse_rx(kIdMikuSec),
      pulseTypeRx       => pulse_type_rx(kIdMikuSec)

    );

  -- Primary Links ------------------------------------------------------------------
  miku_fanout_reset   <= power_on_init when(DIP(kStandAlone.Index) = '1') else (not is_ready_for_daq(kIdMikuSec));

  gen_mikumari : for i in kIdMikuMznU to kIdMikuMznD generate
    laccp_reset(i) <= system_reset or (not mikumari_link_up(i));

    u_Miku_Inst : entity mylib.MikumariBlock
      generic map(
        -- CBT generic -------------------------------------------------------------
        -- CDCM-Mod-Pattern --
        kCdcmModWidth    => 8,
        -- CDCM-TX --
        kIoStandardTx    => GetTxIoStd(kPcbVersion, i),
        kTxPolarity      => FALSE,
        -- CDCM-RX --
        genIDELAYCTRL    => FALSE,
        kDiffTerm        => TRUE,
        kIoStandardRx    => GetRxIoStd(kPcbVersion, i),
        kRxPolarity      => FALSE,
        kIoDelayGroup    => GetIoGroup(kPcbVersion, i),
        kFixIdelayTap    => FALSE,
        kFreqFastClk     => 500.0,
        kFreqRefClk      => 200.0,
        -- Encoder/Decoder
        kNumEncodeBits   => 1,
        -- Master/Slave
        kCbtMode         => "Master",
        -- DEBUG --
        enDebugCBT       => false,

        -- MIKUMARI generic --------------------------------------------------------
        enScrambler      => TRUE,
        kHighPrecision   => FALSE,
        -- DEBUG --
        enDebugMikumari  => FALSE
      )
      port map(
        -- System ports -----------------------------------------------------------
        rst           => system_reset,
        pwrOnRst      => pwr_on_reset,
        clkSer        => clk_fast,
        clkPar        => clk_slow,
        clkIndep      => clk_gbe,
        clkIdctrl     => clk_gbe,
        initIn        => miku_fanout_reset or cbt_init_from_mutil(i),

        TXP           => miku_txp(i),
        TXN           => miku_txn(i),
        RXP           => miku_rxp(i),
        RXN           => miku_rxn(i),
        modClk        => open,
        tapValueIn    => (others => '0'),
        txBeat        => open,

        -- CBT ports ------------------------------------------------------------
        laneUp        => cbt_lane_up(i),
        idelayErr     => open,
        bitslipErr    => open,
        pattErr       => pattern_error(i),
        watchDogErr   => watchdog_error(i),

        tapValueOut   => tap_value_out(i),
        bitslipNum    => bitslip_num_out(i),
        serdesOffset  => serdes_offset(i),
        firstBitPatt  => open,

        -- Mikumari ports -------------------------------------------------------
        linkUp        => mikumari_link_up(i),

        -- TX port --
        -- Data I/F --
        dataInTx      => miku_data_tx(i),
        validInTx     => miku_valid_tx(i),
        frameLastInTx => miku_last_tx(i),
        txAck         => miku_tx_ack(i),

        pulseIn       => pulse_tx(i),
        pulseTypeTx   => pulse_type_tx(i),
        pulseRegTx    => "0000",
        busyPulseTx   => busy_pulse_tx(i),

        -- RX port --
        -- Data I/F --
        dataOutRx   => miku_data_rx(i),
        validOutRx  => miku_valid_rx(i),
        frameLastRx => miku_last_rx(i),
        checksumErr => checksum_err(i),
        frameBroken => frame_broken(i),
        recvTermnd  => recv_terminated(i),

        pulseOut    => pulse_rx(i),
        pulseTypeRx => pulse_type_rx(i),
        pulseRegRx  => open

      );


    u_LACCP : entity mylib.LaccpMainBlock
      generic map
        (
          kPrimaryMode      => true,
          kNumInterconnect  => 1,
          kFastClkFreq      => 500.0,
          enDebug           => GetEnDebug(i)
        )
      port map
        (
          -- System --------------------------------------------------------
          rst               => laccp_reset(i) or miku_fanout_reset,
          clk               => clk_slow,

          -- User Interface ------------------------------------------------
          isReadyForDaq     => is_ready_for_daq(i),
          laccpPulsesIn     => laccp_pulse_in,
          laccpPulsesOut    => open,
          pulseInRejected   => pulse_rejected(i),

          -- RLIGP --
          addrMyLink        => sitcp_ip_addr(0),
          validMyLink       => not emergency_reset,
          addrPartnerLink   => link_addr_partter(i),
          validPartnerLink  => valid_link_addr(i),

          -- RCAP --
          idelayTapIn       => unsigned(tap_value_out(i)),
          serdesLantencyIn  => serdes_offset(i),
          idelayTapOut      => open,
          serdesLantencyOut => open,

          hbuIsSyncedIn     => '0',
          syncPulseIn       => heartbeat_signal,
          syncPulseOut      => open,

          upstreamOffset    => laccp_fine_offset,
          validOffset       => open,
          hbcOffset         => open,
          fineOffset        => open,
          fineOffsetLocal   => open,

          -- LACCP Bus Port ------------------------------------------------
          -- Intra-port--
          isReadyIntraIn    => prim_is_ready_laccp_intra,
          dataIntraIn       => prim_data_laccp_intra_in,
          validIntraIn      => prim_valid_laccp_intra_in,
          dataIntraOut      => prim_data_laccp_intra_out,
          validIntraOut     => prim_valid_laccp_intra_out,

          -- Interconnect --
          isReadyInterIn    => (0 => is_ready_inter_up(i), others => '0'),
          existInterOut(0)  => is_ready_inter_down(i),
          existInterOut(kMaxNumInterconnect-1 downto 1)  => open,
          dataInterIn       => (0 => data_inter_out(i), others => (others => '0')),
          validInterIn      => (0 => valid_inter_out(i), others => '0'),
          dataInterOut(0)   => data_inter_in(i),
          dataInterOut(kMaxNumInterconnect-1 downto 1)   => open,
          validInterOut(0)  => valid_inter_in(i),
          validInterOut(kMaxNumInterconnect-1 downto 1)  => open,

          -- MIKUMARI-Link -------------------------------------------------
          mikuLinkUpIn      => mikumari_link_up(i),

          -- TX port --
          dataTx            => miku_data_tx(i),
          validTx           => miku_valid_tx(i),
          frameLastTx       => miku_last_tx(i),
          txAck             => miku_tx_ack(i),

          pulseTx           => pulse_tx(i),
          pulseTypeTx       => pulse_type_tx(i),
          busyPulseTx       => busy_pulse_tx(i),

          -- RX port --
          dataRx            => miku_data_rx(i),
          validRx           => miku_valid_rx(i),
          frameLastRx       => miku_last_rx(i),
          checkSumErrRx     => checksum_err(i),
          frameBrokenRx     => frame_broken(i),
          recvTermndRx      => recv_terminated(i),

          pulseRx           => pulse_rx(i),
          pulseTypeRx       => pulse_type_rx(i)

        );
  end generate;

  -- HeartBeat Unit ----------------------------------------------------------------------------
  heartbeat_signal  <= heartbeat_signal_prim  when(DIP(kStandAlone.Index) = '1') else heartbeat_signal_secnd;
  heartbeat_count   <= heartbeat_count_prim  when(DIP(kStandAlone.Index) = '1') else heartbeat_count_secnd;
  hbf_number        <= hbf_number_prim  when(DIP(kStandAlone.Index) = '1') else hbf_number_secnd;
  hbf_state         <= hbf_state_prim when(DIP(kStandAlone.Index) = '1') else hbf_state_secnd;

  frame_ctrl_gate <= '0';
  hbu_reset       <= '1' when(dip_sw(kStandAlone.Index) = '1') else laccp_reset(kIdMikuSec);

  u_HBU : entity mylib.HeartBeatUnit
    generic map
      (
        enDebug           => false
      )
    port map
      (
        -- System --
        rst               => hbu_reset,
        clk               => clk_slow,
        enStandAlone      => DIP(kStandAlone.Index),
        keepLocalHbfNum   => '1',

        -- Sync I/F --
        syncPulseIn       => sync_pulse_out,
        hbcOffsetIn       => hbc_offset,
        validOffsetIn     => valid_hbc_offset,
        isSynchronized    => hbu_is_synchronized,

        -- HeartBeat I/F --
        heartbeatOut      => heartbeat_signal_secnd,
        heartbeatCount    => heartbeat_count_secnd,
        hbfNumber         => hbf_number_secnd,
        hbfNumMismatch    => hbf_num_mismatch,

        -- DAQ I/F --
        hbfCtrlGateIn     => frame_ctrl_gate,
        forceOn           => '1',
        frameState        => hbf_state_secnd,

        -- LACCP Bus --
        dataBusIn         => data_laccp_intra_out(GetExtIntraIndex(kPortHBU)),
        validBusIn        => valid_laccp_intra_out(GetExtIntraIndex(kPortHBU)),
        dataBusOut        => data_laccp_intra_in(GetExtIntraIndex(kPortHBU)),
        validBusOut       => valid_laccp_intra_in(GetExtIntraIndex(kPortHBU)),
        isReadyOut        => is_ready_laccp_intra(GetExtIntraIndex(kPortHBU))

      );

  --
  -- Primary-HeartBeat Unit --
  hbu_prim_reset  <= '1' when(dip_sw(kStandAlone.Index) = '0') else system_reset;

  u_HBU_Prim : entity mylib.PrimaryHeartBeatUnit
    generic map
      (
        enDebug           => false
      )
    port map
      (
        -- System --
        rst               => hbu_prim_reset,
        primaryRst        => '0',
        clk               => clk_slow,

        -- Sync I/F --

        -- HeartBeat I/F --
        heartbeatOut      => heartbeat_signal_prim,
        heartbeatCount    => heartbeat_count_prim,
        hbfNumber         => hbf_number_prim,

        -- DAQ I/F --
        hbfCtrlGateIn     => '0',
        forceOn           => '1',
        frameState        => hbf_state_prim,

        -- LACCP Bus --
        dataBusIn         => prim_data_laccp_intra_out(GetExtIntraIndex(kPortHBU)),
        validBusIn        => prim_valid_laccp_intra_out(GetExtIntraIndex(kPortHBU)),
        dataBusOut        => prim_data_laccp_intra_in(GetExtIntraIndex(kPortHBU)),
        validBusOut       => prim_valid_laccp_intra_in(GetExtIntraIndex(kPortHBU)),
        isReadyOut        => prim_is_ready_laccp_intra(GetExtIntraIndex(kPortHBU))
      );

  -- MIKUMARI utility ---------------------------------------------------------------------
  u_MUTIL : entity mylib.MikumariUtil
    generic map(
      kNumMikumari => kNumMikumari
    )
    port map(
      -- System ----------------------------------------------------
      rst               => user_reset,
      clk               => clk_slow,

      -- CBT status ports --
      cbtLaneUp           => cbt_lane_up,
      tapValueIn          => tap_value_out,
      bitslipNumIn        => bitslip_num_out,
      cbtInitOut          => cbt_init_from_mutil,
      tapValueOut         => open,
      rstOverMikuOut      => open,

      -- MIKUMARI Link ports --
      mikuLinkUp          => mikumari_link_up,

      -- LACCP ports --
      laccpUp             => is_ready_for_daq,
      partnerIpAddr       => link_addr_partter,
      hbcOffset           => hbc_offset,
      localFineOffset     => std_logic_vector(local_fine_offset),
      laccpFineOffset     => std_logic_vector(laccp_fine_offset),
      hbfState            => open,

      -- Local bus --
      addrLocalBus        => addr_LocalBus,
      dataLocalBusIn      => data_LocalBusIn,
      dataLocalBusOut     => data_LocalBusOut(kMUTIL.ID),
      reLocalBus          => re_LocalBus(kMUTIL.ID),
      weLocalBus          => we_LocalBus(kMUTIL.ID),
      readyLocalBus       => ready_LocalBus(kMUTIL.ID)
    );


  -- Scaler -------------------------------------------------------------------------------
  scr_en_in(kMsbScr - kIndexRealTime)       <= heartbeat_signal;
  scr_en_in(kMsbScr - kIndexDaqRunTime)     <= '0';
  scr_en_in(kMsbScr - kIndexTotalThrotTime) <= '0';
  scr_en_in(kMsbScr - kIndexInThrot1Time)   <= '0';
  scr_en_in(kMsbScr - kIndexInThrot2Time)   <= '0';
  scr_en_in(kMsbScr - kIndexOutThrotTime)   <= '0';
  scr_en_in(kMsbScr - kIndexHbfThrotTime)   <= '0';
  scr_en_in(kMsbScr - kIndexMikuError)      <= (pattern_error(kIdMikuSec) or checksum_err(kIdMikuSec) or frame_broken(kIdMikuSec) or recv_terminated(kIdMikuSec)) and is_ready_for_daq(kIdMikuSec);

  scr_en_in(kNumInput+1)                    <= laccp_pulse_in(kDownPulseTrigger);
  scr_en_in(kNumInput)                      <= or_reduce(pulse_rejected);
  scr_en_in(kNumInput-1 downto 0)           <= (others => '0');

  u_SCR: entity mylib.FreeRunScaler
    generic map(
      kNumHitInput        => kNumInput+kNumExtraScr
    )
    port map(
      rst	                => system_reset,
      cntRst              => laccp_pulse_in(kDownPulseCntRst),
      clk	                => clk_slow,
      scrRstOut           => open,

      -- Module Input --
      hbCount             => (heartbeat_count'range => heartbeat_count, others => '0'),
      hbfNum              => (hbf_number'range => hbf_number, others => '0'),
      scrEnIn             => scr_en_in,

      -- Local bus --
      addrLocalBus        => addr_LocalBus,
      dataLocalBusIn      => data_LocalBusIn,
      dataLocalBusOut     => data_LocalBusOut(kSCR.ID),
      reLocalBus          => re_LocalBus(kSCR.ID),
      weLocalBus          => we_LocalBus(kSCR.ID),
      readyLocalBus       => ready_LocalBus(kSCR.ID)
      );

  -- Main input ports --------------------------------------------------------
  -- MZN-U ---------------------------------------------------------------
  -- MIF --
  u_MIFU_Inst : entity mylib.MznInterfaceP
    generic map
    (
      invStatusMzn    => "0",
      invStatusBase   => "00000",
      invFrst         => '1',
      invClk          => "01",
      invSlotPos      => '0',
      kExIoStd        => "LVDS_25"
    )
    port map
    (
      -- Toplevel MZN ports ----------------------------------------------------
      -- System --
      FRST_P            => MZNU_FRST_P,
      FRST_N            => MZNU_FRST_N,

      CLKHUL_P          => MZNU_CLKHUL_P,
      CLKHUL_N          => MZNU_CLKHUL_N,

      SLOT_POS_P        => MZNU_SLOT_POS_P,
      SLOT_POS_N        => MZNU_SLOT_POS_N,

      -- Bct Bus Bridge --
      BBP_PRI_ACTIVE_P  => MZNU_PRI_ACTIVE_P,
      BBP_PRI_ACTIVE_N  => MZNU_PRI_ACTIVE_N,
      BBP_SCN_REQ_P     => MZNU_SCN_REQ_P,
      BBP_SCN_REQ_N     => MZNU_SCN_REQ_N,
      BBP_CLK_P         => MZNU_CLK_P,
      BBP_CLK_N         => MZNU_CLK_N,
      BBP_PISO_P        => MZNU_PISO_P,
      BBP_PISO_N        => MZNU_PISO_N,
      BBP_POSI_P        => MZNU_POSI_P,
      BBP_POSI_N        => MZNU_POSI_N,


      -- DAQ functions --
--      TRIGGER_P         => MZNU_TRIGGER_P,
--      TRIGGER_N         => MZNU_TRIGGER_N,
--      BUSY_P            => MZNU_BUSY_P,
--      BUSY_N            => MZNU_BUSY_N,

      -- Status ports --
      STATUS_IN_P       => MZNU_STATUS_IN_P,
      STATUS_IN_N       => MZNU_STATUS_IN_N,
      STATUS_OUT_P      => MZNU_STATUS_OUT_P,
      STATUS_OUT_N      => MZNU_STATUS_OUT_N,

      -- FW internal signals ---------------------------------------------------
      -- MIF ports --
      rstForce          => force_reset_u,
      clkHul            => clk_slow,
      slotPosition      => '0',
      enClkOut          => (not power_on_init),

      -- Bct Bus Bridge --
      bbpPrimActive     => bbpu_prim_active,
      bbpScndReq        => bbpu_scnd_req,
      bbpClk            => bbpu_clk_bridge,
      bbpPiso           => bbpu_piso,
      bbpPosi           => bbpu_posi,

      -- Status ports --
      statusMzn    => status_in_mznu,
      statusBase   => status_out_mznu
      );

  u_DDRRecvU_Inst : entity mylib.DDRReceiverV2
    generic map(
      kInvertMask        => kInvmaskDDRu,
      genIDELAYCTRL      => false,
      kDiffTerm          => true,
      kIoStandard        => "LVDS_25",
      kIoDelayGroup      => "idelay_14",
      kFreqFastClk       => 500.0,
      kFreqRefClk        => 200.0,
      enDEBUG            => false
      )
    port map
    (
      -- system port --
      rst           => user_reset,
      rstBuf        => (not tcp_is_active),
      clk           => clk_slow,
      clkIdelayRef  => clk_gbe,
      idCtrlReady   => and_reduce(idelayctrl_ready),

      regDctIn      => reg_dct2rcv(0),
      regDctOut     => reg_rcv2dct(0),

      -- DDR ports --
      clkDDRp       => MZNU_CLKDDR_P,
      clkDDRn       => MZNU_CLKDDR_N,

      dinDDRDp      => MZNU_DDRD_P,
      dinDDRDn      => MZNU_DDRD_N,

      -- User Data --
      rvDdrRx   => ddrrx_valid_out(0),
      doutDdrRx => ddrrx_data_out(0)
      );

  -- BBP-U --
  u_BBPU_Inst : entity mylib.BctBridgePrimary
    generic map(
      invClk              => '0',
      enDebug             => false
    )
    port map(
      rst	                => user_reset,
      clk	                => clk_slow,

      -- Bus Bridge I/F --
      primIsActive        => bbpu_prim_active,
      scndReq             => bbpu_scnd_req,
      clkBridge           => bbpu_clk_bridge,
      piso                => bbpu_piso,
      posi                => bbpu_posi,

      -- Local bus --
      addrLocalBus        => addr_LocalBus,
      dataLocalBusIn      => data_LocalBusIn,
      dataLocalBusOut     => data_LocalBusOut(kBBPU.ID),
      reLocalBus          => re_LocalBus(kBBPU.ID),
      weLocalBus          => we_LocalBus(kBBPU.ID),
      readyLocalBus       => ready_LocalBus(kBBPU.ID)
      );

  -- MZN-D ---------------------------------------------------------------
  -- MIF --
  u_MIFD_Inst : entity mylib.MznInterfaceP
    generic map
    (
      invStatusMzn  => "0",
      invStatusBase => "10000",
      invFrst       => '0',
      invClk        => "10",
      invSlotPos    => '0',
      kExIoStd      => "LVDS"
    )
    port map
    (
      -- Toplevel MZN ports ----------------------------------------------------
      -- System --
      FRST_P            => MZND_FRST_P,
      FRST_N            => MZND_FRST_N,

      CLKHUL_P          => MZND_CLKHUL_P,
      CLKHUL_N          => MZND_CLKHUL_N,

      SLOT_POS_P        => MZND_SLOT_POS_P,
      SLOT_POS_N        => MZND_SLOT_POS_N,

      -- Bct Bus Bridge --
      BBP_PRI_ACTIVE_P  => MZND_PRI_ACTIVE_P,
      BBP_PRI_ACTIVE_N  => MZND_PRI_ACTIVE_N,
      BBP_SCN_REQ_P     => MZND_SCN_REQ_P,
      BBP_SCN_REQ_N     => MZND_SCN_REQ_N,
      BBP_CLK_P         => MZND_CLK_P,
      BBP_CLK_N         => MZND_CLK_N,
      BBP_PISO_P        => MZND_PISO_P,
      BBP_PISO_N        => MZND_PISO_N,
      BBP_POSI_P        => MZND_POSI_P,
      BBP_POSI_N        => MZND_POSI_N,


      -- Status ports --
      STATUS_IN_P       => MZND_STATUS_IN_P,
      STATUS_IN_N       => MZND_STATUS_IN_N,
      STATUS_OUT_P      => MZND_STATUS_OUT_P,
      STATUS_OUT_N      => MZND_STATUS_OUT_N,

      -- FW internal signals ---------------------------------------------------
      -- MIF ports --
      rstForce          => force_reset_d,
      clkHul            => clk_slow,
      slotPosition      => '1',
      enClkOut          => (not power_on_init),

      -- Bct Bus Bridge --
      bbpPrimActive     => bbpd_prim_active,
      bbpScndReq        => bbpd_scnd_req,
      bbpClk            => bbpd_clk_bridge,
      bbpPiso           => bbpd_piso,
      bbpPosi           => bbpd_posi,

      -- Status ports --
      statusMzn    => status_in_mznd,
      statusBase   => status_out_mznd

    );

  u_DDRRecvD_Inst : entity mylib.DDRReceiverV2
    generic map(
      kInvertMask        => kInvmaskDDRd,
      genIDELAYCTRL      => false,
      kDiffTerm          => true,
      kIoStandard        => "LVDS",
      kIoDelayGroup      => "idelay_12",
      kFreqFastClk       => 500.0,
      kFreqRefClk        => 200.0,
      enDEBUG            => false
      )
    port map
    (
      -- system port --
      rst       => user_reset,
      rstBuf    => (not tcp_is_active),
      clk       => clk_slow,
      clkIdelayRef  => clk_gbe,
      idCtrlReady   => and_reduce(idelayctrl_ready),

      regDctIn  => reg_dct2rcv(1),
      regDctOut => reg_rcv2dct(1),

      -- DDR ports --
      clkDDRp   => MZND_CLKDDR_P,
      clkDDRn   => MZND_CLKDDR_N,

      dinDDRDp  => MZND_DDRD_P,
      dinDDRDn  => MZND_DDRD_N,

      -- User Data --
      rvDdrRx   => ddrrx_valid_out(1),
      doutDdrRx => ddrrx_data_out(1)
      );

  -- BBP-D --
  u_BBPD_Inst : entity mylib.BctBridgePrimary
    generic map(
      invClk              => '0',
      enDebug             => false
    )
    port map(
      rst	                => user_reset,
      clk	                => clk_slow,

      -- Bus Bridge I/F --
      primIsActive        => bbpd_prim_active,
      scndReq             => bbpd_scnd_req,
      clkBridge           => bbpd_clk_bridge,
      piso                => bbpd_piso,
      posi                => bbpd_posi,

      -- Local bus --
      addrLocalBus        => addr_LocalBus,
      dataLocalBusIn      => data_LocalBusIn,
      dataLocalBusOut     => data_LocalBusOut(kBBPD.ID),
      reLocalBus          => re_LocalBus(kBBPD.ID),
      weLocalBus          => we_LocalBus(kBBPD.ID),
      readyLocalBus       => ready_LocalBus(kBBPD.ID)
      );


  -- BackMerger -------------------------------------------------------
  re_mgr  <= '1' when(empty_mgr = '0' and pfull_link_buf = '0') else '0';

  --input_throttling_type2_on   <= status_in_mznu(kIdMznInThrottlingT2) or status_in_mznd(kIdMznInThrottlingT2);

  status_out_mznu(kIdBaseProgFullBMgr)      <= pfull_back_merger or ddrrx_pfull(0);
  status_out_mznd(kIdBaseProgFullBMgr)      <= pfull_back_merger or ddrrx_pfull(1);
  status_out_mznu(kIdBaseHbfNumMismatch)    <= hbfnum_mismatch;
  status_out_mznd(kIdBaseHbfNumMismatch)    <= hbfnum_mismatch;
  status_out_mznu(kIdBaseTcpActive)         <= tcp_is_active;
  status_out_mznd(kIdBaseTcpActive)         <= tcp_is_active;
  status_out_mznu(kIdBaseEmptyLinkBuf)      <= '0';
  status_out_mznd(kIdBaseEmptyLinkBuf)      <= '0';
  status_out_mznu(kIdBaseOutThrottling)     <= '0';
  status_out_mznd(kIdBaseOutThrottling)     <= '0';

  u_DSPT : entity mylib.DataSplitter
    generic map(
      kDivisionRatio  => kNumMRGFront
    )
    port map(
      rst             => user_reset,
      clk             => clk_slow,
      mznDIsAbsence   => dip_sw(kMznDAbs.index),
      pfullFifo       => ddrrx_pfull,

      -- Ports to BackMerger --
      rdEnIn          => ddrrx_re_fifo,
      dataOut         => ddrrx_dout_fifo,
      emptyOut        => ddrrx_empty_fifo,
      aemptyOut       => ddrrx_aempty_fifo,
      validOut        => ddrrx_rv_fifo,

      -- Ports to DDRReceiver --
      validIn         => ddrrx_valid_out,
      dataIn          => ddrrx_data_out
      );


  u_VBB : entity mylib.VitalBlockBase
    generic map(
      kDivisionRatio      => kNumMRGFront,
      enDEBUG             => false
    )
    port map(
      rst                 => user_reset,
      clk                 => clk_slow,

      -- status input --
      linkActive          => tcp_is_active,
      --intputThrottlingOn  => input_throttling_type2_on,
      --pfullLinkIn         => pfull_link_buf,
      --emptyLinkIn         => empty_to_tsd,

      -- status output --
      progFullFifo        => pfull_back_merger,
      lhbfNumMismatch     => hbfnum_mismatch,
      outThrottlingOn     => output_throttling_on,

      -- Data input from Mezzanine --
      rdEnOut             => ddrrx_re_fifo,
      dataIn              => ddrrx_dout_fifo,
      emptyIn             => ddrrx_empty_fifo,
      almostEmptyIn       => ddrrx_aempty_fifo,
      validIn             => ddrrx_rv_fifo,

      -- Data output --
      rdEnIn              => re_mgr,
      dataOut             => dout_mgr,
      emptyOut            => empty_mgr,
      almostEmptyOut      => open,
      validOut            => valid_mgr
    );


  din_link_buf  <= dout_mgr(7 downto 0) & dout_mgr(15 downto 8) & dout_mgr(23 downto 16) & dout_mgr(31 downto 24) & dout_mgr(39 downto 32) & dout_mgr(47 downto 40) & dout_mgr(55 downto 48) & dout_mgr(63 downto 56);

  u_link_buf : LinkBuffer
    PORT map(
      rst     => user_reset,
      wr_clk  => clk_slow,
      rd_clk  => clk_xgmii,
      din     => din_link_buf,
      wr_en   => valid_mgr,
      rd_en   => re_from_tsd,
      dout    => wd_to_tsd,
      full    => open,
      empty   => empty_to_tsd,
      valid   => we_to_tsd,
      prog_full => pfull_link_buf,
      wr_rst_busy => open,
      rd_rst_busy => open
    );

  -- TSD --------------------------------------------------------------------------------
  u_TSD_Inst : entity mylib.TCPsenderXG
    port map(
      rst 					=> user_reset,
      clk 					=> clk_xgmii,

      -- data from EVB --
      rdFromEVB		  => wd_to_tsd,
      rvFromEVB		  => we_to_tsd,
      emptyFromEVB  => empty_to_tsd,
      reToEVB		    => re_from_tsd,

      -- data to SiTCP
      isActive		  => tcp_is_active,
      afullTx		    => tcp_tx_afull,
      tcpTxB	      => tcp_txb,
      tcpTxD	      => tcp_txd
      );

  -- DCT -------------------------------------------------------------------------------
  u_DCT_Inst :  entity mylib.DAQController
    port map(
      rst                 => user_reset,
      clk                 => clk_slow,

      -- Module input --
      regRcvIn            => reg_rcv2dct,

      -- Module output --
      regRcvOut           => reg_dct2rcv,
      forceReset          => frst_from_dct,

      -- Local bus --
      addrLocalBus        => addr_LocalBus,
      dataLocalBusIn      => data_LocalBusIn,
      dataLocalBusOut     => data_LocalBusOut(kDCT.ID),
      reLocalBus          => re_LocalBus(kDCT.ID),
      weLocalBus          => we_LocalBus(kDCT.ID),
      readyLocalBus       => ready_LocalBus(kDCT.ID)
      );

  -- C6C -------------------------------------------------------------------------------
  u_C6C_Inst : entity mylib.CDCE62002Controller
    generic map(
      kSysClkFreq         => 125_000_000
      )
    port map(
      rst	                => system_reset,
      clk	                => clk_slow,
      refClkIn            => c6c_refclk,

      chipReset           => c6c_reset,
      clkIndep            => clk_xgmii,
      chipLock            => CDCE_LOCK,

      -- Module output --
      PDB                 => CDCE_PDB,
      REF_CLKP            => CDCE_REFP,
      REF_CLKN            => CDCE_REFN,
      CSB_SPI             => CDCE_LE,
      SCLK_SPI            => CDCE_SCLK,
      MOSI_SPI            => CDCE_SI,
      MISO_SPI            => CDCE_SO,

      -- Local bus --
      addrLocalBus	      => addr_LocalBus,
      dataLocalBusIn	    => data_LocalBusIn,
      dataLocalBusOut	    => data_LocalBusOut(kC6C.ID),
      reLocalBus		      => re_LocalBus(kC6C.ID),
      weLocalBus		      => we_LocalBus(kC6C.ID),
      readyLocalBus	      => ready_LocalBus(kC6C.ID)
  );

  -- SDS --------------------------------------------------------------------
  u_SDS_Inst : entity mylib.SelfDiagnosisSystem
    port map(
      rst               => user_reset,
      clk               => clk_slow,
      clkIcap           => clk_spi,

      -- Module input  --
      VP                => VP,
      VN                => VN,

      -- Module output --
      shutdownOverTemp  => shutdown_over_temp,
      uncorrectableAlarm => uncorrectable_flag,

      -- Local bus --
      addrLocalBus      => addr_LocalBus,
      dataLocalBusIn    => data_LocalBusIn,
      dataLocalBusOut   => data_LocalBusOut(kSDS.ID),
      reLocalBus        => re_LocalBus(kSDS.ID),
      weLocalBus        => we_LocalBus(kSDS.ID),
      readyLocalBus     => ready_LocalBus(kSDS.ID)
      );


  -- FMP --------------------------------------------------------------------
  u_FMP_Inst : entity mylib.FlashMemoryProgrammer
    port map(
      rst	              => user_reset,
      clk	              => clk_slow,
      clkSpi            => clk_spi,

      -- Module output --
      CS_SPI            => FCSB,
--      SCLK_SPI          => USR_CLK,
      MOSI_SPI          => MOSI,
      MISO_SPI          => DIN,

      -- Local bus --
      addrLocalBus      => addr_LocalBus,
      dataLocalBusIn    => data_LocalBusIn,
      dataLocalBusOut   => data_LocalBusOut(kFMP.ID),
      reLocalBus        => re_LocalBus(kFMP.ID),
      weLocalBus        => we_LocalBus(kFMP.ID),
      readyLocalBus     => ready_LocalBus(kFMP.ID)
      );


  -- BCT --------------------------------------------------------------------
  u_BCT_Inst : entity mylib.BusController
    port map(
      rstSys                    => bct_reset,
      rstFromBus                => rst_from_bus,
      reConfig                  => PROGB_ON,
      clk                       => clk_slow,
      -- Local Bus --
      addrLocalBus              => addr_LocalBus,
      dataFromUserModules       => data_LocalBusOut,
      dataToUserModules         => data_LocalBusIn,
      reLocalBus                => re_LocalBus,
      weLocalBus                => we_LocalBus,
      readyLocalBus             => ready_LocalBus,
      -- RBCP --
      addrRBCP                  => rbcp_addr,
      wdRBCP                    => rbcp_wd,
      weRBCP                    => rbcp_we,
      reRBCP                    => rbcp_re,
      ackRBCP                   => rbcp_ack,
      rdRBCP                    => rbcp_rd
      );




  -- SiTCP Inst -------------------------------------------------------------
  u_SyncRstMiku : entity mylib.synchronizer port map(clk_xgmii, rst_from_miku, rst_from_miku_xgmii);

  u_SiTCPXG_Inst : WRAP_SiTCPXG_XC7K_128K
    generic map(
      RxBufferSize	=> "LongLong"
      )
    port map(
      REG_FPGA_VER              => kCurrentVersion,
      REG_FPGA_ID               => X"00000000",

      --		==== System I/F ====
      FORCE_DEFAULTn            => dip_sw(kSiTCP.Index),
      XGMII_CLOCK               => clk_xgmii,
      RSTs                      => system_reset_xgmii or rst_from_miku_xgmii,

      --		==== XGMII I/F ====
      XGMII_RXC 								=> xgmii_rxc,
      XGMII_RXD 								=> xgmii_rxd,
      XGMII_TXC									=> xgmii_txc,
			XGMII_TXD									=> xgmii_txd,

      --		==== 93C46 I/F ====
			EEPROM_CS									=> EEP_CS(1),
			EEPROM_SK									=> EEP_SK(1),
			EEPROM_DI									=> EEP_DI(1),
      EEPROM_DO									=> EEP_DO(1),

      --		==== User I/F ====
      SiTCP_RESET_OUT	          => emergency_reset,
      IP_ADDR                   => sitcp_ip_addr(0),
      --		--- RBCP ---
			RBCP_ACT                  => open,
			RBCP_ADDR                 => rbcp_xg_addr,
			RBCP_WE										=> rbcp_xg_we,
			RBCP_WD										=> rbcp_xg_wd,
			RBCP_RE										=> rbcp_xg_re,
      RBCP_ACK                  => rbcp_xg_ack,
			RBCP_RD	                  => rbcp_xg_rd,
      -- --- TCP ---
      USER_SESSION_OPEN_REQ	    => '0',
		 	USER_SESSION_ESTABLISHED  => tcp_is_active,
		 	USER_SESSION_CLOSE_REQ    => close_req,
      USER_SESSION_CLOSE_ACK    => close_ack,
      USER_TX_D                 => tcp_txd,
      USER_TX_B	                => tcp_txb,
		 	USER_TX_AFULL             => tcp_tx_afull,
      USER_RX_SIZE              => X"FFF0",
		 	USER_RX_CLR_ENB	          => tcp_rx_clr_enb,
      USER_RX_CLR_REQ           => tcp_rx_clr_enb,
      USER_RX_RADR 							=> tcp_rx_wadr,
      USER_RX_WADR 							=> tcp_rx_wadr,
      USER_RX_WENB 							=> open,
      USER_RX_WDAT 							=> open
	);

  u_RbcpCdc : entity mylib.RbcpCdc
    port map(
      -- System clock domain --
      rstSys      => system_reset,
      clkSys      => clk_slow,
      rbcpAddr    => rbcp_addr,
      rbcpWd      => rbcp_wd,
      rbcpWe      => rbcp_we,
      rbcpRe      => rbcp_re,
      rbcpAck     => rbcp_ack,
      rbcpRd      => rbcp_rd,

      -- XGMII clock domain --
      rstXgmii    => system_reset_xgmii,
      clkXgmii    => clk_xgmii,
      rbcpXgAddr  => rbcp_xg_addr,
      rbcpXgWd    => rbcp_xg_wd,
      rbcpXgWe    => rbcp_xg_we,
      rbcpXgRe    => rbcp_xg_re,
      rbcpXgAck   => rbcp_xg_ack,
      rbcpXgRd    => rbcp_xg_rd
      );

  u_gTCP_inst : entity mylib.global_sitcp_manager
    port map(
      RST           => system_reset_xgmii,
      CLK           => clk_xgmii,
      ACTIVE        => tcp_is_active,
      REQ           => close_req,
      ACT           => close_ack,
      rstFromTCP    => open
      );


  -- GTX transceiver -------------------------------------------------------------------
  u_PCSPMA_Inst : ten_gig_eth_pcs_pma
    port map(
      -- Core block --
      refclk_p              => GTX_REFCLK_P,
      refclk_n              => GTX_REFCLK_N,
      reset                 => core_master_reset,
      resetdone_out         => open,
      coreclk_out           => clk_xgmii,

      -- Tranceiver --
      txp 									=> GTX_TX_P(1),
      txn 									=> GTX_TX_N(1),
      rxp 									=> GTX_RX_P(1),
      rxn 									=> GTX_RX_N(1),

      -- SFP+ IF --
      signal_detect         => '1',
      tx_disable            => open,
      tx_fault              => '0',

      -- XGMII --
      xgmii_txd             => xgmii_txd,
      xgmii_txc             => xgmii_txc,
      xgmii_rxd             => xgmii_rxd,
      xgmii_rxc             => xgmii_rxc,

      -- MDIO --
      mdc                   => '1',
      mdio_in               => '1',
      mdio_out              => open,
      mdio_tri              => open,
      prtad                 => "00000",

      -- DRP IF --
      dclk                  => clk_xgmii,
      drp_req               => drp_req,
      drp_gnt               => drp_req,

      drp_den_o             => drp_den,
      drp_dwe_o             => drp_dwe,
      drp_daddr_o           => drp_addr,
      drp_di_o              => drp_di,
      drp_drdy_o            => drp_drdy,
      drp_drpdo_o           => drp_drpdo,
      drp_den_i             => drp_den,
      drp_dwe_i             => drp_dwe,
      drp_daddr_i           => drp_addr,
      drp_di_i              => drp_di,
      drp_drdy_i            => drp_drdy,
      drp_drpdo_i           => drp_drpdo,

      -- mics --
      pma_pmd_type          => "111",
      core_status           => open,
      sim_speedup_control   => '0',

      txusrclk_out          => open,
      txusrclk2_out         => open,
      rxrecclk_out          => open,
      areset_datapathclk_out => open,
      gttxreset_out         => open,
      gtrxreset_out         => open,
      txuserrdy_out         => open,
      reset_counter_done_out => open,
      qplllock_out          => qpll_locked,
      qplloutclk_out        => open,
      qplloutrefclk_out     => open
      );


  -- Clock inst ------------------------------------------------------
  u_ClkSys_Inst   : clk_wiz_0
    port map
     (-- Clock in ports
      -- Clock out ports
      clk_sys           => clk_sys,
      clk_spi           => clk_spi,
      clk_idelayref     => clk_gbe,
      -- Status and control signals
      reset             => '0',
      locked            => clk_locked(0),
      clk_in1_p         => BASE_CLKP,
      clk_in1_n         => BASE_CLKN
     );


  c6c_refclk  <= clk_sys when(DIP(kStandAlone.Index) = '1') else mod_clk;

  -- CDCE62002 --
  -- Reference clock routing --
--  u_c6c_refclk_inst : BUFGMUX_CTRL
--    port map (
--       O  => c6c_refclk,
--       I0 => clk_mod,
--       I1 => clk_slow_mmcm,
--       S  => dip_sw(kStandAlone.Index)
--    );
--
  -- clk_slow and clk_fast --

    --
  idelay_reset  <= (not idelayctrl_ready(idelayctrl_ready'high)) or power_on_init;
  u_FastDelay : IDELAYE2
    generic map
    (
      CINVCTRL_SEL           => "FALSE",     -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC              => "IDATAIN",   -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE  => "TRUE",      -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE            => "FIXED",     -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE           => 11,           -- Input delay tap setting (0-31)
      PIPE_SEL               => "FALSE",     -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY       => 200.0, -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN         => "CLOCK"       -- DATA, CLOCK input signal
    )
    port map
    (
      CNTVALUEOUT  => open,                  -- 5-bit output: Counter value output
      DATAOUT      => delay_clk_fast,  -- 1-bit output: Delayed data output
      C            => clk_sys,                 -- 1-bit input: Clock input
      CE           => '0',                -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL     => '0',                     -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN   => "00111",                   -- 5-bit input: Counter value input
      DATAIN       => '0',                     -- 1-bit input: Internal delay data input
      IDATAIN      => c6c_fast,        -- 1-bit input: Data input from the I/O
      INC          => '0',               -- 1-bit input: Increment / Decrement tap delay input
      LD           => '0',               -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN     => '0',                     -- 1-bit input: Enable PIPELINE register to load data input
      REGRST       => idelay_reset                  -- 1-bit input: Active-high reset tap-delay input
    );

  u_BUFG_Fast_inst : BUFG
  port map (
     O => clk_fast, -- 1-bit output: Clock output
     --I => c6c_fast  -- 1-bit input: Clock input
     I => delay_clk_fast  -- 1-bit input: Clock input
  );

  u_BUFG_Slow_inst : BUFG
  port map (
     O => clk_slow, -- 1-bit output: Clock output
     --I => delay_clk_fast  -- 1-bit input: Clock input
     I => c6c_slow  -- 1-bit input: Clock input
  );


  u_IBUFDS_SLOW_inst : IBUFDS
  generic map (
     DIFF_TERM => FALSE, -- Differential Termination
     IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
     IOSTANDARD => "LVDS")
  port map (
     O => c6c_slow,  -- Buffer output
     I => CLK_SLOWP,  -- Diff_p buffer input (connect directly to top-level port)
     IB => CLK_SLOWN -- Diff_n buffer input (connect directly to top-level port)
     );

  u_IBUFDS_FAST_inst : IBUFDS
    generic map (
       DIFF_TERM => FALSE, -- Differential Termination
       IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
       IOSTANDARD => "LVDS")
    port map (
       O => c6c_fast,  -- Buffer output
       I => CLK_FASTP,  -- Diff_p buffer input (connect directly to top-level port)
       IB => CLK_FASTN -- Diff_n buffer input (connect directly to top-level port)
       );



end Behavioral;
