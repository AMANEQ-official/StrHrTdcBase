# ----------------------------------------------------------------
# Pin assignments
# ----------------------------------------------------------------
# clock
set_property PACKAGE_PIN E22 [get_ports PROGB_ON]
set_property PACKAGE_PIN F22 [get_ports BASE_CLKP]
set_property PACKAGE_PIN E23 [get_ports BASE_CLKN]
set_property PACKAGE_PIN H9 [get_ports USR_RSTB]
set_property PACKAGE_PIN U7 [get_ports LED[1]]
set_property PACKAGE_PIN V6 [get_ports LED[2]]
set_property PACKAGE_PIN V4 [get_ports LED[3]]
set_property PACKAGE_PIN W3 [get_ports LED[4]]
set_property PACKAGE_PIN U5 [get_ports DIP[1]]
set_property PACKAGE_PIN U6 [get_ports DIP[2]]
set_property PACKAGE_PIN U2 [get_ports DIP[3]]
set_property PACKAGE_PIN U1 [get_ports DIP[4]]
set_property PACKAGE_PIN N12 [get_ports VP]
set_property PACKAGE_PIN P11 [get_ports VN]

# GTX ------------------------------------------------------------------
set_property PACKAGE_PIN D6 [get_ports GTX_REFCLK_P]
set_property PACKAGE_PIN D5 [get_ports GTX_REFCLK_N]
set_property PACKAGE_PIN F2 [get_ports GTX_TX_P[1]]
set_property PACKAGE_PIN G4 [get_ports GTX_RX_P[1]]
set_property PACKAGE_PIN F1 [get_ports GTX_TX_N[1]]
set_property PACKAGE_PIN G3 [get_ports GTX_RX_N[1]]
#set_property PACKAGE_PIN D2 [get_ports GTX_TX_P[2]]
#set_property PACKAGE_PIN E4 [get_ports GTX_RX_P[2]]
#set_property PACKAGE_PIN D1 [get_ports GTX_TX_N[2]]
#set_property PACKAGE_PIN E3 [get_ports GTX_RX_N[2]]

# MIKUMARI connector -----------------------------------------------------
# GN-2006-1
#set_property PACKAGE_PIN B20 [get_ports MIKUMARI_RXP]
#set_property PACKAGE_PIN A20 [get_ports MIKUMARI_RXN]
#set_property PACKAGE_PIN A23 [get_ports MIKUMARI_TXP]
#set_property PACKAGE_PIN A24 [get_ports MIKUMARI_TXN]

# GN-2006-4
set_property PACKAGE_PIN AB16 [get_ports MIKUMARI_RXP]
set_property PACKAGE_PIN AC16 [get_ports MIKUMARI_RXN]
set_property PACKAGE_PIN AB17 [get_ports MIKUMARI_TXP]
set_property PACKAGE_PIN AC17 [get_ports MIKUMARI_TXN]

# MAIN PORT -----------------------------------------------------

# MZN connector -----------------------------------A---------------
# MZN up
set_property PACKAGE_PIN R22 [get_ports MZNU_FRST_P]
set_property PACKAGE_PIN R23 [get_ports MZNU_FRST_N]
set_property PACKAGE_PIN N19 [get_ports MZNU_SLOT_POS_P]
set_property PACKAGE_PIN M20 [get_ports MZNU_SLOT_POS_N]

set_property PACKAGE_PIN T24 [get_ports MZNU_CDCM_TXP]
set_property PACKAGE_PIN T25 [get_ports MZNU_CDCM_TXN]
set_property PACKAGE_PIN T18 [get_ports MZNU_CDCM_RXP]
set_property PACKAGE_PIN T19 [get_ports MZNU_CDCM_RXN]

set_property PACKAGE_PIN P23 [get_ports MZNU_CLK_P]
set_property PACKAGE_PIN N23 [get_ports MZNU_CLK_N]
set_property PACKAGE_PIN P24 [get_ports MZNU_POSI_P]
set_property PACKAGE_PIN N24 [get_ports MZNU_POSI_N]
set_property PACKAGE_PIN M24 [get_ports MZNU_PISO_P]
set_property PACKAGE_PIN L24 [get_ports MZNU_PISO_N]
set_property PACKAGE_PIN R21 [get_ports MZNU_SCN_REQ_P]
set_property PACKAGE_PIN P21 [get_ports MZNU_SCN_REQ_N]
set_property PACKAGE_PIN M21 [get_ports MZNU_PRI_ACTIVE_P]
set_property PACKAGE_PIN M22 [get_ports MZNU_PRI_ACTIVE_N]

