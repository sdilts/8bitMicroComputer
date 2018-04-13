library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clock_div_prec is
  port(Clock_in  : in std_logic;
       Reset     : in std_logic;
       Sel       : in std_logic_vector(1 downto 0);
       Clock_out : out std_logic);
end entity;

architecture clock_div_prec_arch of clock_div_prec is
  signal cur_max      : unsigned(27 downto 0);
  signal cur_count    : unsigned(27 downto 0);
  signal internal_out : std_logic;

begin
  SELECT_MAX : process(Sel)
  begin
    case Sel is
      when "00" =>
        -- 1 hz
        cur_max <= x"17D7840";
      when "01" =>
        -- 2500000
        -- 10 hz
        cur_max <= x"02625A0";
      when "10" =>
        -- 250000
        -- 100 hz
        cur_max <= x"003D090";
      when "11" =>
        -- 25000
        -- 1 khz
        cur_max <= x"00061A8";
      when others =>
        cur_max <= x"0000000";
    end case;
  end process;

  CLOCK_DIV : process(Clock_in, Reset)
  begin
    if (Reset = '0') then
      cur_count <= x"0000000";
      internal_out <= '0';
    elsif (rising_edge(Clock_in)) then
      cur_count <= cur_count + 1;
      if cur_count > cur_max then
        cur_count <= x"0000000";
        internal_out <= not internal_out;
      end if;
    end if;
  end process;

  Clock_out <= internal_out;
end architecture;
