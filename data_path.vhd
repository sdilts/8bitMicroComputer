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

  -- BUS1_multi : multiplexer_3t1 port map(one => PC,
  --                                       -- TODO: A, B correct?
  --                                       two => A, three => B,
  --                                       sel     => Bus1_Sel,
  --                                       output  => bus1);

  -- BUS2_multi : multiplexer_3t1 port map(one => ALU_result,
  --                                       two => bus1,
  --                                       three => from_memory,
  --                                       sel     => Bus2_Sel,
  --                                       output  => bus2);


  MUX_BUS1 : process (Bus1_Sel, PC, A, B)
  begin
    case (Bus1_Sel) is
      when "00" => Bus1 <= PC;
      when "01" => Bus1 <= A;
      when "10" => Bus1 <= B;
      when others => Bus1 <= x"00";
    end case;
  end process;

  MUX_BUS2 : process (Bus2_Sel, ALU_Result, Bus1, from_memory)
  begin
    case (Bus2_Sel) is
      when "00" => Bus2 <= ALU_Result;
      when "01" => Bus2 <= Bus1;
      when "10" => Bus2 <= from_memory;
      when others => Bus2 <= x"00";
    end case;
  end process;

  address <= MAR;
  to_memory <= bus1;

  INSTRUCTION_REGISTER: process(clock, reset)
  begin
    if reset = '0' then
      IR <= x"00";
    elsif rising_edge(clock) then
      if IR_Load = '1' then
        IR <= bus2;
      end if;
    end if;
  end process;

  MEM_ADDR_REGISTER : process(clock, reset)
  begin
    if reset = '0' then
      MAR <= x"00";
    elsif rising_edge(clock) then
      if MAR_Load = '1' then
        MAR <= bus2;
      end if;
    end if;
  end process;

  PROGRAM_COUNTER : process(Clock, Reset)
  begin
    if reset = '0' then
      PC_uns <= x"00";
    elsif rising_edge(clock) then
      if PC_Load = '1' then
        PC_uns <= unsigned(bus2);
      elsif PC_inc = '1' then
        PC_uns <= PC_uns + 1;
      end if;
    end if;
  end process;

  PC <= std_logic_vector(PC_uns);

  A_REGISTER : process(clock, reset)
  begin
    if reset  = '0' then
      A <= x"00";
    elsif rising_edge(clock) then
      if A_Load = '1' then
        A <= bus2;
      end if;
    end if;
  end process;

  B_REGISTER : process(clock, reset)
  begin
    if reset = '0' then
      B <= x"00";
    elsif rising_edge(clock) then
      if B_Load = '1' then
        B <= bus2;
      end if;
    end if;
  end process;

  CONDITION_CODE_REGISTER : process(clock, reset)
  begin
    if reset = '0' then
      CCR_Result <= x"0";
    elsif rising_edge(clock) then
      if CCR_Load = '1' then
        CCR_Result <= NZVC;
      end if;
    end if;
  end process;
end architecture;
