library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use WORK.cpu_constants.all;

entity cpu is
  port (Clock       : in std_logic;
        reset       : in std_logic;
        from_memory : in std_logic_vector(word_width downto 0);
        address   : out std_logic_vector(word_width downto 0);
        w         : out std_logic;
        to_memory : out std_logic_vector(word_width downto 0));
end entity;

architecture cpu_arch of cpu is

begin

end architecture;
