## Copyright (C) 2025 ARIA Sensing
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} pre_install (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: ARIA Sensing
## Created: 2025-01-08

function retval = pre_install (install_data)
    install_data

  if (! isfolder (".//src"))
      printf("src folder is missing");
  end
  cd ".//src";

  if (! isfolder(install_data.archprefix))
      mkdir(install_data.archprefix);
  end

  clear antenna_is_valid
  clear antenna_directivity
  clear antenna_group_delay
  clear antenna_rebuild_for_time_domain
  clear antenna_rebuild_for_time_domain_single_angle
  clear signal_uwb_pulse

  printf("-----------------------------------\n");
  printf("Antenna management \n");
  printf("------------------------------------\n");

  printf("Making antenna_create...\n");
  mkoctfile antenna_create.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("Making antenna_is_valid...\n");
  mkoctfile antenna_is_valid.cpp
  %-o install_data.archprefix+"/antenna_is_valid.oct"
  printf("Done \n");

  clear antenna_radiated_power
  printf("Making antenna_radiated_power...\n");
  mkoctfile antenna_radiated_power.cpp uwb_toolbox_utils.cpp util_interp_fields.cpp
  printf("Done \n");

  printf("Making antenna_directivity...\n");
  mkoctfile antenna_directivity.cpp directivity.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("Making antenna_group_delay...\n");
  mkoctfile antenna_group_delay.cpp uwb_toolbox_utils.cpp util_interp_fields.cpp
  printf("Done \n");

  printf("Making antenna_rebuild_for_time_domain...\n");
  mkoctfile antenna_rebuild_for_time_domain.cpp ant_build_time_domain_angle.cpp directivity.cpp uwb_toolbox_utils.cpp util_interp_fields.cpp
  printf("Done \n");

  printf("Making antenna_rebuild_for_time_domain_single_angle...\n");
  mkoctfile antenna_rebuild_for_time_domain_single_angle.cpp ant_build_time_domain_angle.cpp directivity.cpp uwb_toolbox_utils.cpp util_interp_fields.cpp
  printf("Done \n");

  printf("Making antenna rx...\n");
  mkoctfile antenna_calc_signal_rx.cpp ant_build_time_domain_angle.cpp directivity.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("Making antenna tx...\n");
  mkoctfile antenna_calc_signal_tx.cpp ant_build_time_domain_angle.cpp directivity.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("-----------------------------------\n");
  printf("Signals \n");
  printf("------------------------------------\n");

  printf("Making UWB kernels...\n");
  mkoctfile signal_uwb_pulse.cpp uwb_toolbox_utils.cpp util_interp_fields.cpp uwb_lt102_lt103_data.cpp
  printf("Done \n");

  printf("Making Correlation kernels...\n");
  mkoctfile signal_build_correlation_kernel.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("Making signal_clock_phase_noise...\n");
  mkoctfile signal_clock_phase_noise.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("Making PN Demod...\n");
  mkoctfile pm_demod.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("Making UWB Kernel...\n");
  mkoctfile signal_build_correlation_kernel.cpp uwb_toolbox_utils.cpp
  printf("Done \n");
  
  printf("Making data converter...\n");
  mkoctfile f16tosingle.cpp
  printf("Done \n");

  printf("Making Down Conversion...\n");
  mkoctfile signal_downconvert.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("Making ADC Conversion...\n");
  mkoctfile signal_adcconvert.cpp uwb_toolbox_utils.cpp
  printf("Done \n");

  printf("-----------------------------------\n");
  printf("ARIA Modules Control \n");
  printf("------------------------------------\n");
  mkoctfile var_immediate_inquiry.cpp aria_rdk_interface_message.cpp
  mkoctfile var_immediate_command.cpp aria_rdk_interface_message.cpp
  mkoctfile var_immediate_update.cpp aria_rdk_interface_message.cpp
  printf("Done\n");

  printf("-----------------------------------\n");
  printf("-----------------------------------\n");
  printf("Done \n");
  printf("------------------------------------\n");
  printf("-----------------------------------\n");

  cd ".."

endfunction
