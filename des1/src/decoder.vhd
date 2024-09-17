library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder is
    Port (
        clk_in : in STD_LOGIC;
        enable_in : in STD_LOGIC;
        instruction_in : in std_logic_vector(15 downto 0);
        alu_op_out : out std_logic_vector(4 downto 0);
        imm_data_out : out std_logic_vector(7 downto 0);
        write_enable_out : out STD_LOGIC;
        sel_rM_out : out std_logic_vector(2 downto 0);
        sel_rN_out : out std_logic_vector(2 downto 0);
        sel_rD_out : out std_logic_vector(2 downto 0)
    );
end decoder;

architecture Behavioral of decoder is
begin
    process (clk_in)
    begin
        if rising_edge(clk_in) then
            if enable_in = '1' then
                -- Extracting the opcode (bits 15 to 11)
                alu_op_out <= instruction_in(15 downto 11);
                
                -- Default values
                write_enable_out <= '0';
                imm_data_out <= (others => '0');
                sel_rM_out <= (others => '0');
                sel_rN_out <= (others => '0');
                sel_rD_out <= (others => '0');

                case instruction_in(14 downto 11) is
                    when "0000" | "0001" | "0011" | "0100" | "0101" | "1000" => -- ADD/SUB/AND/OR/XOR/CMP -> RRR
						write_enable_out <= '1';	 
                        sel_rD_out <= instruction_in(10 downto 8);
                        sel_rM_out <= instruction_in(7 downto 5);
                        sel_rN_out <= instruction_in(4 downto 2);
                        
                    when "0010" | "1100" => -- NOT/LD -> RRU
						write_enable_out <= '1';  				   
                        sel_rD_out <= instruction_in(10 downto 8);
                        sel_rN_out <= instruction_in(4 downto 2);
						
                    when "0110" | "0111" => -- LSL/LSR -> RRI(5)
						write_enable_out <= '1';					
                        sel_rD_out <= instruction_in(10 downto 8);
                        sel_rM_out <= instruction_in(7 downto 5);
                        imm_data_out <= "00" & instruction_in(5 downto 0);  --check concat 
						
                    when "1001" => -- B -> UI(8)				  
                        imm_data_out <= instruction_in(7 downto 0);
                        
                    when "1010" | "1101" => -- BEQ/ST -> URR		
                        sel_rM_out <= instruction_in(7 downto 5);
                        sel_rN_out <= instruction_in(4 downto 2);
						write_enable_out <= '0';
                        
                    when "1011" => -- IMMEDIATE -> RI(8)
						write_enable_out <= '1'; 				   
                        sel_rD_out <= instruction_in(10 downto 8);
                        imm_data_out <= instruction_in(7 downto 0);
                        
                    when others =>
                        -- Do nothing for unrecognized instructions
                        null;
                end case;
            end if;
        end if;
    end process;
end Behavioral;
