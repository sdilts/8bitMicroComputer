library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity alu is
  port (ALU_Sel : in  std_logic_vector(3 downto 0);
        A       : in  std_logic_vector(7 downto 0);
        B       : in  std_logic_vector(7 downto 0);
        NZVC    : out std_logic_vector(3 downto 0);
        Result  : out std_logic_vector(7 downto 0));

end entity;

architecture alu_arc of alu is


begin

end architecture;
