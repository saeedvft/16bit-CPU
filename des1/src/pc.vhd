library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
    Port (
        clk_in : in STD_LOGIC;
        pc_op_in : in std_logic_vector(1 downto 0);
        pc_in : in std_logic_vector(15 downto 0);
		pc_out : out std_logic_vector(15 downto 0)	
    );
end pc;


architecture Behavioral of pc is
    signal pc: STD_LOGIC_VECTOR(15 downto 0) := x"0000";
begin
    process (clk_in)
    begin
        if rising_edge(clk_in) then
            case pc_op_in is
                when "00" => -- reset
                    pc <= o"0000" & x"0";
                when "01" => -- increment
                    pc <= STD_LOGIC_VECTOR(unsigned(pc) + 1);
                when "10" => -- branch
                    pc <= pc_in;
                when "11" => -- NOP
                when others =>
            end case;
        end if;
    end process;
    
    pc_out <= pc;

end Behavioral;

--architecture Behavioral of pc is
--	signal pc : std_logic_vector(15 downto 0) := x"0000";
--begin
--    process (clk_in)
--    begin
--        if rising_edge(clk_in) then
--			if pc_op_in = "00" then
--				pc <= o"0000" & x"0";
--			else pc_op_in = "01" then
--				pc <= pc_in + 1;
--			else pc_op_in = "10" then
--				pc <= pc_in;
--			--else pc_op_in = 11 then
--			end if;
--		end if;
--    end process;
--end Behavioral;
