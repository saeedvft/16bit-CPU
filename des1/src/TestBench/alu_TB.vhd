library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity alu_tb is
end alu_tb;

architecture TB_ARCHITECTURE of alu_tb is
	-- Component declaration of the tested unit
	component alu
	port(
		clk_in : in STD_LOGIC;
		enable_in : in STD_LOGIC;
		alu_op_in : in STD_LOGIC_VECTOR(4 downto 0);
		pc_in : in STD_LOGIC_VECTOR(15 downto 0);
		rM_data_in : in STD_LOGIC_VECTOR(15 downto 0);
		rN_data_in : in STD_LOGIC_VECTOR(15 downto 0);
		imm_data_in : in STD_LOGIC_VECTOR(7 downto 0);
		rD_write_enable_in : in STD_LOGIC;
		result_out : out STD_LOGIC_VECTOR(15 downto 0);
		branch_out : out STD_LOGIC;
		rD_write_enable_out : out STD_LOGIC );
	end component;
	
	signal clk_in : STD_LOGIC;
	signal enable_in : STD_LOGIC;
	signal alu_op_in : STD_LOGIC_VECTOR(4 downto 0);
	signal pc_in : STD_LOGIC_VECTOR(15 downto 0);
	signal rM_data_in : STD_LOGIC_VECTOR(15 downto 0);
	signal rN_data_in : STD_LOGIC_VECTOR(15 downto 0);
	signal imm_data_in : STD_LOGIC_VECTOR(7 downto 0);
	signal rD_write_enable_in : STD_LOGIC;								 
	signal result_out : STD_LOGIC_VECTOR(15 downto 0);
	signal branch_out : STD_LOGIC;
	signal rD_write_enable_out : STD_LOGIC;
							   
    constant clk_period : time := 10 ns;
	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : alu
		port map (
			clk_in => clk_in,
			enable_in => enable_in,
			alu_op_in => alu_op_in,
			pc_in => pc_in,
			rM_data_in => rM_data_in,
			rN_data_in => rN_data_in,
			imm_data_in => imm_data_in,
			rD_write_enable_in => rD_write_enable_in,
			result_out => result_out,
			branch_out => branch_out,
			rD_write_enable_out => rD_write_enable_out
		);

	-- Add your stimulus here ...
	
	-- Clock process definitions
    clk_process : process
    begin
        while True loop
            clk_in <= '0';
            wait for clk_period/2;
            clk_in <= '1';
            wait for clk_period/2;
        end loop;
    end process;
	
	stim_proc: process
    begin
        -- Initialize Inputs
        enable_in <= '1';
        alu_op_in <= "00000";  -- ADD operation
        pc_in <= (others => '0');
        rM_data_in <= "0000000000000001";  -- rM = 1
        rN_data_in <= "0000000000000010";  -- rN = 2
        imm_data_in <= (others => '0');
        rD_write_enable_in <= '1';
        -- Finish simulation
		wait for clk_period*4;
		alu_op_in <= "00010";  -- NOT operation
        pc_in <= (others => '0');
        rM_data_in <= "0000000000000010";  -- rM = 2
        rN_data_in <= (others => '0');
        imm_data_in <= (others => '0');
        rD_write_enable_in <= '1'; 
        wait;
    end process;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_alu of alu_tb is
	for TB_ARCHITECTURE
		for UUT : alu
			use entity work.alu(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_alu;

