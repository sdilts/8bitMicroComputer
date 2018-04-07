library IEEE;
use IEEE.std_logic_1164.all;

use WORK.cpu_constants.all;


entity computer is
  port(port_in_00, port_in_01, port_in_02, port_in_03,
       port_in_04, port_in_05, port_in_06, port_in_07,
       port_in_08, port_in_09, port_in_10, port_in_11,
       port_in_12, port_in_13, port_in_14, port_in_15 : in std_logic_vector(word_width downto 0);
       clock, reset  : in std_logic;
       port_out_00, port_out_01, port_out_02, port_out_03,
       port_out_04, port_out_05, port_out_06, port_out_07,
       port_out_08, port_out_09, port_out_10, port_out_11,
       port_out_12, port_out_13, port_out_14, port_out_15 : out std_logic_vector(word_width downto 0));
end entity;

architecture computer_arch of computer is


begin

end architecture;