set_property PACKAGE_PIN N26 [get_ports {MZNU_STATUS_IN_P[0]}]
set_property PACKAGE_PIN M26 [get_ports {MZNU_STATUS_IN_N[0]}]

set_property PACKAGE_PIN R26 [get_ports {MZNU_STATUS_OUT_P[0]}]
set_property PACKAGE_PIN P26 [get_ports {MZNU_STATUS_OUT_N[0]}]
set_property PACKAGE_PIN R25 [get_ports {MZNU_STATUS_OUT_P[1]}]
set_property PACKAGE_PIN P25 [get_ports {MZNU_STATUS_OUT_N[1]}]
set_property PACKAGE_PIN V23 [get_ports {MZNU_STATUS_OUT_P[2]}]
set_property PACKAGE_PIN V24 [get_ports {MZNU_STATUS_OUT_N[2]}]
set_property PACKAGE_PIN U24 [get_ports {MZNU_STATUS_OUT_P[3]}]
set_property PACKAGE_PIN U25 [get_ports {MZNU_STATUS_OUT_N[3]}]
set_property PACKAGE_PIN M25 [get_ports {MZNU_STATUS_OUT_P[4]}]
set_property PACKAGE_PIN L25 [get_ports {MZNU_STATUS_OUT_N[4]}]


#set_property PACKAGE_PIN AB7 [get_ports MZNU_BUSY_P]
#set_property PACKAGE_PIN AC7 [get_ports MZNU_BUSY_N]
#set_property PACKAGE_PIN AB6 [get_ports MZNU_TRIGGER_P]
#set_property PACKAGE_PIN AC6 [get_ports MZNU_TRIGGER_N]
set_property PACKAGE_PIN G25 [get_ports {MZNU_DDRD_P[5]}]
set_property PACKAGE_PIN G26 [get_ports {MZNU_DDRD_N[5]}]
set_property PACKAGE_PIN G24 [get_ports {MZNU_DDRD_P[6]}]
set_property PACKAGE_PIN F24 [get_ports {MZNU_DDRD_N[6]}]
set_property PACKAGE_PIN F25 [get_ports {MZNU_DDRD_P[7]}]
set_property PACKAGE_PIN E26 [get_ports {MZNU_DDRD_N[7]}]
set_property PACKAGE_PIN D26 [get_ports {MZNU_DDRD_P[8]}]
set_property PACKAGE_PIN C26 [get_ports {MZNU_DDRD_N[8]}]
set_property PACKAGE_PIN K23 [get_ports {MZNU_DDRD_P[0]}]
set_property PACKAGE_PIN J23 [get_ports {MZNU_DDRD_N[0]}]
set_property PACKAGE_PIN G22 [get_ports MZNU_CLKDDR_P]
set_property PACKAGE_PIN F23 [get_ports MZNU_CLKDDR_N]
set_property PACKAGE_PIN J21 [get_ports {MZNU_DDRD_P[1]}]
set_property PACKAGE_PIN H22 [get_ports {MZNU_DDRD_N[1]}]
#set_property PACKAGE_PIN AD5 [get_ports {MZN_SIG_Un[25]}]
#set_property PACKAGE_PIN AD6 [get_ports {MZN_SIG_Up[25]}]
set_property PACKAGE_PIN K25 [get_ports MZNU_CLKHUL_P]
set_property PACKAGE_PIN K26 [get_ports MZNU_CLKHUL_N]
set_property PACKAGE_PIN H23 [get_ports {MZNU_DDRD_P[2]}]
set_property PACKAGE_PIN H24 [get_ports {MZNU_DDRD_N[2]}]
set_property PACKAGE_PIN H21 [get_ports {MZNU_DDRD_P[3]}]
set_property PACKAGE_PIN G21 [get_ports {MZNU_DDRD_N[3]}]
set_property PACKAGE_PIN J26 [get_ports {MZNU_DDRD_P[4]}]
set_property PACKAGE_PIN H26 [get_ports {MZNU_DDRD_N[4]}]

