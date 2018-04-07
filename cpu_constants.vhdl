library IEEE;
use IEEE.std_logic_1164.all;

package cpu_constants is
  constant word_width : integer := 7;
  type io_array is array(15 downto 0) of std_logic_vector(word_width downto 0);
  constant LDA_IMM : std_logic_vector (word_width downto 0) := x"86";
  constant LDA_DIR : std_logic_vector (word_width downto 0) := x"87";
  constant LDB_IMM : std_logic_vector (word_width downto 0) := x"88";
  constant LDB_DIR : std_logic_vector (word_width downto 0) := x"89";
  constant STA_DIR : std_logic_vector (word_width downto 0) := x"96";
  constant STB_DIR : std_logic_vector (word_width downto 0) := x"97";
  constant ADD_AB  : std_logic_vector (word_width downto 0) := x"42";
  constant SUB_AB  : std_logic_vector (word_width downto 0) := x"43";
  constant AND_AB  : std_logic_vector (word_width downto 0) := x"44";
  constant OR_AB   : std_logic_vector (word_width downto 0) := x"45";
  constant INCA    : std_logic_vector (word_width downto 0) := x"46";
  constant INCB    : std_logic_vector (word_width downto 0) := x"47";
  constant DECA    : std_logic_vector (word_width downto 0) := x"48";
  constant DECB    : std_logic_vector (word_width downto 0) := x"49";
  constant BRA     : std_logic_vector (word_width downto 0) := x"20";
  constant BMI     : std_logic_vector (word_width downto 0) := x"21";
  constant BPL     : std_logic_vector (word_width downto 0) := x"22";
  constant BEQ     : std_logic_vector (word_width downto 0) := x"23";
  constant BNE     : std_logic_vector (word_width downto 0) := x"24";
  constant BVS     : std_logic_vector (word_width downto 0) := x"25";
end package;
