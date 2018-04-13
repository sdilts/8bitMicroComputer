library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use WORK.cpu_constants.all;

entity rom_128x8_sync is
  port (address  : in std_logic_vector(6 downto 0);
        clock    : in std_logic;
        data_out : out std_logic_vector(word_width downto 0));
end entity;

architecture rom_128x8_sync_arch of rom_128x8_sync is
  type ROM_type is array(127 downto 0) of std_logic_vector(word_width downto 0);

  constant ROM : ROM_type := (0 => LDA_IMM,
                              1 => x"AA",
                              2 => LDA_IMM,
                              3 => x"AA",
                              4 => x"BB",
                              5 => x"AA",
                              6 => x"99",
                              7 => x"88",
                              8 => x"77",
                              9 => x"66",
                              10 => x"55",
                              11 => x"44",
                              12 => x"33",
                              13 => x"22",
                              14 => x"11",
                              15 => x"00",
                              others => x"00");


begin
  MEMORY : process(clock)
  begin
    if ( rising_edge(clock) ) then
      data_out <= ROM (to_integer(unsigned(address)));
    end if;
  end process;
end architecture;
