library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all; use IEEE.STD_LOGIC_ARITH.all;

entity imem is -- instruction memory
	port (a: in STD_LOGIC_VECTOR (5 downto 0);
			rd: out STD_LOGIC_VECTOR (31 downto 0));
end;

architecture behave of imem is
begin
	process(a)
		file mem_file: TEXT;
		variable L: line;
		variable ch: character;
		variable index, result: integer;
		type ramtype is array (63 downto 0) of STD_LOGIC_VECTOR(31 downto 0);
		variable mem: ramtype;
	begin
	-- initialize memory 
		for i in 0 to 63 loop 
			mem(conv_integer(i)) := CONV_STD_LOGIC_VECTOR (0, 32);
		end loop;
		mem(0) := X"20020005";
		mem(1) := X"2003000c";
		mem(2) := X"2067fff7";
		mem(3) := X"00e22025";
		mem(4) := X"00642824";
		mem(5) := X"00a42820";
		mem(6) := X"10a7000a";
		mem(7) := X"0064202a";
		mem(8) := X"10800001";
		mem(9) := X"20050000";
		mem(10) := X"00e2202a";
		mem(11) := X"00853820";
		mem(12) := X"00e23822";
		mem(13) := X"ac670044";
		mem(14) := X"8c020050";
		mem(15) := X"08000011";
		mem(16) := X"20020001";
		mem(17) := X"ac020054";
		
	-- read memory
		rd <= mem(CONV_INTEGER(a));
end process;
end;