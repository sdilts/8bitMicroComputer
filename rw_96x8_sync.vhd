library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity rw_96x8_sync is
  port(address, data_in : in std_logic_vector(7 downto 0);
       w_bit            : in std_logic;
       clock            : in std_logic;
       data_out : out std_logic_vector(7 downto 0));
end entity;

architecture rw_96x8_sync_arch of rw_96x8_sync is

begin

end architecture;
