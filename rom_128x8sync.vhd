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

  -- deliverable 2:
  -- constant ROM : ROM_type := (0 => LDA_IMM,
  --                             1 => x"AA",
  --                             2 => STA_DIR,
  --                             3 =>  x"80",
  --                             4 => LDA_DIR,
  --                             5 =>  x"81", -- HEX0
  --                             6 => BRA,
  --                             7 =>  x"06", -- loop forever
  --                             8 => STA_DIR,
  --                             9 => x"E3",  -- HEX2
  --                             10 => STA_DIR,
  --                             11 => x"E4", -- HEX3
  --                             12 => BRA,
  --                             13 => x"00", -- loop forever
  --                             14 => x"11",
  --                             15 => x"00",
  --                             others => x"00");

  -- deliverable 3:
  -- constant ROM : ROM_type := (0 => LDA_DIR,
  --                             1 => x"F0",
  --                             2 => STA_DIR,
  --                             3 =>  x"E0", -- LEDR
  --                             4 => STA_DIR,
  --                             5 =>  x"E1", -- HEX0
  --                             6 => STA_DIR,
  --                             7 =>  x"E2", -- HEX1
  --                             8 => STA_DIR,
  --                             9 => x"E3",  -- HEX2
  --                             10 => STA_DIR,
  --                             11 => x"E4", -- HEX3
  --                             12 => BRA,
  --                             13 => x"00", -- loop forever
  --                             14 => x"11",
  --                             15 => x"00",
  --                             others => x"00");

  -- Need to use:
  -- AND_AB
  -- OR_AB
  -- BCS

  -- adding program: showcases LDB_DIR, STB_DIR, ADD_AB, BEQ
  -- loops until inputs on port 0 and port 1 are equal
  -- constant ROM : ROM_type := (0 => LDA_DIR,
  --                             1 => x"F0",
  --                             2 => LDB_DIR,
  --                             3 =>  x"F1",
  --                             4 => STA_DIR, -- HEX0
  --                             5 =>  x"E1",
  --                             6 => STB_DIR, -- HEX1
  --                             7 =>  x"E2",
  --                             8 => ADD_AB,  -- HEX2
  --                             9 => STA_DIR,
  --                             10 => x"E3",
  --                             11 => BEQ, -- HEX3
  --                             12 => x"00",
  --                             13 => BRA, -- loop forever
  --                             14 => x"11",
  --                             15 => x"00",
  --                             others => x"00");

  -- PROG2
  -- adding program: showcases LDB_DIR, STB_DIR, ADD_AB, BEQ
  -- adds up until there is an overflow, then decrements until there is an
  -- overflow. Repeat.
  constant ROM : ROM_type := (0 => LDB_IMM,
                              1 => x"00",
                              2 => LDA_IMM,
                              3 => x"00",
                              4 => STB_DIR,
                              5 =>  x"E1",
                              6 => STA_DIR,
                              7 =>  x"E2",
                              8 => INCA,
                              9 => INCB,
                              -- did an overflow occur?
                              10 => BVS,
                              11 => x"02",
                              12 => STB_DIR,
                              13 =>  x"E1",
                              14 => STA_DIR,
                              15 =>  x"E2",
                              16 => DECA,
                              17 => DECB,
                              18 => BVS,
                              19 => x"0C", -- goto 12
                              20 => BRA,
                              21 => x"02", -- start decrementing again
                              others => x"00");

  -- PROG1
  -- adding incrementing program: showcases SUB_AB, BMI
  -- repeats 11 - 0, then 11 - 1 ... until 11 -12, then stops.
  -- constant ROM : ROM_type := (0 => LDB_IMM,
  --                             1 => x"00",
  --                             2 => LDA_IMM,
  --                             3 => x"0B",
  --                             4 => STB_DIR,
  --                             5 =>  x"E1",
  --                             6 => STA_DIR,
  --                             7 =>  x"E2",
  --                             8 => SUB_AB,
  --                             9 => BMI,
  --                             10 => x"0E", -- go to end
  --                             11 => INCB,
  --                             12 => BRA,
  --                             13 => x"02", -- go back to begining
  --                             14 => STB_DIR,
  --                             15 =>  x"E1",
  --                             16 => BRA,
  --                             17 => x"13", -- infinite loop
  --                             others => x"00");

begin
  MEMORY : process(clock)
  begin
    if ( rising_edge(clock) ) then
      data_out <= ROM (to_integer(unsigned(address)));
    end if;
  end process;
end architecture;
