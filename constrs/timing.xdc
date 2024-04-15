# Clock definition
#create_clock -period 7.812 -name mznu_clkddr -waveform {0.000 3.906} [get_ports {MZNU_CLKDDR_P}]
#create_clock -period 4.000 -name mznu_clkddr -waveform {0.000 2.000} [get_ports MZNU_CLKDDR_P]
create_clock -period 2.000 -name mznu_clkddr -waveform {0.000 1.000} [get_ports MZNU_CLKDDR_P]
set_input_jitter mznu_clkddr 0.030
#create_clock -period 7.812 -name mznd_clkddr -waveform {0.000 3.906} [get_ports {MZND_CLKDDR_P}]
#create_clock -period 4.000 -name mznd_clkddr -waveform {0.000 2.000} [get_ports MZND_CLKDDR_P]
create_clock -period 2.000 -name mznd_clkddr -waveform {0.000 1.000} [get_ports MZND_CLKDDR_P]
set_input_jitter mznd_clkddr 0.030

create_clock -period 2.000 -name clk_fast -waveform {0.000 1.000} [get_ports CLK_FASTP]
set_input_jitter clk_fast 0.030

create_clock -period 8.000 -name clk_slow -waveform {0.000 4.000} [get_ports CLK_SLOWP]
set_input_jitter clk_slow 0.030

# SiTCP

#set_false_path -from [get_pins u_C6C_Inst/en_ref_clk_reg/C] -to [get_pins u_C6C_Inst/ODDR_inst/CE]

set_false_path -through [get_ports {LED[*]}]
set_false_path -through [get_nets {DIP[*]}]
#set_false_path -through [get_nets {NIMOUT[*]}]
set_false_path -through [get_nets user_reset]
set_false_path -through [get_nets bct_reset]
set_false_path -through [get_nets emergency_reset]
set_false_path -through [get_nets u_BCT_Inst/rst_from_bus]

#create_generated_clock -name clk_slow [get_pins u_ClkSys_Inst/inst/mmcm_adv_inst/CLKOUT0]
#create_generated_clock -name clk_fast [get_pins u_ClkSys_Inst/inst/mmcm_adv_inst/CLKOUT1]

create_generated_clock -name clk_sys    [get_pins u_ClkSys_Inst/inst/mmcm_adv_inst/CLKOUT0]
create_generated_clock -name clk_spi    [get_pins u_ClkSys_Inst/inst/mmcm_adv_inst/CLKOUT1]
create_generated_clock -name clk_idelay [get_pins u_ClkSys_Inst/inst/mmcm_adv_inst/CLKOUT2]

create_generated_clock -name clk_ddr_u [get_pins u_DDRRecvU_Inst/u_BUFR_inst/O]
create_generated_clock -name clk_ddr_d [get_pins u_DDRRecvD_Inst/u_BUFR_inst/O]

set_clock_groups -name async_sys -asynchronous -group {clk_slow clk_fast} -group clk_spi -group clk_ddr_u -group clk_ddr_d -group clk_idelay -group clk_sys -group GTX_REFCLK_P


#set_clock_groups -name async_sys_mznd -asynchronous -group [get_clocks -include_generated_clocks clk_sys_clk_wiz_0] -group [get_clocks mznd_clkddr]
#set_clock_groups -name async_sys_mznd -asynchronous -group {clk_slow} -group [get_clocks -include_generated_clocks I]





