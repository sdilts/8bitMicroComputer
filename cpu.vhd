library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use WORK.cpu_constants.all;

entity cpu is
  port (Clock       : in std_logic;
        reset       : in std_logic;
        from_memory : in std_logic_vector(word_width downto 0);
        address   : out std_logic_vector(word_width downto 0);
        w_bit     : out std_logic;
        to_memory : out std_logic_vector(word_width downto 0));
end entity;

architecture cpu_arch of cpu is

  component data_path is
    port(IR_Load, MAR_Load, PC_Load, PC_inc, A_Load, B_Load, CCR_Load,
         Bus2_Sel, Bus1_Sel : in std_logic;
         ALU_Sel : in std_logic_vector(2 downto 0);
         from_memory : in std_logic_vector(word_width downto 0);
         CCR_Result : out std_logic_vector(3 downto 0);
         IR  : out std_logic;
         address, to_memory : out std_logic_vector(word_width downto 0));
  end component;

  component control_unit is
    port (Clock       : in std_logic;
          reset       : in std_logic;
          IR  : in std_logic;
          CCR_Result : in std_logic_vector(3 downto 0);
          IR_Load, MAR_Load, PC_Load, PC_inc, A_Load, B_Load, CCR_Load,
          Bus2_Sel, Bus1_Sel : out std_logic;
          ALU_Sel : out std_logic_vector(2 downto 0);
          w_bit         : out std_logic);
  end component;

  -- signals that go out of CONTROL:
  signal IR_Load, MAR_Load, PC_Load, PC_inc, A_Load, B_Load, CCR_Load, Bus2_Sel, Bus1_Sel : std_logic;
  signal ALU_Sel : std_logic_vector(2 downto 0);
  -- signals that go into CONTROL:
  signal IR : std_logic;
  signal CCR_Result : std_logic_vector(3 downto 0);

begin

  CONTROL : control_unit port map (Clock  => clock,
                                   reset  => reset,
                                   IR => IR, CCR_Result => CCR_Result,
                                   IR_Load => IR_Load, MAR_Load => MAR_Load,
                                   PC_Load => PC_Load, PC_inc => PC_inc,
                                   A_Load => A_Load, B_Load => B_Load,
                                   ALU_Sel => ALU_Sel, CCR_Load => CCR_Load,
                                   Bus2_Sel => Bus2_Sel,
                                   Bus1_Sel => Bus1_Sel,
                                   w_bit    => w_bit);

  DATA : data_path port map(IR_Load => IR_Load, MAR_Load => MAR_Load,
                            PC_Load => PC_Load, PC_inc => PC_inc,
                            A_Load => A_Load, B_Load => B_Load,
                            ALU_Sel => ALU_Sel, CCR_Load => CCR_Load,
                            Bus2_Sel => Bus2_Sel, Bus1_Sel => Bus1_Sel,
                            from_memory => from_memory,
                            IR => IR, CCR_Result => CCR_Result,
                            address => address,
                            to_memory => to_memory);

end architecture;
