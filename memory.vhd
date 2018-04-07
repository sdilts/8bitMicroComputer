library IEEE;
use IEEE.std_logic_1164.all;
use WORK.cpu_constants.all;

entity memory is
  -- assignment specifications say that this cannot be an array:
  port(clock, reset, w_bit : in std_logic;
       address, data_in    : in std_logic_vector(word_width downto 0);
       ports_in            : in io_array;
       data_out            : out std_logic_vector(word_width downto 0);
       ports_out           : out io_array);
end entity;

architecture memory_arch of memory is

  component rom_128x8_sync is
    port (address  : in std_logic_vector(word_width downto 0);
          clock    : in std_logic;
          data_out : out std_logic_vector(word_width downto 0));
  end component;

  component rw_96x8_sync is
  port(address, data_in : in std_logic_vector(word_width downto 0);
       w_bit            : in std_logic;
       clock            : in std_logic;
       data_out : out std_logic_vector(word_width downto 0));
  end component;

  signal rom_out : std_logic_vector(word_width downto 0);
  signal rw_out  : std_logic_vector(word_width downto 0);
begin

  ROM : rom_128x8_sync port map(address  => address,
                                clock    => clock,
                                data_out => rom_out);

  RW  : rw_96x8_sync port map(address => address,
                              data_in => data_in,
                              w_bit   => w_bit,
                              clock => clock,
                              data_out => rw_out);

end architecture;
