library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Decoder4_16 is
	port(I0,I1,I2,I3:in std_logic;
		 Output:out std_logic_vector(15 downto 0));
end Decoder4_16;


architecture arch_Decoder4_16 of Decoder4_16 is
begin
Output<="0000000000000001" when I0='0' and  I1='0' and I2='0' and I3='0' else
		"0000000000000010" when I0='1' and  I1='0' and I2='0' and I3='0' else
		"0000000000000100" when I0='0' and  I1='1' and I2='0' and I3='0' else
		"0000000000001000" when I0='1' and  I1='1' and I2='0' and I3='0' else
		"0000000000010000" when I0='0' and  I1='0' and I2='1' and I3='0' else
		"0000000000100000" when I0='1' and  I1='0' and I2='1' and I3='0' else
		"0000000001000000" when I0='0' and  I1='1' and I2='1' and I3='0' else
		"0000000010000000" when I0='1' and  I1='1' and I2='1' and I3='0' else
		"0000000100000000" when I0='0' and  I1='0' and I2='0' and I3='1' else
		"0000001000000000" when I0='1' and  I1='0' and I2='0' and I3='1' else
		"0000010000000000" when I0='0' and  I1='1' and I2='0' and I3='1' else
		"0000100000000000" when I0='1' and  I1='1' and I2='0' and I3='1' else
		"0001000000000000" when I0='0' and  I1='0' and I2='1' and I3='1' else
		"0010000000000000" when I0='1' and  I1='0' and I2='1' and I3='1' else
		"0100000000000000" when I0='0' and  I1='1' and I2='1' and I3='1' else
		"1000000000000000" when I0='1' and  I1='1' and I2='1' and I3='1' ;
	

end arch_Decoder4_16;