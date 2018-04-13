library IEEE;
use IEEE.std_logic_1164.all;

use WORK.cpu_constants.all;

entity multiplexer_3t1 is
  port(one, two, three : in std_logic_vector(word_width downto 0);
       sel  : in std_logic_vector(1 downto 0);
       output  : out std_logic_vector(word_width downto 0));
end entity;


architecture multiplexer_3t1_arch of multiplexer_3t1 is

begin

  MULTI : process(one, two, three, sel)
  begin
    assert sel /= "11" report "Sel should never be 11" severity failure;
    case sel is
      when "00" =>
        output <= one;
      when "01" =>
        output <= two;
      when "10" =>
        output <= three;
      when others =>
        -- report "Invalid input to multiplexer" severity failure;
        output <= "00000000";
    end case;
  end process;
end architecture;
