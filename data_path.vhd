library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use WORK.cpu_constants.all;

entity data_path is
  port(clock, reset : in std_logic;
       IR_Load, MAR_Load, PC_Load, PC_inc, A_Load, B_Load, CCR_Load : in std_logic;
       Bus2_Sel, Bus1_Sel : in std_logic_vector(1 downto 0);
       ALU_Sel : in std_logic_vector(2 downto 0);
       from_memory : in std_logic_vector(word_width downto 0);
       CCR_Result : out std_logic_vector(3 downto 0);
       IR  : out std_logic_vector(word_width downto 0);
       address, to_memory : out std_logic_vector(word_width downto 0));
end entity;

architecture data_path_arch of data_path is

  component multiplexer_3t1 is
      port(one, two, three : in std_logic_vector(word_width downto 0);
           sel  : in std_logic_vector(1 downto 0);
           output  : out std_logic_vector(word_width downto 0));
  end component;

  component alu is
    port (ALU_Sel : in  std_logic_vector(2 downto 0);
          A       : in  std_logic_vector(word_width downto 0);
          B       : in  std_logic_vector(word_width downto 0);
          NZVC    : out std_logic_vector(3  downto 0);
          Result  : out std_logic_vector(word_width downto 0));

  end component;

  signal bus1, bus2 : std_logic_vector(word_width downto 0);
  -- TODO: This thing needs a real name:
  signal ALU_result : std_logic_vector(word_width downto 0);
  signal NZVC       : std_logic_vector(3 downto 0);
  -- The registers:
  signal PC, A, B, MAR   : std_logic_vector(word_width downto 0);
  signal PC_uns : unsigned(word_width downto 0);

begin

  ARITM_UNIT : alu port map(ALU_Sel => ALU_Sel,
                     -- TODO: give this ALU_a_in, ALU_b_in real input names. See above
                     A       => A,
                     B       => B,
                     NZVC    => NZVC,
                     Result  => ALU_result);

  BUS1_multi : multiplexer_3t1 port map(one => PC,
                                        -- TODO: A, B correct?
                                        two => A, three => B,
                                        sel     => Bus1_Sel,
                                        output  => bus1);

  BUS2_multi : multiplexer_3t1 port map(one => ALU_result,
                                        -- TODO: A, B correct?
                                        two => bus1,
                                        three => from_memory,
                                        sel     => Bus2_Sel,
                                        output  => bus2);
end architecture;
