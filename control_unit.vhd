library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

use WORK.cpu_constants.all;

entity control_unit is
  port (Clock       : in std_logic;
        reset       : in std_logic;
        IR          : in std_logic_vector(word_width downto 0);
        CCR_Result : in std_logic_vector(3 downto 0);
        IR_Load, MAR_Load, PC_Load, PC_inc, A_Load, B_Load, CCR_Load : out std_logic;
        Bus2_Sel, Bus1_Sel : out std_logic_vector(1 downto 0);
        ALU_Sel : out std_logic_vector(2 downto 0);
        w_bit         : out std_logic);
end entity;

architecture control_unit_arch of control_unit is


  -- instructions to implement:
  -- branching:
  -- BCS?
  -- BVS?
  -- BMI?
  -- ALU instructions:
  -- AND_AB
  -- OR_AB
  -- INCA
  -- INCB
  -- DECA
  -- DECB
  type state_type is
    (S_FETCH_0, S_FETCH_1, S_FETCH_2,
     S_DECODE_3,
     S_LDA_IMM_4, S_LDA_IMM_5, S_LDA_IMM_6,
     S_LDA_DIR_4, S_LDA_DIR_5, S_LDA_DIR_6, S_LDA_DIR_7, S_LDA_DIR_8,
     S_STA_DIR_4, S_STA_DIR_5, S_STA_DIR_6, S_STA_DIR_7,

     S_LDB_IMM_4, S_LDB_IMM_5, S_LDB_IMM_6,
     S_LDB_DIR_4, S_LDB_DIR_5, S_LDB_DIR_6, S_LDB_DIR_7, S_LDB_DIR_8,
     S_STB_DIR_4, S_STB_DIR_5, S_STB_DIR_6, S_STB_DIR_7,

     S_ADD_AB_4,
     s_SUB_AB_4,
     -- branch always
     S_BRA_4, S_BRA_5, S_BRA_6,
     -- branch when result = 0
     S_BEQ_4, S_BEQ_5, S_BEQ_6, S_BEQ_7,
     -- branching is the same, it just depends on whether to start at 4 or 7:
     S_BRANCH_4, S_BRANCH_5, S_BRANCH_6, S_BRANCH_7);

  signal current_state : state_type := S_FETCH_0;
  signal next_state : state_type;
  signal PC : std_logic_vector(word_width downto 0);

