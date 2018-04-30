library IEEE;
use IEEE.STD_LOGIC_1164.all; use IEEE.STD_LOGIC_UNSIGNED.all;

entity testbench is
end;

architecture test of testbench is
	component mips
		port(	clk, reset: in STD_LOGIC;
				writedata, dataadr: out STD_LOGIC_VECTOR(31 downto 0);
				memwrite: out STD_LOGIC);
	end component;
	signal writedata, dataadr: STD_LOGIC_VECTOR(31 downto 0);
	signal clk, reset, memwrite: STD_LOGIC;
begin
-- instantiate device to be tested
	dut: mips port map (clk, reset, writedata, dataadr, memwrite);
-- Generate clock with 10 ns period
process begin
	clk <= '1';
	wait for 5 ns;
	clk <= '0';
	wait for 5 ns;
end process;

-- Generate reset for first two clock cycles
process begin
	reset <= '1';
	wait for 22 ns;
	reset <= '0';
	wait;
end process;

-- check that 720 gets written to address 16
-- at end of program
process (clk) begin
    if (clk'event and clk = '0' and reset = '0' and memwrite = '1') then
        if (conv_integer(dataadr) = 16) then
            if (conv_integer(writedata) = 720) then
                assert false report "Simulation succeeded"
                severity failure;
            else
                report "Simulation failed"
                severity failure;
            end if;
        end if;
    end if;
end process;

end;
