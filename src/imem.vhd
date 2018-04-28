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
		-- mem(0) := X"20020005";
		-- mem(1) := X"2003000c";
		-- mem(2) := X"2067fff7";
		-- mem(3) := X"00e22025";
		-- mem(4) := X"00642824";
		-- mem(5) := X"00a42820";
		-- mem(6) := X"10a7000a";
		-- mem(7) := X"0064202a";
		-- mem(8) := X"10800001";
		-- mem(9) := X"20050000";
		-- mem(10) := X"00e2202a";
		-- mem(11) := X"00853820";
		-- mem(12) := X"00e23822";
		-- mem(13) := X"ac670044";
		-- mem(14) := X"8c020050";
		-- mem(15) := X"08000011";
		-- mem(16) := X"20020001";
		-- mem(17) := X"ac020054";

        mem( 0) := X"20040006";
        mem( 1) := X"0c100003";
        mem( 2) := X"0810001d";
        mem( 3) := X"20880000";
        mem( 4) := X"20090002";
        mem( 5) := X"210afffe";
        mem( 6) := X"200b0000";
        mem( 7) := X"200c0001";
        mem( 8) := X"210e0000";
        mem( 9) := X"200f0000";
        mem(10) := X"214d0000";
        mem(11) := X"014c582a";
        mem(12) := X"000b5840";
        mem(13) := X"20010002";
        mem(14) := X"102b000c";
        mem(15) := X"01ac782b";
        mem(16) := X"31ef0001";
        mem(17) := X"35ef0000";
        mem(18) := X"000f7c00";
        mem(19) := X"3c180001";
        mem(20) := X"11f80003";
        mem(21) := X"01c84020";
        mem(22) := X"21adffff";
        mem(23) := X"0810000f";
        mem(24) := X"210e0000";
        mem(25) := X"214affff";
        mem(26) := X"0810000a";
        mem(27) := X"21020000";
        mem(28) := X"03e00008";
        mem(29) := X"3c01ffff";
        mem(30) := X"ac220010";


        -- mem(0) := X"24040006";
        -- mem(1) := X"0c100004";
        -- mem(2) := X"2402000a";
        -- mem(3) := X"0000000c";
        -- mem(4) := X"20880000";
        -- mem(5) := X"20090002";
        -- mem(6) := X"210afffe";
        -- mem(7) := X"200b0000";
        -- mem(8) := X"200c0001";
        -- mem(9) := X"210e0000";
        -- mem(10) := X"200f0000";
        -- mem(11) := X"214d0000";
        -- mem(12) := X"014c582a";
        -- mem(13) := X"000b5840";
        -- mem(14) := X"20010002";
        -- mem(15) := X"102b000c";
        -- mem(16) := X"01ac782b";
        -- mem(17) := X"31ef0001";
        -- mem(18) := X"35ef0000";
        -- mem(19) := X"000f7c00";
        -- mem(20) := X"3c180001";
        -- mem(21) := X"11f80003";
        -- mem(22) := X"01c84020";
        -- mem(23) := X"21adffff";
        -- mem(24) := X"08100010";
        -- mem(25) := X"210e0000";
        -- mem(26) := X"214affff";
        -- mem(27) := X"0810000b";
        -- mem(28) := X"3c01ffff";
        -- mem(29) := X"ac280010";

	-- read memory
		rd <= mem(CONV_INTEGER(a));
end process;
end;
