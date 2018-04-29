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

        mem( 0) := X"20040006";
        mem( 1) := X"0c100003";
        mem( 2) := X"08100016";
        mem( 3) := X"20880000";
        mem( 4) := X"2109FFFE";
        mem( 5) := X"200B0001";
        mem( 6) := X"210D0000";
        mem( 7) := X"200E0000";
        mem( 8) := X"212C0000";
        mem( 9) := X"012B502A";
        mem(10) := X"20010001";
        mem(11) := X"102A0008";
        mem(12) := X"018B702B";
        mem(13) := X"11CB0003";
		mem(14) := X"01A84020";
        mem(15) := X"218CFFFF";
        mem(16) := X"0810000C";
        mem(17) := X"210D0000";
        mem(18) := X"2129FFFF";
        mem(19) := X"08100008";
        mem(20) := X"21020000";
        mem(21) := X"03E00008";
        mem(22) := X"31CE0001";
        mem(23) := X"35CE0000";
        mem(24) := X"000E7400"; -- sll
        mem(25) := X"3C0F0001";
        mem(26) := X"11CF0002"; -- last 3 to 2
        mem(27) := X"AC020010"; -- sw
		mem(28) := X"08100020";
		mem(29) := X"AC2E0010"; -- SW

	-- read memory
		rd <= mem(CONV_INTEGER(a));
end process;
end;