# MZN down
set_property PACKAGE_PIN AB21 [get_ports MZND_FRST_P]
set_property PACKAGE_PIN AC21 [get_ports MZND_FRST_N]
set_property PACKAGE_PIN AC18 [get_ports MZND_SLOT_POS_P]
set_property PACKAGE_PIN AD18 [get_ports MZND_SLOT_POS_N]

set_property PACKAGE_PIN AE17 [get_ports MZND_CDCM_TXP]
set_property PACKAGE_PIN AF17 [get_ports MZND_CDCM_TXN]
set_property PACKAGE_PIN AD16 [get_ports MZND_CDCM_RXP]
set_property PACKAGE_PIN AE16 [get_ports MZND_CDCM_RXN]


set_property PACKAGE_PIN AB19 [get_ports MZND_CLK_P]
set_property PACKAGE_PIN AB20 [get_ports MZND_CLK_N]
set_property PACKAGE_PIN AD21 [get_ports MZND_POSI_P]
set_property PACKAGE_PIN AE21 [get_ports MZND_POSI_N]
set_property PACKAGE_PIN AD23 [get_ports MZND_PISO_P]
set_property PACKAGE_PIN AD24 [get_ports MZND_PISO_N]
set_property PACKAGE_PIN V21  [get_ports MZND_SCN_REQ_P]
set_property PACKAGE_PIN W21  [get_ports MZND_SCN_REQ_N]
set_property PACKAGE_PIN AB22 [get_ports MZND_PRI_ACTIVE_P]
set_property PACKAGE_PIN AC22 [get_ports MZND_PRI_ACTIVE_N]

set_property PACKAGE_PIN AF24 [get_ports {MZND_STATUS_IN_P[0]}]
set_property PACKAGE_PIN AF25 [get_ports {MZND_STATUS_IN_N[0]}]

set_property PACKAGE_PIN AE22 [get_ports  {MZND_STATUS_OUT_P[0]}]
set_property PACKAGE_PIN AF22 [get_ports  {MZND_STATUS_OUT_N[0]}]
set_property PACKAGE_PIN AE23 [get_ports {MZND_STATUS_OUT_P[1]}]
set_property PACKAGE_PIN AF23 [get_ports {MZND_STATUS_OUT_N[1]}]
set_property PACKAGE_PIN AA19 [get_ports {MZND_STATUS_OUT_P[2]}]
set_property PACKAGE_PIN AA20 [get_ports {MZND_STATUS_OUT_N[2]}]
set_property PACKAGE_PIN AC19 [get_ports {MZND_STATUS_OUT_P[3]}]
set_property PACKAGE_PIN AD19 [get_ports {MZND_STATUS_OUT_N[3]}]
set_property PACKAGE_PIN AD25 [get_ports {MZND_STATUS_OUT_P[4]}]
set_property PACKAGE_PIN AE25 [get_ports {MZND_STATUS_OUT_N[4]}]


#set_property PACKAGE_PIN AD15 [get_ports MZND_BUSY_P]
#set_property PACKAGE_PIN AE15 [get_ports MZND_BUSY_N]
#set_property PACKAGE_PIN AB16 [get_ports MZND_TRIGGER_P]
#set_property PACKAGE_PIN AC16 [get_ports MZND_TRIGGER_N]
set_property PACKAGE_PIN AA25 [get_ports {MZND_DDRD_P[5]}]
set_property PACKAGE_PIN AB25 [get_ports {MZND_DDRD_N[5]}]
set_property PACKAGE_PIN Y25  [get_ports {MZND_DDRD_P[6]}]
set_property PACKAGE_PIN Y26  [get_ports {MZND_DDRD_N[6]}]
set_property PACKAGE_PIN W25  [get_ports {MZND_DDRD_P[7]}]
set_property PACKAGE_PIN W26  [get_ports {MZND_DDRD_N[7]}]
set_property PACKAGE_PIN U26  [get_ports {MZND_DDRD_P[8]}]
set_property PACKAGE_PIN V26  [get_ports {MZND_DDRD_N[8]}]
set_property PACKAGE_PIN AC23 [get_ports {MZND_DDRD_P[0]}]
set_property PACKAGE_PIN AC24 [get_ports {MZND_DDRD_N[0]}]
set_property PACKAGE_PIN AA23 [get_ports MZND_CLKDDR_P]
set_property PACKAGE_PIN AB24 [get_ports MZND_CLKDDR_N]
set_property PACKAGE_PIN Y23  [get_ports {MZND_DDRD_P[1]}]
set_property PACKAGE_PIN AA24 [get_ports {MZND_DDRD_N[1]}]
#set_property PACKAGE_PIN AF9 [get_ports {MZN_SIG_Dn[25]}]
#set_property PACKAGE_PIN AF10 [get_ports {MZN_SIG_Dp[25]}]
set_property PACKAGE_PIN AD26 [get_ports MZND_CLKHUL_P]
set_property PACKAGE_PIN AE26 [get_ports MZND_CLKHUL_N]
set_property PACKAGE_PIN W20  [get_ports {MZND_DDRD_P[2]}]
set_property PACKAGE_PIN Y21  [get_ports {MZND_DDRD_N[2]}]
set_property PACKAGE_PIN W23  [get_ports {MZND_DDRD_P[3]}]
set_property PACKAGE_PIN W24  [get_ports {MZND_DDRD_N[3]}]
set_property PACKAGE_PIN AB26 [get_ports {MZND_DDRD_P[4]}]
set_property PACKAGE_PIN AC26 [get_ports {MZND_DDRD_N[4]}]


