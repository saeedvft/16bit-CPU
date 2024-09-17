library ieee;
use ieee.STD_LOGIC_UNSIGNED.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

	-- Add your library and packages declaration here ...

entity decoder_tb is
end decoder_tb;

architecture TB_ARCHITECTURE of decoder_tb is
	-- Component declaration of the tested unit
	component decoder
	port(
		clk_in : in STD_LOGIC;
		enable_in : in STD_LOGIC;
		instruction_in : in STD_LOGIC_VECTOR(15 downto 0);
		alu_op_out : out STD_LOGIC_VECTOR(4 downto 0);
		imm_data_out : out STD_LOGIC_VECTOR(7 downto 0);
		write_enable_out : out STD_LOGIC;
		sel_rM_out : out STD_LOGIC_VECTOR(2 downto 0);
		sel_rN_out : out STD_LOGIC_VECTOR(2 downto 0);
		sel_rD_out : out STD_LOGIC_VECTOR(2 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal clk_in : STD_LOGIC;
	signal enable_in : STD_LOGIC;
	signal instruction_in : STD_LOGIC_VECTOR(15 downto 0);
	-- Observed signals - signals mapped to the output ports of tested entity
	signal alu_op_out : STD_LOGIC_VECTOR(4 downto 0);
	signal imm_data_out : STD_LOGIC_VECTOR(7 downto 0);
	signal write_enable_out : STD_LOGIC;
	signal sel_rM_out : STD_LOGIC_VECTOR(2 downto 0);
	signal sel_rN_out : STD_LOGIC_VECTOR(2 downto 0);
	signal sel_rD_out : STD_LOGIC_VECTOR(2 downto 0);

	constant clk_period : time := 10 ns;

begin

	-- Unit Under Test port map
	UUT : decoder
		port map (
			clk_in => clk_in,
			enable_in => enable_in,
			instruction_in => instruction_in,
			alu_op_out => alu_op_out,
			imm_data_out => imm_data_out,
			write_enable_out => write_enable_out,
			sel_rM_out => sel_rM_out,
			sel_rN_out => sel_rN_out,
			sel_rD_out => sel_rD_out
		);

	clk_process :process
    begin
        clk_in <= '0';
        wait for clk_period/2;
        clk_in <= '1';
        wait for clk_period/2;
    end process;
	
	stim_proc: process
    begin
		-- Initialize Inputs
        enable_in <= '0';
        instruction_in <= (others => '0');
        wait for clk_period;

        -- Test 1: ADD instruction
        enable_in <= '1';
        instruction_in <= "0000001011100011";  -- Opcode 00000 (ADD), sel_rD=010, sel_rM=111, sel_rN=000
        wait for clk_period;

        assert alu_op_out = "00000" report "Test 1 failed: alu_op_out mismatch" severity error;
        assert write_enable_out = '1' report "Test 1 failed: write_enable_out mismatch" severity error;
        assert sel_rD_out = "010" report "Test 1 failed: sel_rD_out mismatch" severity error;
        assert sel_rM_out = "111" report "Test 1 failed: sel_rM_out mismatch" severity error;
        assert sel_rN_out = "000" report "Test 1 failed: sel_rN_out mismatch" severity error;
        
        -- Test 2: NOT instruction
        instruction_in <= "0010001010000100";  -- Opcode 00100 (NOT), sel_rD=010, sel_rN=100
        wait for clk_period;

        assert alu_op_out = "00100" report "Test 2 failed: alu_op_out mismatch" severity error;
        assert write_enable_out = '1' report "Test 2 failed: write_enable_out mismatch" severity error;
        assert sel_rD_out = "010" report "Test 2 failed: sel_rD_out mismatch" severity error;
        assert sel_rN_out = "100" report "Test 2 failed: sel_rN_out mismatch" severity error;
        
        -- Test 3: LSL instruction
        instruction_in <= "0110010010010011";  -- Opcode 01100 (LSL), sel_rD=001, sel_rM=001, imm_data_out=100011
        wait for clk_period;

        assert alu_op_out = "01100" report "Test 3 failed: alu_op_out mismatch" severity error;
        assert write_enable_out = '1' report "Test 3 failed: write_enable_out mismatch" severity error;
        assert sel_rD_out = "001" report "Test 3 failed: sel_rD_out mismatch" severity error;
        assert sel_rM_out = "001" report "Test 3 failed: sel_rM_out mismatch" severity error;
        assert imm_data_out = "00100011" report "Test 3 failed: imm_data_out mismatch" severity error;

        -- Test 4: BEQ instruction
        instruction_in <= "1001000001110000";  -- Opcode 10010 (BEQ), imm_data_out=01110000
        wait for clk_period;

        assert alu_op_out = "10010" report "Test 4 failed: alu_op_out mismatch" severity error;
        assert write_enable_out = '0' report "Test 4 failed: write_enable_out mismatch" severity error;
        assert imm_data_out = "01110000" report "Test 4 failed: imm_data_out mismatch" severity error;
        
        -- Test 5: Immediate instruction
        instruction_in <= "1011010010111010";  -- Opcode 10110 (Immediate), sel_rD=001, imm_data_out=10111010
        wait for clk_period;

        assert alu_op_out = "10110" report "Test 5 failed: alu_op_out mismatch" severity error;
        assert write_enable_out = '1' report "Test 5 failed: write_enable_out mismatch" severity error;
        assert sel_rD_out = "001" report "Test 5 failed: sel_rD_out mismatch" severity error;
        assert imm_data_out = "10111010" report "Test 5 failed: imm_data_out mismatch" severity error;
        
        -- Test 6: LD instruction
        instruction_in <= "1100001110010101";  -- Opcode 11000 (LD), sel_rD=011, sel_rN=101
        wait for clk_period;

        assert alu_op_out = "11000" report "Test 6 failed: alu_op_out mismatch" severity error;
        assert write_enable_out = '1' report "Test 6 failed: write_enable_out mismatch" severity error;
        assert sel_rD_out = "011" report "Test 6 failed: sel_rD_out mismatch" severity error;
        assert sel_rN_out = "101" report "Test 6 failed: sel_rN_out mismatch" severity error;

        -- End of test
	end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_decoder of decoder_tb is
	for TB_ARCHITECTURE
		for UUT : decoder
			use entity work.decoder(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_decoder;

