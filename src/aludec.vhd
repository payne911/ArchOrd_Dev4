library IEEE; use IEEE.STD_LOGIC_1164.all;

entity aludec is -- ALU control decoder
	port (funct: in STD_LOGIC_VECTOR (5 downto 0);
			aluop: in STD_LOGIC_VECTOR (1 downto 0);
			alucontrol: out STD_LOGIC_VECTOR (5 downto 0));
end;

architecture behave of aludec is
begin
process (aluop, funct) begin
	case aluop is
		when "00" => alucontrol <= "100000"; -- add (for 1b/sb/addi)
		when "01" => alucontrol <= "100010"; -- sub (for beq)
		when others => alucontrol <= funct; -- R-type instructions
	end case;
end process;
end;