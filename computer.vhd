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

  component cpu is
    port (Clock       : in std_logic;
          reset       : in std_logic;
          from_memory : in std_logic_vector(word_width downto 0);
          address     : out std_logic_vector(word_width downto 0);
          w_bit       : out std_logic;
          to_memory   : out std_logic_vector(word_width downto 0));
  end component;

  component memory is
  port(clock, reset, w_bit : in std_logic;
       address, data_in    : in std_logic_vector(word_width downto 0);
       ports_in            : in io_array;
       data_out            : out std_logic_vector(word_width downto 0);
       ports_out           : out io_array);
  end component;

  signal addr_s        : std_logic_vector(word_width downto 0);
  signal write_s       : std_logic;
  signal data_in_s   : std_logic_vector(word_width downto 0);
  signal data_out_s : std_logic_vector(word_width downto 0);
  signal io_in   : io_array;
  signal io_out  : io_array;

begin
  PROCESSOR : cpu port map(clock => clock, reset => reset,
                           address => addr_s, w_bit => write_s, to_memory => data_in_s,
                           from_memory => data_out_s);

  MEM : memory port map(clock => clock, reset => reset, w_bit => write_s,
                        address => addr_s, data_in => data_in_s,
                        ports_in => io_in,
                        data_out => data_out_s,
                        ports_out => io_out);

  io_in(0) <= port_in_00;
  port_out_00 <= io_out(0);
  io_in(1) <= port_in_01;
  port_out_01 <= io_out(1);
  io_in(2) <= port_in_02;
  port_out_02 <= io_out(2);
  io_in(3) <= port_in_03;
  port_out_03 <= io_out(3);
  io_in(4) <= port_in_04;
  port_out_04 <= io_out(4);
  io_in(5) <= port_in_05;
  port_out_05 <= io_out(5);
  io_in(6) <= port_in_06;
  port_out_06 <= io_out(6);
  io_in(7) <= port_in_07;
  port_out_07 <= io_out(7);
  io_in(8) <= port_in_08;
  port_out_08 <= io_out(8);
  io_in(9) <= port_in_09;
  port_out_09 <= io_out(9);
  io_in(10) <= port_in_10;
  port_out_10 <= io_out(10);
  io_in(11) <= port_in_11;
  port_out_11 <= io_out(11);
  io_in(12) <= port_in_12;
  port_out_12 <= io_out(12);
  io_in(13) <= port_in_13;
  port_out_13 <= io_out(13);
  io_in(14) <= port_in_14;
  port_out_14 <= io_out(14);
  io_in(15) <= port_in_15;
  port_out_15 <= io_out(15);


end architecture;
