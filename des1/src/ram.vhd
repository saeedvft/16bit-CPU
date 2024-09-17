library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL;


entity ram is
    Port ( clk_in : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable_in : in STD_LOGIC;
           write_enable_in : in STD_LOGIC;
           address_in : in STD_LOGIC_VECTOR (15 downto 0);
           data_in : in STD_LOGIC_VECTOR (15 downto 0);
           data_out : out STD_LOGIC_VECTOR (15 downto 0));
end ram;												    

architecture Behavioral of ram is
    type ram_array is array (0 to 255) of STD_LOGIC_VECTOR (15 downto 0);  --512B memory	
    signal ram: ram_array := (
        '0' & "1011" & "000" & x"0A", -- imm r0 = 0x000A (580A)                                                     
        '0' & "1011" & "001" & x"AA", -- imm r1 = 0x00AA (59AA)                                                     
        '0' & "0010" & "000" & "000" & "00000", -- not r0 (1000)                                                    
        '0' & "0000" & "010" & "001" & "000" & "00", -- (unsigned) ADD r2 r1 r0, r2 = xFF5F (0220)                  
        '0' & "1011" & "011" & x"08", -- imm r3 = 0x08  (5B08)
		x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)
		'0' & "0011" & "010" & "011" & "001" & "00", --AND r2 r3 r1, r2 = x08 (1A64)                                
        '0' & "0100" & "011" & "010" & "001" & "00", -- OR r3 r2 r1, r3 = 0x14 (2344)                               
        '0' & "0101" & "100" & "011" & "011" & "00", -- XOR r4 r3 r3, r4 = 0x00  (2C6C)
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)
		'1' & "1101" & "000" & x"0B", -- Branch to ram address 13 (E80B)
        '0' & "0110" & "010" & "010" & "011" & "00", -- LSL r2 by r3, r2 = x5F00  (324C)
		x"0000", -- NOP (0000)                                                                                      
        x"0000", -- NOP (0000)
        '0' & "1011" & "100" & x"04", -- imm r4 = 0x04       (5C04)                                                 
        '0' & "0111" & "010" & "010" & "100" & "00", -- LSR r2 by r4, r2 = x05F0 (3A50)                                               
        x"0000", -- NOP (0000)                                                                                      
        x"0000", -- NOP (0000)                                                                                      
        '0' & "0001" & "101" & "010" & "011" & "00", -- (unsigned) SUB r5 r2 r3, r5 = x05E8 (0D4C)                  
        '0' & "1011" & "110" & x"FF", -- imm r6 = 0xFF       (5EFF)                                                 
        '0' & "1101" & "000" & "110" & "101" & "00", -- ST r5 (rM) data at r6 (rN) address (x05E8 at xFF) (68D4)    
        '0' & "1100" & "111" & "110" & "00000", -- LD r6 address into r7, r7 = x05E8 (67c0)                         
        '0' & "1000" & "000" & "101" & "111" & "00", --unsigned CMP r0 r5 r7, r0 = x"4000" (40BC)                   
        '0' & "1011" & "001" & x"18", -- imm r1 = 0x18       (5918)                                                 
        '0' & "1010" & "000" & "001" & "000" & "00",  -- BEQ r1 r0 .. r1 = addr, r0 = out from cmp (5020)           
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)                                                                                      
        x"0000", -- nop (0000)                              
                
        others => x"0000"
    );
    
begin
    process(clk_in)
    begin
        if rising_edge(clk_in) then
            if(write_enable_in = '1') then
                ram(to_integer(unsigned(address_in(7 downto 0)))) <= data_in; -- 2^8 = 256
            else
                data_out <= ram(to_integer(unsigned(address_in(7 downto 0))));
            end if;
        end if;
     end process;

end Behavioral;