library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use WORK.cpu_constants.all;

entity rw_96x8_sync is
  port(address  : in std_logic_vector(6 downto 0);
       data_in  : in std_logic_vector(word_width downto 0);
       w_bit    : in std_logic;
       clock    : in std_logic;
       reset    : in std_logic;
       data_out : out std_logic_vector(7 downto 0));
end entity;

architecture rw_96x8_sync_arch of rw_96x8_sync is

  type RW_type is array(95 downto 0) of std_logic_vector(7 downto 0);
  signal storage : RW_type;
  signal interal : std_logic_vector(7 downto 0);

begin

  MEMORY : process(clock)
    variable addr_integer : integer := to_integer(unsigned(address));
  begin
    addr_integer := to_integer(unsigned(address));
    if reset = '0' then
      for I in 0 to storage'length -1 loop
        storage(i) <= x"00";
      end loop;
    elsif rising_edge(clock) and addr_integer >= 0 and addr_integer <= 95 then
      if (w_bit = '1') then
        storage(addr_integer) <= data_in;
      else
        interal <= storage(addr_integer);
      end if;
    end if;
  end process;

  data_out <= interal;
end architecture;
