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


        -- main:
        mem( 0) := X"20040006"; -- addi     $a0, $0, 6
        mem( 1) := X"0c100003"; -- jal      factorial
        mem( 2) := X"08100015"; -- j        end_prog

        -- factorial:
        mem( 3) := X"20880000"; -- addi     $t0, $a0, 0
        mem( 4) := X"2109FFFE"; -- addi     $t1, $t0, -2
        mem( 5) := X"200B0001"; -- addi	    $t3, $0, 1
        mem( 6) := X"210D0000"; -- addi	    $t5, $t0, 0

        -- outer_loop:
        mem( 7) := X"212C0000"; -- addi 	$t4, $t1, 0
        mem( 8) := X"012B502A"; -- slt      $t2, $t1, $t3
        mem( 9) := X"20010001"; -- addi     $at, $0, 0x00000001
        mem(10) := X"102A0008"; -- beq	    $at, $t2, end_fact

        -- inner_loop:
        mem(11) := X"018B702B"; -- sltu	    $t6, $t4, $t3
        mem(12) := X"11CB0003"; -- beq      $t6, $t3, not_first_fact
		mem(13) := X"01A84020"; -- add      $t0, $t5, $t0
        mem(14) := X"218CFFFF"; -- addi     $t4, $t4, -1
        mem(15) := X"0810000b"; -- j	    inner_loop

        -- not_first_fact:
        mem(16) := X"210D0000"; -- addi	    $t5, $t0, 0
        mem(17) := X"2129FFFF"; -- addi	    $t1, $t1, -1
        mem(18) := X"08100007"; -- j	    outer_loop

        -- end_fact:
        mem(19) := X"21020000"; -- addi	    $v0, $t0, 0
        mem(20) := X"03E00008"; -- jr	    $ra

        -- end_prog:
        mem(21) := X"31CE0001"; -- andi 	$t6, $0, 0
        mem(22) := X"35CE0000"; -- ori 	    $t6, 0
        mem(23) := X"000E7400"; -- sll	    $t6, $t6, 16
        mem(24) := X"3C0F0002"; -- lui      $t7, 2
        mem(25) := X"11CF0003"; -- beq	    $t6, $t7, erratum
		mem(26) := X"3C011001"; -- lui      $at, 0x00001001
        mem(27) := X"AC020010"; -- sw       $v0, 0x00000010($at)
		mem(28) := X"0810001f"; -- j        the_end

        -- erratum:
        mem(29) := X"3C011001"; -- lui      $at, 0x00001001
        mem(30) := X"AC0E0010"; -- sw       $t6, 0x00000010($at)

        -- the_end:
        mem(31) := X"00000000"; -- nop


        -- -- main:
        -- mem( 0) := X"20040006"; -- addi     $a0, $0, 6
        -- mem( 1) := X"0c100003"; -- jal      factorial
        -- mem( 2) := X"08100016"; -- j        end_prog
        --
        -- -- factorial:
        -- mem( 3) := X"20880000"; -- addi     $t0, $a0, 0
        -- mem( 4) := X"2109FFFE"; -- addi     $t1, $t0, -2
        -- mem( 5) := X"200B0001"; -- addi	    $t3, $0, 1
        -- mem( 6) := X"210D0000"; -- addi	    $t5, $t0, 0
        --
        -- -- outer_loop:
        -- mem( 7) := X"212C0000"; -- addi 	$t4, $t1, 0
        -- mem( 8) := X"012B502A"; -- slt      $t2, $t1, $t3
        -- mem( 9) := X"20010001"; -- addi     $at, $0, 0x00000001
        -- mem(10) := X"102A0008"; -- beq	    $at, $t2, end_fact
        --
        -- -- inner_loop:
        -- mem(11) := X"018B702B"; -- sltu	    $t6, $t4, $t3
        -- mem(12) := X"11CB0003"; -- beq      $t6, $t3, not_first_fact
		-- mem(13) := X"01A84020"; -- add      $t0, $t5, $t0
        -- mem(14) := X"218CFFFF"; -- addi     $t4, $t4, -1
        -- mem(15) := X"0810000C"; -- j	    inner_loop
        --
        -- -- not_first_fact:
        -- mem(16) := X"210D0000"; -- addi	    $t5, $t0, 0
        -- mem(17) := X"2129FFFF"; -- addi	    $t1, $t1, -1
        -- mem(18) := X"08100008"; -- j	    outer_loop
        --
        -- -- end_fact:
        -- mem(19) := X"21020000"; -- addi	    $v0, $t0, 0
        -- mem(20) := X"03E00008"; -- jr	    $ra
        --
        -- -- end_prog:
        -- mem(21) := X"31CE0001"; -- andi 	$t6, $0, 0
        -- mem(22) := X"35CE0000"; -- ori 	    $t6, 0
        -- mem(23) := X"000E7400"; -- sll	    $t6, $t6, 16
        -- mem(24) := X"3C0F0002"; -- lui      $t7, 2
        -- mem(25) := X"11CF0003"; -- beq	    $t6, $t7, erratum
		-- mem(26) := X"3C011001"; -- lui      $at, 0x00001001
        -- mem(27) := X"AC020010"; -- sw       $v0, 0x00000010($at)
		-- mem(28) := X"08100020"; -- j        the_end
		-- mem(29) := X"3C011001"; -- lui      $at, 0x00001001
		-- mem(30) := X"AC0E0010"; -- sw       $t6, 0x00000010($at)
        -- -- the_end:

	-- read memory
		rd <= mem(CONV_INTEGER(a));
end process;
end;
