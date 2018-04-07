library IEEE;
library STD;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use STD.env.all;

use WORK.cpu_constants.all;

entity test_memory is
end entity;

architecture test_memory_arch of test_memory is
  component memory is
    -- assignment specifications say that this cannot be an array:
    port(clock, reset, w_bit : in std_logic;
         address, data_in    : in std_logic_vector(word_width downto 0);
         ports_in            : in io_array;
         data_out            : out std_logic_vector(word_width downto 0);
         ports_out           : out io_array);
  end component;

  constant t_clk_per : time := 20 ns;

  signal clock_TB, reset_TB, w_bit_TB : std_logic;
  signal address_tb, data_in_tb : std_logic_vector(word_width downto 0) := x"00";
  signal ports_in_tb            : io_array;
  signal data_out_tb            : std_logic_vector(word_width downto 0) := x"00";
  signal ports_out_tb           : io_array;
begin
  DUT : memory port map (clock => clock_tb,
                         reset => reset_tb,
                         w_bit => w_bit_tb,
                         address => address_tb,
                         data_in => data_in_tb,
                         ports_in => ports_in_tb,
                         data_out => data_out_tb,
                         ports_out => ports_out_tb);

  RESET : process
  begin
    reset_TB <= '1';
    wait for t_clk_per/4;
    reset_TB <= '0';
    wait;
  end process;

  CLOCK_DRIVER : process
  begin
    clock_TB <= '0';
    wait for t_clk_per/2;
    clock_TB <= '1';
    wait for t_clk_per/2;
  end process;

  TEST : process
    variable vec_addr  : std_logic_vector(word_width downto 0);
  begin
    wait for t_clk_per/2;
    -- first test: make sure there are no out of bounds,
    w_bit_TB <= '0';
    report "Testing ranges...";
    for I in 0 to 255 loop
      address_tb <= std_logic_vector(to_unsigned(I, address_tb'length));
      wait for t_clk_per;
    end loop;

    -- see if we can set and acess all values in the rw array:
    report "Testing setting values...";
    w_bit_tb <= '1';
    for I in  128 to 128 + 95 loop
      address_tb <= std_logic_vector(to_unsigned(I, address_tb'length));
      data_in_tb <= std_logic_vector(to_unsigned(I, address_tb'length));
      wait for t_clk_per;
    end loop;
    w_bit_TB <= '0';
    for I in 128 to 128 + 95 loop
      address_tb <= std_logic_vector(to_unsigned(I, address_tb'length));
      wait for t_clk_per;
      assert data_out_tb = std_logic_vector(to_unsigned(I, address_tb'length)) report "Did not store correctly" severity failure;
    end loop;

    report "Testing output ports...";
    -- test if we can set the value of output ports correctly:
    for I in 224 to 224 + 15 loop
      address_tb <= std_logic_vector(to_unsigned(I, address_tb'length));
      wait for t_clk_per;
      assert data_out_tb = x"00" report "Output ports not zeroed correctly" severity failure;
    end loop;

    stop(0);
  end process;
end architecture;