begin

    OUTPUT_LOGIC : process(current_state)
    begin
    case(current_state) is
      when S_FETCH_0 => -- Put PC onto MAR to read Opcode
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU_Result, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_FETCH_1 => -- Increment PC
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_FETCH_2 =>
        IR_Load <= '1';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_DECODE_3 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_IMM_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_IMM_5 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_IMM_6 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '1';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_DIR_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '1';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_DIR_5 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_DIR_6 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_DIR_7 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDA_DIR_8 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '1';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_STA_DIR_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_STA_DIR_5 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        CCR_Load <= '0';
        w_bit <= '0';
        ALU_Sel <= "000";
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
      when S_STA_DIR_6 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        CCR_Load <= '0';
        w_bit <= '0';
        ALU_Sel <= "000";
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
      when S_STA_DIR_7 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        CCR_Load <= '0';
        w_bit <= '1';
        ALU_Sel <= "000";
        Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
      when S_LDB_IMM_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDB_IMM_5 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDB_IMM_6 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '1';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDB_DIR_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '1';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDB_DIR_5 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDB_DIR_6 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDB_DIR_7 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_LDB_DIR_8 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '1';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_STB_DIR_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_STB_DIR_5 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        CCR_Load <= '0';
        w_bit <= '0';
        ALU_Sel <= "000";
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
      when S_STB_DIR_6 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        CCR_Load <= '0';
        w_bit <= '0';
        ALU_Sel <= "000";
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
      when S_STB_DIR_7 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        CCR_Load <= '0';
        w_bit <= '1';
        ALU_Sel <= "000";
        Bus1_Sel <= "10"; -- "00"=PC, "01"=A, "10"=B
      when S_ADD_AB_4 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '1';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '1';
        Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_SUB_AB_4 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '1';
        B_Load <= '0';
        ALU_Sel <= "001";
        CCR_Load <= '1';
        Bus1_Sel <= "01"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BRA_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BRA_5 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BRA_6 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '1';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BEQ_4 =>
        IR_Load <= '0';
        MAR_Load <= '1';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "01"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BEQ_5 =>
        -- do nothing;
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BEQ_6 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '1';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BEQ_7 =>
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BRANCH_5 =>
        -- do nothing:
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BRANCH_6 =>
        -- Put from memory into PC
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '1';
        PC_Inc <= '0';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "10"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when S_BRANCH_7 =>
        -- Increment PC: don't branch
        IR_Load <= '0';
        MAR_Load <= '0';
        PC_Load <= '0';
        PC_Inc <= '1';
        A_Load <= '0';
        B_Load <= '0';
        ALU_Sel <= "000";
        CCR_Load <= '0';
        Bus1_Sel <= "00"; -- "00"=PC, "01"=A, "10"=B
        Bus2_Sel <= "00"; -- "00"=ALU, "01"=Bus1, "10"=from_memory
        w_bit <= '0';
      when others =>
        report "Shouldn't get here" severity failure;
    end case;
  end process;

  STATE_MEM : process(clock, reset)
  begin
    if reset = '0' then
      current_state <= S_FETCH_0;
    elsif rising_edge(clock) then
      current_state <= next_state;
    end if;
  end process;

  NEXT_STATE_LOGIC : process(current_state, IR, CCR_Result)
  begin
    if (current_state = S_FETCH_0) then
      next_state <= S_FETCH_1;
    elsif (current_state = S_FETCH_1) then
      next_state <= S_FETCH_2;
    elsif (current_state = S_FETCH_2) then
      next_state <= S_DECODE_3;
    elsif (current_state = S_DECODE_3) then
      -- select execution path
      -- A LOADS and STORES ---------------------------------
      if (IR = LDA_IMM) then
        -- Load A Immediate
        next_state <= S_LDA_IMM_4;
      elsif (IR = LDA_DIR) then
        -- Load A Direct
        next_state <= S_LDA_DIR_4;
      elsif (IR = STA_DIR) then
        -- Store A Direct
        next_state <= S_STA_DIR_4;
      -- B LOADS and STORES --------------------------------
      elsif (IR = LDB_IMM) then
        -- Load B Immediate
        next_state <= S_LDB_IMM_4;
      elsif (IR = LDB_DIR) then
        -- Load B Direct
        next_state <= S_LDB_DIR_4;
      elsif (IR = STB_DIR) then
        -- Store B Direct
        next_state <= S_STB_DIR_4;
      -- ALU instructions -----------------------------------
      elsif (IR = ADD_AB) then
        -- Add A and B
        next_state <= S_ADD_AB_4;
      elsif (IR = SUB_AB) then
        -- Add A and B
        next_state <= S_SUB_AB_4;
      -- Branching instructions -----------------------------
      elsif (IR = BRA) then
        -- Branch Always
        next_state <= S_BRA_4;
      elsif IR = BCS then
        if CCR_Result(3) = '1' then
          next_state <= S_BRANCH_4;
        else
          next_state <= S_BRANCH_7;
        end if;
      elsif (IR=BEQ and CCR_Result(2)='1') then
        -- BEQ and Z=1
        next_state <= S_BEQ_4;
      elsif (IR=BEQ and CCR_Result(2)='0') then
        -- BEQ and Z=0
        next_state <= S_BEQ_7;
      elsif IR = BVS then
        if CCR_Result(1) = '1' then
          next_state <= S_BRANCH_4;
        else
          next_state <= S_BRANCH_7;
        end if;
      elsif IR = BMI then
        if CCR_Result(0) = '1' then
          next_state <= S_BRANCH_4;
        else
          next_state <= S_BRANCH_7;
        end if;
      else
        next_state <= S_FETCH_0;
      end if;
    -- Branching states ------------------------------------
    elsif current_state = S_BRANCH_4 then
      next_state <= S_BRANCH_5;
    elsif current_state = S_BRANCH_5 then
      next_state <= S_BRANCH_6;
    elsif current_state = S_BRANCH_6 then
      next_state <= S_FETCH_0;
    elsif current_state = S_BRANCH_7 then
      next_state <= S_FETCH_0;
    -- LDA_IMM states ---------------------------------------
    elsif current_state = S_LDA_IMM_4 then
      next_state <= S_LDA_IMM_5;
    elsif current_state = S_LDA_IMM_5 then
      next_state <= S_LDA_IMM_6;
    elsif current_state = S_LDA_IMM_6 then
      next_state <= S_FETCH_0;
    -- LDA_DIR states ------------------------------------------------
    elsif current_state = S_LDA_DIR_4 then
      next_state <= S_LDA_DIR_5;
    elsif current_state = S_LDA_DIR_5 then
      next_state <= S_LDA_DIR_6;
    elsif current_state = S_LDA_DIR_6 then
      next_state <= S_LDA_DIR_7;
    elsif current_state = S_LDA_DIR_7 then
      next_state <= S_LDA_DIR_8;
    elsif current_state = S_LDA_DIR_8 then
      next_state <= S_FETCH_0;
    -- STA_DIR states --------------------------------------------
    elsif current_state = S_STA_DIR_4 then
      next_state <= S_STA_DIR_5;
    elsif current_state = S_STA_DIR_5 then
      next_state <= S_STA_DIR_6;
    elsif current_state = S_STA_DIR_6 then
      next_state <= S_STA_DIR_7;
    elsif current_state = S_STA_DIR_7 then
      next_state <= S_FETCH_0;
    -- LDB_IMM states ---------------------------------------
    elsif current_state = S_LDB_IMM_4 then
      next_state <= S_LDB_IMM_5;
    elsif current_state = S_LDB_IMM_5 then
      next_state <= S_LDB_IMM_6;
    elsif current_state = S_LDB_IMM_6 then
      next_state <= S_FETCH_0;
    -- LDB_DIR states ------------------------------------------------
    elsif current_state = S_LDB_DIR_4 then
      next_state <= S_LDB_DIR_5;
    elsif current_state = S_LDB_DIR_5 then
      next_state <= S_LDB_DIR_6;
    elsif current_state = S_LDB_DIR_6 then
      next_state <= S_LDB_DIR_7;
    elsif current_state = S_LDB_DIR_7 then
      next_state <= S_LDB_DIR_8;
    elsif current_state = S_LDB_DIR_8 then
      next_state <= S_FETCH_0;
    -- STB_DIR states --------------------------------------------
    elsif current_state = S_STB_DIR_4 then
      next_state <= S_STB_DIR_5;
    elsif current_state = S_STB_DIR_5 then
      next_state <= S_STB_DIR_6;
    elsif current_state = S_STB_DIR_6 then
      next_state <= S_STB_DIR_7;
    elsif current_state = S_STB_DIR_7 then
      next_state <= S_FETCH_0;
    -- ADD_AB states: ---------------------------------------
    elsif current_state = S_ADD_AB_4 then
      next_state <= S_FETCH_0;
    -- SUB_AB states:----------------------------------------
    elsif current_state = S_SUB_AB_4 then
      next_state <= S_FETCH_0;
    -- BRA instruction
    elsif current_state = S_BRA_4 then
      next_state <= S_BRA_5;
    elsif current_state = S_BRA_5 then
      next_state <= S_BRA_6;
    elsif current_state = S_BRA_6 then
      next_state <= S_FETCH_0;
    -- BEQ instruction
    elsif current_state = S_BEQ_4 then
      next_state <= S_BEQ_5;
    elsif current_state = S_BEQ_5 then
      next_state <= S_BEQ_6;
    elsif current_state = S_BEQ_6 then
      next_state <= S_FETCH_0;
    elsif current_state = S_BEQ_7 then
      next_state <= S_FETCH_0;
    else
      report "Shouldn't get to else in if statement" severity failure;
    end if;
  end process;


end architecture;
