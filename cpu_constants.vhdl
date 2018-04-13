library IEEE;
use IEEE.std_logic_1164.all;

package cpu_constants is
  constant word_width : integer := 7;
  constant ALU_Sel_width : integer := 3;
  type io_array is array(15 downto 0) of std_logic_vector(word_width downto 0);

  constant LDA_IMM : std_logic_vector (word_width downto 0) := x"86";
  constant LDA_DIR : std_logic_vector (word_width downto 0) := x"87";
  constant LDB_IMM : std_logic_vector (word_width downto 0) := x"88";
  constant LDB_DIR : std_logic_vector (word_width downto 0) := x"89";
  constant STA_DIR : std_logic_vector (word_width downto 0) := x"96";
  constant STB_DIR : std_logic_vector (word_width downto 0) := x"97";
   -- ALU instructions:
  constant ADD_AB  : std_logic_vector (word_width downto 0) := x"42";
  constant SUB_AB  : std_logic_vector (word_width downto 0) := x"43";
  constant AND_AB  : std_logic_vector (word_width downto 0) := x"44";
  constant OR_AB   : std_logic_vector (word_width downto 0) := x"45";
  constant INCA    : std_logic_vector (word_width downto 0) := x"46";
  constant INCB    : std_logic_vector (word_width downto 0) := x"47";
  constant DECA    : std_logic_vector (word_width downto 0) := x"48";
  constant DECB    : std_logic_vector (word_width downto 0) := x"49";
  -- branch always
  constant BRA     : std_logic_vector (word_width downto 0) := x"20";
  -- branch if result is negative (N = 1)
  constant BMI     : std_logic_vector (word_width downto 0) := x"21";
  -- branch if result is positive (N = 0)
  constant BPL     : std_logic_vector (word_width downto 0) := x"22";
  -- branch if result is zero (Z = 1)
  constant BEQ     : std_logic_vector (word_width downto 0) := x"23";
  -- branch if not equal to zero (Z = 0)
  constant BNE     : std_logic_vector (word_width downto 0) := x"24";
  -- branch if two's complement overflow occured (V = 1)
  constant BVS     : std_logic_vector (word_width downto 0) := x"25";
  -- branch if two's complement overflow didn't occur (V = 0)
  constant BVC     : std_logic_vector (word_width downto 0) := x"26";
  -- branch if carry occured (C = 1)
  constant BCS     : std_logic_vector (word_width downto 0) := x"27";
  -- branch if carry did not occur (C = 0)
  constant BCC     : std_logic_vector (word_width downto 0) := x"28";

end package;
