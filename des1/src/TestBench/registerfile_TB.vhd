library ieee;
use ieee.NUMERIC_STD.all;
use ieee.std_logic_1164.all;

	-- Add your library and packages declaration here ...

entity registerfile_tb is
end registerfile_tb;

architecture TB_ARCHITECTURE of registerfile_tb is
	-- Component declaration of the tested unit
	component registerfile
	port(
		clk_in : in STD_LOGIC;
		enable_in : in STD_LOGIC;
		write_enable_in : in STD_LOGIC;
		rM_data_out : out STD_LOGIC_VECTOR(15 downto 0);
		rN_data_out : out STD_LOGIC_VECTOR(15 downto 0);
		rD_data_in : in STD_LOGIC_VECTOR(15 downto 0);
		sel_rM_in : in STD_LOGIC_VECTOR(2 downto 0);
		sel_rN_in : in STD_LOGIC_VECTOR(2 downto 0);
		sel_rD_in : in STD_LOGIC_VECTOR(2 downto 0) );
	end component;

	-- Testbench signals
    signal clk_in : STD_LOGIC := '0';
    signal enable_in : STD_LOGIC := '0';
    signal write_enable_in : STD_LOGIC := '0';
    signal rM_data_out : STD_LOGIC_VECTOR (15 downto 0);
    signal rN_data_out : STD_LOGIC_VECTOR (15 downto 0);
    signal rD_data_in : STD_LOGIC_VECTOR (15 downto 0);
    signal sel_rM_in : STD_LOGIC_VECTOR (2 downto 0);
    signal sel_rN_in : STD_LOGIC_VECTOR (2 downto 0);
    signal sel_rD_in : STD_LOGIC_VECTOR (2 downto 0);

    constant clk_period : time := 10 ns;

begin

	-- Unit Under Test port map
	UUT : registerfile
		port map (
			clk_in => clk_in,
			enable_in => enable_in,
			write_enable_in => write_enable_in,
			rM_data_out => rM_data_out,
			rN_data_out => rN_data_out,
			rD_data_in => rD_data_in,
			sel_rM_in => sel_rM_in,
			sel_rN_in => sel_rN_in,
			sel_rD_in => sel_rD_in
		);			 
		-- Clock process definitions
    clk_process :process
    begin
        clk_in <= '0';
        wait for clk_period/2;
        clk_in <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        enable_in <= '0';
        write_enable_in <= '0';
        rD_data_in <= (others => '0');
        sel_rM_in <= "000";
        sel_rN_in <= "000";
        sel_rD_in <= "000";
        wait for clk_period;

        -- Test 1: Write to register 0 and read it back
        enable_in <= '1';
        sel_rD_in <= "000";  -- Select register 0 for write
        rD_data_in <= x"1234"; -- Data to write
        write_enable_in <= '1';
        wait for clk_period;
        write_enable_in <= '0';
        
        sel_rM_in <= "000"; -- Select register 0 for read
        sel_rN_in <= "000"; -- Select register 0 for read
        wait for clk_period;
        
        assert rM_data_out = x"1234" report "Test 1 failed: rM_data_out mismatch" severity error;
        assert rN_data_out = x"1234" report "Test 1 failed: rN_data_out mismatch" severity error;

        -- Test 2: Write to register 1 and read it back
        sel_rD_in <= "001";  -- Select register 1 for write
        rD_data_in <= x"5678"; -- Data to write
        write_enable_in <= '1';
        wait for clk_period;
        write_enable_in <= '0';
        
        sel_rM_in <= "001"; -- Select register 1 for read
        sel_rN_in <= "001"; -- Select register 1 for read
        wait for clk_period;
        
        assert rM_data_out = x"5678" report "Test 2 failed: rM_data_out mismatch" severity error;
        assert rN_data_out = x"5678" report "Test 2 failed: rN_data_out mismatch" severity error;

        -- Test 3: Write to register 2 and read it back
        sel_rD_in <= "010";  -- Select register 2 for write
        rD_data_in <= x"9ABC"; -- Data to write
        write_enable_in <= '1';
        wait for clk_period;
        write_enable_in <= '0';
        
        sel_rM_in <= "010"; -- Select register 2 for read
        sel_rN_in <= "010"; -- Select register 2 for read
        wait for clk_period;
        
        assert rM_data_out = x"9ABC" report "Test 3 failed: rM_data_out mismatch" severity error;
        assert rN_data_out = x"9ABC" report "Test 3 failed: rN_data_out mismatch" severity error;

        -- Test 4: Ensure write is disabled when enable_in is '0'
        enable_in <= '0';
        sel_rD_in <= "011";  -- Select register 3 for write
        rD_data_in <= x"DEAD"; -- Data to write
        write_enable_in <= '1';
        wait for clk_period;
        write_enable_in <= '0';
        
        enable_in <= '1';
        sel_rM_in <= "011"; -- Select register 3 for read
        sel_rN_in <= "011"; -- Select register 3 for read
        wait for clk_period;
        
        assert rM_data_out = x"0000" report "Test 4 failed: rM_data_out mismatch" severity error;
        assert rN_data_out = x"0000" report "Test 4 failed: rN_data_out mismatch" severity error;

        -- End of test
		wait;
	end process;
	

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_registerfile of registerfile_tb is
	for TB_ARCHITECTURE
		for UUT : registerfile
			use entity work.registerfile(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_registerfile;

