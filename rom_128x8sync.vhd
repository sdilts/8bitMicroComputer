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

  -- demo 1:
  constant ROM : ROM_type := (0 => LDA_DIR,
                              1 => x"F0",
                              2 => STA_DIR,
                              3 =>  x"E0", -- LEDR
                              4 => STA_DIR,
                              5 =>  x"E1", -- HEX0
                              6 => STA_DIR,
                              7 =>  x"E2", -- HEX1
                              8 => STA_DIR,
                              9 => x"E3",  -- HEX2
                              10 => STA_DIR,
                              11 => x"E4", -- HEX3
                              12 => BRA,
                              13 => x"00", -- loop forever
                              14 => x"11",
                              15 => x"00",
                              others => x"00");

  -- adding program:
  -- constant ROM : ROM_type := (0 => LDA_IMM,
  --                             1 => x"10",
  --                             2 => LDB_IMM,
  --                             3 =>  x"0F",
  --                             4 => ADD_AB,
  --                             5 => STA_DIR, -- HEX0
  --                             6 =>  x"E1",
  --                             7 => STA_DIR, -- HEX1
  --                             8 =>  x"E0",
  --                             9 => BRA,  -- HEX2
  --                             10 => x"09",
  --                             11 => x"E3", -- HEX3
  --                             12 => BRA,
  --                             13 => x"00", -- loop forever
  --                             14 => x"11",
  --                             15 => x"00",
  --                             others => x"00");

begin
  MEMORY : process(clock)
  begin
    if ( rising_edge(clock) ) then
      data_out <= ROM (to_integer(unsigned(address)));
    end if;
  end process;
end architecture;
