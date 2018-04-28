library IEEE; use IEEE.STD_LOGIC_1164.all;

entity proc_mips is -- single cycle MIPS processor
	port (clk, reset: in STD_LOGIC;
			pc: out STD_LOGIC_VECTOR (31 downto 0);
			instr: in STD_LOGIC_VECTOR (31 downto 0);
			memwrite: out STD_LOGIC;
			aluout, writedata: out STD_LOGIC_VECTOR (31 downto 0);
			readdata: in STD_LOGIC_VECTOR (31 downto 0));
end;

architecture struct of proc_mips is
	component controller
		port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
				zero: in STD_LOGIC;
                memtoreg: out STD_LOGIC_VECTOR (1 downto 0);
                memwrite: out STD_LOGIC;
    			pcsrc, alusrca: out STD_LOGIC;
                alusrcb, regdst: out STD_LOGIC_VECTOR (1 downto 0);
    			regwrite: out STD_LOGIC;
    			jump: out STD_LOGIC_VECTOR (1 downto 0);
				alucontrol: out STD_LOGIC_VECTOR (5 downto 0));
	end component;
	component datapath
		port (clk, reset: in STD_LOGIC;
                memtoreg: in STD_LOGIC_VECTOR (1 downto 0);
                pcsrc, alusrca: in STD_LOGIC;
                alusrcb, regdst: in STD_LOGIC_VECTOR (1 downto 0);
                regwrite: in STD_LOGIC;
                jump: in STD_LOGIC_VECTOR (1 downto 0);
                alucontrol: in STD_LOGIC_VECTOR (5 downto 0);
                zero, overflow: out STD_LOGIC;
				pc: buffer STD_LOGIC_VECTOR (31 downto 0);
				instr: in STD_LOGIC_VECTOR (31 downto 0);
				aluout, writedata: buffer STD_LOGIC_VECTOR (31 downto 0);
				readdata: in STD_LOGIC_VECTOR (31 downto 0));
	end component;
    signal memtoreg, alusrcb, regdst, jump STD_LOGIC_VECTOR (1 downto 0);
	signal alusrca, regwrite, pcsrc: STD_LOGIC;
	signal zero, overflow STD_LOGIC;
	signal alucontrol: STD_LOGIC_VECTOR (5 downto 0);
begin
	cont: controller port map (instr (31 downto 26), instr(5 downto 0), zero, memtoreg,
										memwrite, pcsrc, alusrca, alusrcb, regdst, regwrite, jump, alucontrol);
	dp: datapath port map (	clk, reset, memtoreg, pcsrc, alusrca, alusrcb,regdst, regwrite, jump,
									alucontrol, zero, overflow, pc, instr, aluout, writedata, readdata);
end;
