library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use WORK.cpu_constants.all;

entity alu is
  port (ALU_Sel : in  std_logic_vector(2 downto 0);
        A       : in  std_logic_vector(word_width downto 0);
        B       : in  std_logic_vector(word_width downto 0);
        NZVC    : out std_logic_vector(3 downto 0);
        Result  : out std_logic_vector(word_width downto 0));

end entity;

architecture alu_arc of alu is


begin


  ALU_PROCESS : process(A, B, ALU_Sel)
    variable sum_uns : unsigned(8 downto 0);
  begin
    if ALU_Sel = "000" then
      -- addition
      sum_uns := unsigned('0' & A) + unsigned('0' & B);
      Result <= std_logic_vector(sum_uns(word_width downto 0));
      -- Negative flag
      NZVC(3) <= sum_uns(7);

      --zero flag (Z)
      if sum_uns(word_width downto 0) = x"00" then
        NZVC(2) <= '1';
      else
        NZVC(2) <= '0';
      end if;

      --overflow flag
      if ((A(7) = '0' and B(7) = '0' and sum_uns(7) = '1') or
          (A(7) = '1' and B(7) = '1' and sum_uns(7) = '0')) then
        NZVC(1) <= '1';
      else
        NZVC(1) <= '0';
      end if;

      -- carry flag
      NZVC(0) <= sum_uns(8);
    elsif ALU_Sel = "001" then
      -- subtraction!
      sum_uns := unsigned('0' & A) - unsigned('0' & B);
      Result <= std_logic_vector(sum_uns(word_width downto 0));
      -- Negative flag
      NZVC(3) <= sum_uns(7);

      --zero flag (Z)
      if sum_uns(word_width downto 0) = x"00" then
        NZVC(2) <= '1';
      else
        NZVC(2) <= '0';
      end if;

      --overflow flag
      if ((A(7) = '0' and B(7) = '1' and sum_uns(7) = '1') or
          (A(7) = '1' and B(7) = '0' and sum_uns(7) = '0')) then
        NZVC(1) <= '1';
      else
        NZVC(1) <= '0';
      end if;
      -- carry flag
      NZVC(0) <= sum_uns(8);
    else
      report "Invalid ALU_Sel";
    end if;
  end process;
end architecture;
