library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

entity control_unit is
  port (Clock       : in std_logic;
        reset       : in std_logic;
        IR          : in std_logic;
        CCR_Result : in std_logic_vector(3 downto 0);
        IR_Load, MAR_Load, PC_Load, PC_inc, A_Load, B_Load, CCR_Load,
        Bus2_Sel, Bus1_Sel : out std_logic;
        ALU_Sel : out std_logic_vector(2 downto 0);
        w_bit         : out std_logic);
end entity;

architecture control_unit_arch of control_unit is

begin

end architecture;