# SPI flash memory --------------------------------------------------
set_property PACKAGE_PIN B24 [get_ports MOSI]
set_property PACKAGE_PIN A25 [get_ports DIN]
set_property PACKAGE_PIN C23 [get_ports FCSB]

# EEPROM ------------------------------------------------------------
set_property PACKAGE_PIN C21 [get_ports EEP_CS[1]]
set_property PACKAGE_PIN C22 [get_ports EEP_SK[1]]
set_property PACKAGE_PIN D21 [get_ports EEP_DI[1]]
set_property PACKAGE_PIN E21 [get_ports EEP_DO[1]]


# NIM IN ------------------------------------------------------------
set_property PACKAGE_PIN V8 [get_ports {NIM_IN[1]}]
set_property PACKAGE_PIN V7 [get_ports {NIM_IN[2]}]

# NIM OUT -----------------------------------------------------------
set_property PACKAGE_PIN V11 [get_ports {NIM_OUT[1]}]
set_property PACKAGE_PIN W11 [get_ports {NIM_OUT[2]}]

# JItter cleaner -------------------------------------------------------
set_property PACKAGE_PIN AC14 [get_ports CDCE_PDB]
set_property PACKAGE_PIN AB15 [get_ports CDCE_LOCK]
set_property PACKAGE_PIN AD14 [get_ports CDCE_SCLK]
set_property PACKAGE_PIN AB14 [get_ports CDCE_SO]
set_property PACKAGE_PIN AA17 [get_ports CDCE_SI]
set_property PACKAGE_PIN AA18 [get_ports CDCE_LE]
set_property PACKAGE_PIN AD15 [get_ports CDCE_REFP]
set_property PACKAGE_PIN AE15 [get_ports CDCE_REFN]
set_property PACKAGE_PIN AA10 [get_ports CLK_FASTP]
set_property PACKAGE_PIN AB10 [get_ports CLK_FASTN]
set_property PACKAGE_PIN AB11 [get_ports CLK_SLOWP]
set_property PACKAGE_PIN AC11 [get_ports CLK_SLOWN]

# ----------------------------------------------------------------
# Attribute
# ----------------------------------------------------------------
# System --
set_property IOSTANDARD LVCMOS25 [get_ports PROGB_ON]
set_property IOSTANDARD LVDS_25 [get_ports BASE_CLKP]
set_property DIFF_TERM TRUE [get_ports BASE_CLKP]
set_property IOSTANDARD LVCMOS33 [get_ports USR_RSTB]
set_property IOSTANDARD LVCMOS15 [get_ports LED[*]]
set_property IOSTANDARD LVCMOS15 [get_ports DIP[*]]
set_property PULLUP TRUE [get_ports DIP[*]]

# input ------------------------------------------------------------
#set_property IOSTANDARD LVCMOS33 [get_ports {MAIN_IN_U[*]}]
#set_property IOSTANDARD LVCMOS33 [get_ports MAIN_IN_D[*]]
#set_property IOB true [get_ports MAIN_IN_U[*]]
#set_property IOB true [get_ports MAIN_IN_D[*]]

