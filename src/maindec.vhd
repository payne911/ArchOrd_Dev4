library IEEE; use IEEE.STD_LOGIC_1164.all;

entity maindec is -- main control decoder
	port (op: in STD_LOGIC_VECTOR (5 downto 0);
			memtoreg: out STD_LOGIC_VECTOR (1 downto 0);
            memwrite: out STD_LOGIC;
			branch, alusrca: out STD_LOGIC;
            alusrcb, regdst: out STD_LOGIC_VECTOR (1 downto 0);
			regwrite: out STD_LOGIC;
            jump: out STD_LOGIC_VECTOR (1 downto 0);
            aluop: out STD_LOGIC_VECTOR (2 downto 0));
end;

architecture behave of maindec is
	signal controls: STD_LOGIC_VECTOR(14 downto 0);
begin
    process(op) begin
	    case op is
		    when "000000" => controls <= "101000000000100"; -- Rtyp
		    when "100011" => controls <= "100001000100000"; -- LW
            when "101011" => controls <= "000001010000000"; -- SW
    		when "000100" => controls <= "000000100000001"; -- BEQ
    		when "001000" => controls <= "100001000000000"; -- ADDI
            when "000010" => controls <= "000000000001000"; -- J
            when "000010" => controls <= "100010000000010"; -- ANDI
            when "000010" => controls <= "100010000000011"; -- ORI
            when "000010" => controls <= "110000001101100"; -- JAL
            when "000010" => controls <= "100000001000100"; -- LUI
            when "000010" => controls <= "101100000000000"; -- IndexIntAdr
    		when others   => controls <= "---------------"; -- illegal op
	    end case;
    end process;

	regwrite <= controls(14);
	regdst <= controls(13 downto 12);
    alusrca <= controls(11);
    alusrcb <= controls(10 downto 9);
	branch <= controls(8);
	memwrite <= controls(7);
	memtoreg <= controls(6 downto 5);
	jump <= controls(4 downto 3);
	aluop <= controls(2 downto 0);
end;
