library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;


entity top is
    Port(clk0:in std_logic;
    en: in std_logic;
    rst: in std_logic;
    select_clk: in std_logic;
    no:out std_logic_vector(7 downto 0);
    seg:out std_logic_vector(6 downto 0)
    );
end top;

architecture Behavioral of top is
component ir is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    c7: in std_logic;
    --    c8: in std_logic;
    
    mbro1_h:in std_logic_vector(7 downto 0);        --mbr's 1st output[15:8]
    iro:out std_logic_vector(7 downto 0)
    );
end component;

component pc is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    c6: in std_logic;
    c5: in std_logic;
    
    mbro1_l:in std_logic_vector(7 downto 0);        --mbr's 1st output[15:8]
    pco:out std_logic_vector(7 downto 0)
    );
end component;

component alu is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    c11: in std_logic;
    --    c10: in std_logic;
    c12: in std_logic;
    calu:in std_logic_vector(7 downto 0);
    
    -- we can add some flags.
    flg_gez: out std_logic;
    --
    aluo:out std_logic_vector(15 downto 0):=x"0000";
    aco:in std_logic_vector(15 downto 0);
    bro:in std_logic_vector(15 downto 0)
    );
end component;

component cu is
    Port(
    clk,en,rst: in std_logic;
    --flgs
    flg_gez: in std_logic;
    ----
    c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12: out std_logic;
    calu:out std_logic_vector(7 downto 0);
    iro:in std_logic_vector(7 downto 0)
    );
end component;

component mar is
  Port(clk: in std_logic;
  rst: in std_logic;
  en: in std_logic;
--    c2: in std_logic;
  c4: in std_logic;
  c5: in std_logic;
  mbro1_l:in std_logic_vector(7 downto 0);        --mbr's 1st output[7:0]
  pco: in std_logic_vector(7 downto 0);
  maro: out std_logic_vector(7 downto 0)          --addr to RAM
  );
end component;

component mbr is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    c0: in std_logic;
    --    c1: in std_logic;
    c3: in std_logic;
    
    aco: in std_logic_vector(15 downto 0);
    ram2mbr:in std_logic_vector(15 downto 0);
    mbr2ram:out std_logic_vector(15 downto 0);          --data to RAM
    mbro1_l:out std_logic_vector(7 downto 0);        --mbr's 1st output[7:0]
    mbro1_h:out std_logic_vector(7 downto 0)        --mbr's 1st output[15:8]
    );
end component;

component ac is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    --    c11: in std_logic;
    --    c3: in std_logic;
    c10: in std_logic;
    
    aluo:in std_logic_vector(15 downto 0);
    aco:out std_logic_vector(15 downto 0)
    );
end component;

component br is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    --    c12: in std_logic;
    c9: in std_logic;
    
    mbro1_l:in std_logic_vector(7 downto 0);        --mbr's 1st output[7:0]
    mbro1_h:in std_logic_vector(7 downto 0);        --mbr's 1st output[15:8]
    bro:out std_logic_vector(15 downto 0)
    );
end component;

component dist_mem_gen_1 is
    port(
    a: in std_logic_vector(7 downto 0);
    spo:out std_logic_vector(15 downto 0);
    d:in std_logic_vector(15 downto 0);
    clk:in std_logic;
    we:in std_logic
    );
end component;

component display is
    Port(clk0:in std_logic;
    select_clk: in std_logic;
    clk:out std_logic;
    no:out std_logic_vector(7 downto 0);
    seg:out std_logic_vector(6 downto 0);
    aco:in std_logic_vector(15 downto 0)
    );
end component;

signal iro:std_logic_vector(7 downto 0);
signal mbro1_h:std_logic_vector(7 downto 0);
signal mbro1_l:std_logic_vector(7 downto 0);
signal pco: std_logic_vector(7 downto 0);
signal maro: std_logic_vector(7 downto 0);
signal aluo: std_logic_vector(15 downto 0);
signal aco: std_logic_vector(15 downto 0);
signal bro:std_logic_vector(15 downto 0);

signal ram2mbr:std_logic_vector(15 downto 0);
signal mbr2ram:std_logic_vector(15 downto 0);          --data to RAM

signal c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12: std_logic;
signal calu:std_logic_vector(7 downto 0);
signal flg_gez:std_logic;

signal clk:std_logic:='0';


begin

---------------------------------------------------------------Ôª¼þÀý»¯
disp_n_clk:display port map(clk0=>clk0,
                select_clk=>select_clk,
                clk=>clk,
                no=>no,
                seg=>seg,
                aco=>aco);
                
ram:dist_mem_gen_1 port map(a=>maro,spo=>ram2mbr,d=>mbr2ram,clk=>clk,we=>c1);

ir0: ir port map(clk=>clk,
                rst=>rst,
                en=>en,
                c7=>c7,
                mbro1_h=>mbro1_h,
                iro=>iro);
pc0: pc port map(clk=>clk,
                rst=>rst,
                en=>en,
                c6=>c6,
                c5=>c5,
                mbro1_l=>mbro1_l,
                pco=>pco);
mar0: mar port map(clk=>clk,
                rst=>rst,
                en=>en,
                c4=>c4,
                c5=>c5,
                mbro1_l=>mbro1_l,
                pco=>pco,
                maro=>maro);
mbr0: mbr port map(clk=>clk,
                rst=>rst,
                en=>en,
                c0=>c0,
                c3=>c3,
                aco=>aco,
                ram2mbr=>ram2mbr,
                mbr2ram=>mbr2ram,
                mbro1_l=>mbro1_l,
                mbro1_h=>mbro1_h);
br0: br port map(clk=>clk,
                rst=>rst,
                en=>en,
                c9=>c9,
                mbro1_l=>mbro1_l,
                mbro1_h=>mbro1_h,
                bro=>bro);
alu0: alu port map(clk=>clk,
                rst=>rst,
                en=>en,
                
                c11=>c11,
                c12=>c12,
                calu=>calu,
                flg_gez=>flg_gez,
                aluo=>aluo,
                aco=>aco,
                bro=>bro);
cu0: cu port map(
                clk=>clk,
                en=>en,
                rst=>rst,
                flg_gez=>flg_gez,
                c0=>c0,
                c1=>c1,
                c2=>c2,
                c3=>c3,
                c4=>c4,
                c5=>c5,
                c6=>c6,
                c7=>c7,
                c8=>c8,
                c9=>c9,
                c10=>c10,
                c11=>c11,
                c12=>c12,
                calu=>calu,
                iro=>iro);
ac0: ac port map(clk=>clk,
                rst=>rst,
                en=>en,
                c10=>c10,
                aluo=>aluo,
                aco=>aco);


end Behavioral;
