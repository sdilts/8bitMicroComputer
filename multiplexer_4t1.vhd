library IEEE;
use IEEE.std_logic_1164.all;

use WORK.cpu_constants;

entity multiplexer_3t1 is
  port(one, two, three : in std_logic_vector(word_width downto 0);
       sel  : in std_logic;
       output  : out std_logic_vector(word_width downto 0));
end entity;


architecture multiplexer_4t1_arch of multiplexer_4t1 is

end architecture;