#set_property IOSTANDARD LVDS [get_ports {MZN_SIG_Up[*]}]
#set_property DIFF_TERM true [get_ports {MZN_SIG_Up[*]}]
#set_property IOB true [get_ports MZN_SIG_Up[*]]

# MZN-U ------------------------------------------------------------
set_property IOSTANDARD LVDS_25 [get_ports MZNU_CDCM_TXP]
set_property IOSTANDARD LVDS_25 [get_ports MZNU_CDCM_RXP]
set_property DIFF_TERM TRUE [get_ports MZNU_CDCM_RXP]


set_property IOSTANDARD LVDS_25 [get_ports MZNU_CLKHUL_P]
set_property IOSTANDARD LVDS_25 [get_ports MZNU_FRST_P]
set_property IOSTANDARD LVDS_25 [get_ports MZNU_SLOT_POS_P]

#set_property IOSTANDARD LVDS_25 [get_ports MZNU_TRIGGER_P]
#set_property IOSTANDARD LVDS_25 [get_ports MZNU_BUSY_P]

set_property IOSTANDARD LVDS_25 [get_ports MZNU_PRI_ACTIVE_P]
set_property IOB TRUE [get_ports MZNU_PRI_ACTIVE_P]

set_property IOSTANDARD LVDS_25 [get_ports MZNU_SCN_REQ_P]
set_property DIFF_TERM TRUE [get_ports MZNU_SCN_REQ_P]
set_property IOB TRUE [get_ports MZNU_SCN_REQ_P]

set_property IOSTANDARD LVDS_25 [get_ports MZNU_PISO_P]
set_property DIFF_TERM TRUE [get_ports MZNU_PISO_P]
set_property IOB TRUE [get_ports MZNU_PISO_P]

set_property IOSTANDARD LVDS_25 [get_ports MZNU_POSI_P]
set_property IOB TRUE [get_ports MZNU_POSI_P]

set_property IOSTANDARD LVDS_25 [get_ports MZNU_CLK_P]
set_property IOB TRUE [get_ports MZNU_CLK_P]

set_property IOSTANDARD LVDS_25 [get_ports MZNU_CLKDDR_P]
set_property DIFF_TERM TRUE [get_ports MZNU_CLKDDR_P]

