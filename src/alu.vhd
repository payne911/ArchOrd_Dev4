library IEEE; use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
	port (a, b: in STD_LOGIC_VECTOR(31 downto 0);
			f: in STD_LOGIC_VECTOR (5 downto 0);
			z, o : out STD_LOGIC;
			y: out STD_LOGIC_VECTOR(31 downto 0));
end;
architecture behave of alu is
signal s, diff: STD_LOGIC_VECTOR(31 downto 0);
begin
	diff <= a - b;
	process (a, b, f, s, diff) begin
		case f is
			when "100000" => s <= a + b; --32 add
			when "100010" => s <= a - b; --34 sub
			when "100100" => s <= a and b; --36 and
			when "100101" => s <= a or b; --37 or
			when "100110" => s <= a xor b; --38 xor
			when "100111" => s <= not (a or b); --39 nor 
			when "101010" => --SLT
					if diff(31) = '1' then 
						s <= X"00000001"; 
					else 
						s <= X"00000000"; 
					end if;
			when others => s <= "--------------------------------"; --Don't care
		end case;
	end process;
	
	z <= '1' when s = X"00000000" else '0';
	o <= '1' when a(31) = b(31) and (a(31) /= s(31)) else '0';
	y <= s;
end;