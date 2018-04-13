library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

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
    port (address  : in std_logic_vector(6 downto 0);
          clock    : in std_logic;
          data_out : out std_logic_vector(word_width downto 0));
  end component;

  component rw_96x8_sync is
    port(address  : in std_logic_vector(6 downto 0);
         data_in  : in std_logic_vector(word_width downto 0);
         w_bit    : in std_logic;
         clock    : in std_logic;
         reset    : in std_logic;
         data_out : out std_logic_vector(word_width downto 0));
  end component;

  signal rom_out : std_logic_vector(word_width downto 0);
  signal rw_out  : std_logic_vector(word_width downto 0);
begin

  ROM : rom_128x8_sync port map(address => address(6 downto 0),
                                clock    => clock,
                                data_out => rom_out);

  RW  : rw_96x8_sync port map(address => address(6 downto 0),
                              data_in => data_in,
                              w_bit   => w_bit,
                              clock => clock,
                              reset => reset,
                              data_out => rw_out);

  -- controls how the output ports are set:
  -- need w_bit set and in the correct address space:
  OUTPUT_PORTS : process(clock, reset)
    variable LSD : std_logic_vector(3 downto 0);
  begin
    LSD  := address(3 downto 0);
    if reset = '0' then
      for I in 0 to ports_out'length-1 loop
        ports_out(I) <= x"00";
      end loop;
    elsif address >= x"E0" and address < x"F0" then
      if rising_edge(clock) and w_bit = '1' then
        ports_out(to_integer(unsigned(LSD))) <= data_in;
      end if;
    end if;
  end process;

  OUTPUT_MULTI : process(ports_in, rom_out, rw_out,
                         address)
    -- least significant hex digit:
    variable LSD : std_logic_vector(3 downto 0);
  begin
    LSD  := address(3 downto 0);
    if address <= x"7f" then
      data_out <= rom_out;
    elsif address <= x"df" then
      data_out <= rw_out;
    elsif address >= x"F0" then
      data_out <= ports_in(to_integer(unsigned(LSD)));
    end if;
  end process;

end architecture;
