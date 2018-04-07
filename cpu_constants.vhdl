library IEEE;
use IEEE.std_logic_1164.all;

package cpu_constants is
  constant word_width : integer := 7;
  type io_array is array(15 downto 0) of std_logic_vector(word_width downto 0);
end package;