set_property IOSTANDARD LVDS_25 [get_ports {MZNU_DDRD_P[*]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_P[4]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_N[4]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_P[3]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_N[3]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_P[2]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_N[2]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_P[1]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_N[1]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_P[0]}]
set_property DIFF_TERM TRUE [get_ports {MZNU_DDRD_N[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {MZNU_STATUS_IN_P[*]}]
set_property DIFF_TERM true [get_ports {MZNU_STATUS_IN_P[*]}]

set_property IOSTANDARD LVDS_25 [get_ports {MZNU_STATUS_OUT_P[*]}]
set_property DIFF_TERM true [get_ports {MZNU_STATUS_OUT_P[*]}]

# MZN-D ----------------------------------------------------------
set_property IOSTANDARD LVDS [get_ports MZND_CDCM_TXP]
set_property IOSTANDARD LVDS [get_ports MZND_CDCM_RXP]
set_property DIFF_TERM TRUE [get_ports MZND_CDCM_RXP]

set_property IOSTANDARD LVDS_25 [get_ports MZND_CLKHUL_P]
set_property IOSTANDARD LVDS_25 [get_ports MZND_FRST_P]
set_property IOSTANDARD LVDS [get_ports MZND_SLOT_POS_P]


set_property IOSTANDARD LVDS_25 [get_ports MZND_PRI_ACTIVE_P]
set_property IOB TRUE [get_ports MZND_PRI_ACTIVE_P]

set_property IOSTANDARD LVDS_25 [get_ports MZND_SCN_REQ_P]
set_property DIFF_TERM TRUE [get_ports MZND_SCN_REQ_P]
set_property IOB TRUE [get_ports MZND_SCN_REQ_P]

set_property IOSTANDARD LVDS_25 [get_ports MZND_PISO_P]
set_property DIFF_TERM TRUE [get_ports MZND_PISO_P]
set_property IOB TRUE [get_ports MZND_PISO_P]

set_property IOSTANDARD LVDS_25 [get_ports MZND_POSI_P]
set_property IOB TRUE [get_ports MZND_POSI_P]

set_property IOSTANDARD LVDS [get_ports MZND_CLK_P]
set_property IOB TRUE [get_ports MZND_CLK_P]


set_property IOSTANDARD LVDS_25 [get_ports MZND_CLKDDR_P]
set_property DIFF_TERM TRUE [get_ports MZND_CLKDDR_P]

set_property IOSTANDARD LVDS_25 [get_ports {MZND_DDRD_P[*]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_P[4]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_N[4]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_P[3]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_N[3]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_P[2]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_N[2]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_P[1]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_N[1]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_P[0]}]
set_property DIFF_TERM TRUE [get_ports {MZND_DDRD_N[0]}]

set_property IOSTANDARD LVDS_25 [get_ports {MZND_STATUS_IN_P[*]}]
set_property DIFF_TERM true [get_ports {MZND_STATUS_IN_P[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {MZND_STATUS_OUT_P[0]}]
set_property IOSTANDARD LVDS_25 [get_ports {MZND_STATUS_OUT_P[1]}]
set_property IOSTANDARD LVDS    [get_ports {MZND_STATUS_OUT_P[2]}]
set_property IOSTANDARD LVDS    [get_ports {MZND_STATUS_OUT_P[3]}]
set_property IOSTANDARD LVDS_25 [get_ports {MZND_STATUS_OUT_P[4]}]
set_property DIFF_TERM true [get_ports {MZND_STATUS_OUT_P[*]}]

# SPI flash memory -------------------------------------------------
set_property IOSTANDARD LVCMOS25 [get_ports MOSI]
set_property IOB TRUE [get_ports MOSI]
set_property IOSTANDARD LVCMOS25 [get_ports DIN]
set_property IOB TRUE [get_ports DIN]
set_property IOSTANDARD LVCMOS25 [get_ports FCSB]
set_property IOB TRUE [get_ports FCSB]

# MIKUMARI connector --------------------------------
# GN-2006-1
#set_property IOSTANDARD LVDS_25 [get_ports MIKUMARI_TXP]
#set_property IOSTANDARD LVDS_25 [get_ports MIKUMARI_RXP]
#set_property DIFF_TERM TRUE [get_ports MIKUMARI_RXP]

# GN-2006-4
set_property IOSTANDARD LVDS [get_ports MIKUMARI_TXP]
set_property IOSTANDARD LVDS [get_ports MIKUMARI_RXP]
set_property DIFF_TERM TRUE [get_ports MIKUMARI_RXP]

# EEPROM ----------------------------------------------------------
set_property IOSTANDARD LVCMOS25 [get_ports EEP_CS[*]]
set_property IOSTANDARD LVCMOS25 [get_ports EEP_SK[*]]
set_property IOSTANDARD LVCMOS25 [get_ports EEP_DI[*]]
set_property IOSTANDARD LVCMOS25 [get_ports EEP_DO[*]]
set_property PULLUP TRUE [get_ports EEP_DO[*]]

# NIM -------------------------------------------------------------
set_property IOSTANDARD LVCMOS15 [get_ports {NIM_OUT[*]}]
set_property IOSTANDARD LVCMOS15 [get_ports {NIM_IN[*]}]
set_property IOB true [get_ports {NIM_OUT[*]}]

# JItter cleaner -------------------------------------------------------
set_property IOSTANDARD LVCMOS18 [get_ports CDCE_PDB]
set_property IOSTANDARD LVCMOS18 [get_ports CDCE_LOCK]
set_property IOSTANDARD LVCMOS18 [get_ports CDCE_SCLK]
set_property IOSTANDARD LVCMOS18 [get_ports CDCE_SO]
set_property IOSTANDARD LVCMOS18 [get_ports CDCE_SI]
set_property IOSTANDARD LVCMOS18 [get_ports CDCE_LE]
set_property IOSTANDARD LVDS_25 [get_ports CDCE_REFP]
set_property IOSTANDARD LVDS [get_ports CDCE_REFN]

set_property IOSTANDARD LVDS [get_ports CLK_FASTP]
set_property IOSTANDARD LVDS [get_ports CLK_FASTN]
set_property IOSTANDARD LVDS [get_ports CLK_SLOWP]
set_property IOSTANDARD LVDS [get_ports CLK_SLOWN]

