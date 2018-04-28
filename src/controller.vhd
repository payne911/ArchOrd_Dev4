library IEEE; use IEEE.STD_LOGIC_1164.all;
entity controller is -- single cycle control decoder
	port (op, funct: in STD_LOGIC_VECTOR (5 downto 0);
			zero: in STD_LOGIC;
			memtoreg: out STD_LOGIC_VECTOR (1 downto 0);
            memwrite: out STD_LOGIC;
			pcsrc, alusrca: out STD_LOGIC;
            alusrcb, regdst: out STD_LOGIC_VECTOR (1 downto 0);
			regwrite: out STD_LOGIC;
			jump: out STD_LOGIC_VECTOR (1 downto 0);
			alucontrol: out STD_LOGIC_VECTOR (5 downto 0));
end;

architecture struct of controller is
	component maindec
		port (op: in STD_LOGIC_VECTOR (5 downto 0);
                memtoreg: out STD_LOGIC_VECTOR (1 downto 0);
                memwrite: out STD_LOGIC;
                branch, alusrca: out STD_LOGIC;
                alusrcb, regdst: out STD_LOGIC_VECTOR (1 downto 0);
                regwrite: out STD_LOGIC;
                jump: out STD_LOGIC_VECTOR (1 downto 0);
                aluop: out STD_LOGIC_VECTOR (2 downto 0));
	end component;
	component aludec
		port (funct: in STD_LOGIC_VECTOR (5 downto 0);
				aluop: in STD_LOGIC_VECTOR (2 downto 0);
				alucontrol: out STD_LOGIC_VECTOR (5 downto 0));
	end component;
	signal aluop: STD_LOGIC_VECTOR (2 downto 0);
	signal branch: STD_LOGIC;
begin
	md: maindec port map (op, memtoreg, memwrite, branch, alusrca, alusrcb, regdst, regwrite, jump, aluop);
	ad: aludec port map (funct, aluop, alucontrol);
	pcsrc <= branch and zero;
end;
