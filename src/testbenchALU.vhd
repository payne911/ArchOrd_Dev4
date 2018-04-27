library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;

entity testbench is
end;

architecture test of testbench is
    component alu
        port(   a, b: in STD_LOGIC_VECTOR(31 downto 0);
                f: in STD_LOGIC_VECTOR (5 downto 0);
                shamt: in STD_LOGIC_VECTOR (4 downto 0);
                z, o : out STD_LOGIC;
                y: buffer STD_LOGIC_VECTOR(31 downto 0));
	end component;

	signal srca, srcb: STD_LOGIC_VECTOR(31 downto 0);
    signal alucontrol: STD_LOGIC_VECTOR (5 downto 0);
	signal shamt: STD_LOGIC_VECTOR(4 downto 0);
    signal zero, overflow : STD_LOGIC;
    signal aluOut: STD_LOGIC_VECTOR(31 downto 0));

begin
-- instantiate device to be tested
	mainalu: alu port map(srca, srcb, alucontrol, shamt, zero, overflow, aluout);
-- Generate clock with 10 ns period
process begin
	srca <= X"00000000";
	srcb <= X"00000001";
    shamt <= "00001";

    -- sll
	alucontrol <= "000000";
	wait for 5 ns;
	if (aluout = X"00000010" and z = '0') then
		report "sll : OK";
	else
		report "sll : NOTOK - wrong value";
	endif;

	srca <= X"80000000";
	srcb <= X"7FFFFFFF";

    -- add
	alucontrol <= "100000";
	wait for 5 ns;
	if (overflow = '1') then
		report "add : NOTOK - overflow";
	else if (aluout = X"FFFFFFFF" and z = '0') then
		report "add : OK";
	else
		report "add : NOTOK - wrong value";
	endif;

    -- sub
	alucontrol <= "100010";
	wait for 5 ns;
	if (overflow = '1') then
		report "sub : NOTOK - overflow";
	else if (aluout = X"00000001" and z = '0') then
		report "sub : OK";
	else
		report "sub : NOTOK - wrong value";
	endif;

    -- and
	alucontrol <= "100100";
	wait for 5 ns;
	if (aluout = X"00000000" and z = '1') then
		report "and : OK";
	else
		report "and : NOTOK - wrong value";
	endif;

    -- or
	alucontrol <= "100101";
	wait for 5 ns;
	if (aluout = X"FFFFFFFF" and z = '0') then
		report "or : OK";
	else
		report "or : NOTOK - wrong value";
	endif;

    -- xor
	alucontrol <= "100110";
	wait for 5 ns;
	if (aluout = X"FFFFFFFF" and z = '0') then
		report "xor : OK";
	else
		report "xor : NOTOK - wrong value";
	endif;

    -- nor
	alucontrol <= "100111";
	wait for 5 ns;
	if (aluout = X"00000000" and z = '1') then
		report "nor : OK";
	else
		report "nor : NOTOK - wrong value";
	endif;

    -- sltu
	alucontrol <= "101011";
	wait for 5 ns;
	if (aluout = X"00000000" and z = '1') then
		report "sltu : OK";
	else
		report "sltu : NOTOK - wrong value";
	endif;

    -- slt
	alucontrol <= "101010";
	wait for 5 ns;
	if (aluout = X"00000001" and z = '0') then
		report "slt : OK";
	else
		report "slt : NOTOK - wrong value";
	endif;
    wait; -- forever
end process;
end;
