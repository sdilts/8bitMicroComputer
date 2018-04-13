library IEEE;
use IEEE.std_logic_1164.all;

entity char_decoder is
  port (BIN_IN  : in std_logic_vector (3 downto 0);
        HEX_OUT : out std_logic_vector (6 downto 0));
end entity;

architecture char_decoder_arch of char_decoder is
begin

  -- Decoder stuff goes here
  SEVEN_SEG : process (BIN_IN)
  begin
    C1 : case BIN_IN is
      when x"0" =>
        HEX_OUT <= "1000000";
      when x"1" =>
        HEX_OUT <= "1111001";
      when x"2" =>
        HEX_OUT <= "0100100";
      when x"3" =>
        HEX_OUT <= "0110000";
      when x"4" =>
        HEX_OUT <= "0011001";
      when x"5" =>
        HEX_OUT <= "0010010";
      when x"6" =>
        HEX_OUT <= "0000010";
      when x"7" =>
        HEX_OUT <= "1111000";
      when x"8" =>
        HEX_OUT <= "0000000";
      when x"9" =>
        HEX_OUT <= "0010000";
      when x"A" =>
        HEX_OUT <= "0001000";
      when x"B" =>
        HEX_OUT <= "0000011";
      when x"C" =>
        HEX_OUT <= "0100111";
      when x"D" =>
        HEX_OUT <= "0100001";
      when x"E" =>
        HEX_OUT <= "0000110";
      when x"F" =>
        HEX_OUT <= "0001110";
      when others =>
        HEX_OUT <= "0000000";
    end  case;
  end process;

end architecture;
