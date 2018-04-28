library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;

entity testbenchalu is
end;

architecture test of testbenchalu is
    component alu is
        port(   a, b:   in STD_LOGIC_VECTOR (31 downto 0);
                f:      in STD_LOGIC_VECTOR (5 downto 0);
                shamt:  in STD_LOGIC_VECTOR (4 downto 0);
                z, o :  out STD_LOGIC;
                y:      buffer STD_LOGIC_VECTOR (31 downto 0));
	end component;

	signal srca, srcb: STD_LOGIC_VECTOR (31 downto 0);
    signal alucontrol: STD_LOGIC_VECTOR (5 downto 0);
	signal shamt: STD_LOGIC_VECTOR (4 downto 0);
    signal zero, overflow : STD_LOGIC;
    signal aluOut: STD_LOGIC_VECTOR (31 downto 0);

begin
-- instantiate device to be tested
	dut: alu port map(srca, srcb, alucontrol, shamt, zero, overflow, aluout);

-- Generate clock with 10 ns period
    process begin
    	srca <= X"00000000";
    	srcb <= X"00000001";
        shamt <= "00001";

        -- sll
    	alucontrol <= "000000";
    	wait for 10 ns;
    	if (CONV_INTEGER(aluout) = CONV_INTEGER(X"00000010")) then
    	-- 	report "sll : OK";
    	-- else
    		report "sll : NOTOK - wrong value";
    	end if;

    	srca <= X"80000000";
    	srcb <= X"7FFFFFFF";

        -- add
    	alucontrol <= "100000";
    	wait for 10 ns;
    	if (overflow = '1') then
    		report "add : NOTOK - overflow";
    	elsif (CONV_INTEGER(aluout) = CONV_INTEGER(X"FFFFFFFF")) then
    		report "add : OK";
    	else
    		report "add : NOTOK - wrong value";
    	end if;

        -- sub
    	alucontrol <= "100010";
    	wait for 10 ns;
    	if (overflow = '1') then
    		report "sub : NOTOK - overflow";
    	elsif (CONV_INTEGER(aluout) = CONV_INTEGER(X"00000001")) then
    		report "sub : OK";
    	else
    		report "sub : NOTOK - wrong value";
    	end if;

        -- and
    	alucontrol <= "100100";
    	wait for 10 ns;
    	if (CONV_INTEGER(aluout) = CONV_INTEGER(X"00000000")) then
    		report "and : OK";
    	else
    		report "and : NOTOK - wrong value";
    	end if;

        -- or
    	alucontrol <= "100101";
    	wait for 10 ns;
    	if (CONV_INTEGER(aluout) = CONV_INTEGER(X"FFFFFFFF")) then
    		report "or : OK";
    	else
    		report "or : NOTOK - wrong value";
    	end if;

        -- xor
    	alucontrol <= "100110";
    	wait for 10 ns;
    	if (CONV_INTEGER(aluout) = CONV_INTEGER(X"FFFFFFFF")) then
    		report "xor : OK";
    	else
    		report "xor : NOTOK - wrong value";
    	end if;

        -- nor
    	alucontrol <= "100111";
    	wait for 10 ns;
    	if (CONV_INTEGER(aluout) = CONV_INTEGER(X"00000000")) then
    		report "nor : OK";
    	else
    		report "nor : NOTOK - wrong value";
    	end if;

        -- sltu
    	alucontrol <= "101011";
    	wait for 10 ns;
    	if (CONV_INTEGER(aluout) = CONV_INTEGER(X"00000000")) then
    		report "sltu : OK";
    	else
    		report "sltu : NOTOK - wrong value";
    	end if;

        -- slt
    	alucontrol <= "101010";
    	wait for 10 ns;
    	if (CONV_INTEGER(aluout) = CONV_INTEGER(X"00000001")) then
    		report "slt : OK";
    	else
    		report "slt : NOTOK - wrong value";
    	end if;

        wait; -- forever
    end process;
end;
