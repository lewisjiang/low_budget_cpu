library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity cu is
    Port(
    clk,en,rst: in std_logic;
    --flgs
    flg_gez: in std_logic;
    ----
    c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12: out std_logic;
    calu:out std_logic_vector(7 downto 0);
    iro:in std_logic_vector(7 downto 0)
    );
end cu;

architecture Behavioral of cu is
component dist_mem_gen_0 is
    port(
    a: in std_logic_vector(7 downto 0);
    spo:out std_logic_vector(15 downto 0)
    );
end component;
signal car: std_logic_vector(7 downto 0):=x"00";
signal cbr: std_logic_vector(15 downto 0):=x"0000";
begin

rom:dist_mem_gen_0 port map(a=>car,spo=>cbr);

sequencing:process(clk)

variable halted:std_logic:='0';
variable busy:std_logic :='0';
variable md:std_logic :='0';
begin
    if rst='1' then
        halted:='0';
        car<=x"00";
--        cbr<=x"0000";       --FIXME
        c0<='0';
        c1<='0';
        c2<='0';
        c3<='0';
        c4<='0';
        c5<='0';
        c6<='0';
        c7<='0';
        c8<='0';
        c9<='0';
        c10<='0';
        c11<='0';
        c12<='0';
    elsif halted='1' then
        car<=x"00";
        c12<='0';
    elsif rising_edge(clk) and en='1' then
        if busy='0' and( cbr=x"0020" or cbr=x"0000") then                      --开始，输入为0，car地址为fetch
            car<=x"00";
            busy:='1';
        elsif  busy='1' then         --fetch指令的微程序未结束前，一直执行
            if cbr=x"0100" and md='0' then     --微操控制符，只有c8为1，用在fetch结尾
                md:='1';
            elsif cbr=x"0100" and md='1' then   --人工延时
                if iro(3 downto 0)=x"d" and flg_gez='0'then   --如果不需要条件跳转，则
                    car<='0'&iro(3 downto 0)&"001";
                else
                    car<='0'&iro(3 downto 0)&"000";           --寻找fetch来的指令的起点, car=hash(iro)
                end if;
                    md:='0';
            elsif cbr/=x"0000" then
                car<=car+1;
            end if;
--            if flg_gez='0' and car=x"68" then c6<='0';  --确定跳转时使用，for jump use
--            else c6<=cbr(6); end if;
            c0<=cbr(0);c1<=cbr(1);c2<=cbr(2);c3<=cbr(3);c4<=cbr(4);c5<=cbr(5);c6<=cbr(6);
            c7<=cbr(7);c8<=cbr(8);c9<=cbr(9);c10<=cbr(10);c11<=cbr(11);c12<=cbr(12);
            calu<=iro(7 downto 4)&cbr(15 downto 12);
            
            if cbr=x"0000" then busy:='0';      --用于一般程序结尾
            elsif cbr=x"f000" then halted:='1';
            end if;
        end if;
    end if;
end process sequencing;


end Behavioral;
