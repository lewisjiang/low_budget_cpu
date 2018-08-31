library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;



entity display is
    Port(clk0:in std_logic;
    clk:out std_logic;
    select_clk: in std_logic;
    no:out std_logic_vector(7 downto 0);
    seg:out std_logic_vector(6 downto 0);
    aco:in std_logic_vector(15 downto 0)
    );
end display;

architecture Behavioral of display is

type length8 is array (0 to 7) of std_logic_vector(3 downto 0);
signal clk2:std_logic:='0';
signal clk3:std_logic:='0';

begin

---------------------------------------------------------------时钟2:数码管扫描时钟,800hz，每个灯100hz
clock2:process(clk0)
variable clkcnt:integer range 0 to 62_499;
begin
if clk0'event and clk0='1' then
    if clkcnt<62_499 then clkcnt:=clkcnt+1;
    elsif clkcnt=62_499 then clkcnt:=0;clk2<=not clk2;
    end if;
end if;
end process clock2;

---------------------------------------------------------------时钟3: 50hz clk3
clock3:process(clk0)
variable clkcnt:integer range 0 to 999_999;
begin
if clk0'event and clk0='1' then
    if clkcnt<999_999 then clkcnt:=clkcnt+1;
    elsif clkcnt=999_999 then clkcnt:=0;clk3<=not clk3;
    end if;
end if;
end process clock3;

---------------------------------------------------------------时钟切换
select_clock:process(select_clk,clk0,clk3)
begin
if select_clk='0' then clk<=clk0;
else clk<=clk3;
end if;
end process;


-------------------------------------------------------------------------------数码管显示数字
digi_display_num:process(clk2,aco)
variable todisp:std_logic_vector(3 downto 0);--一个数码
variable rot:integer range 0 to 7:=0;--轮转亮数码管
variable digis:length8:=(x"f",x"f",x"f",x"f",x"f",x"f",x"f",x"f");
begin
    if clk2'event and clk2='1' then
        for i in 0 to 7 loop
            digis(i):=x"f";
        end loop;
        
        digis(0):=aco(3 downto 0);
        digis(1):=aco(7 downto 4);
        digis(2):=aco(11 downto 8);
        digis(3):=aco(15 downto 12);
        
        if rot=7 then rot:=0;
        else rot:=rot+1;
        end if;
    
    case rot is 
        when 0 => todisp:=digis(0);
        when 1 => todisp:=digis(1);
        when 2 => todisp:=digis(2);
        when 3 => todisp:=digis(3);
        
        when others=> todisp:=x"0";
    end case;
    
    case rot is
        when 0 => no<= "11111110";
        when 1 => no<= "11111101";
        when 2 => no<= "11111011";
        when 3 => no<= "11110111";
--        when 4 => no<= "11101111";        --only 4 digits selected
--        when 5 => no<= "11011111";
--        when 6 => no<= "10111111";
--        when 7 => no<= "01111111";
        when others => no<= "11111111";
    end case;
    
    case todisp is
        when x"0"=>seg<="1000000";
        when x"1"=>seg<="1111001";
        when x"2"=>seg<="0100100";
        when x"3"=>seg<="0110000";
        when x"4"=>seg<="0011001";
        when x"5"=>seg<="0010010";
        when x"6"=>seg<="0000010";
        when x"7"=>seg<="1111000";
        when x"8"=>seg<="0000000";
        when x"9"=>seg<="0010000";
        when x"a"=>seg<="0001000";
        when x"b"=>seg<="0000011";
        when x"c"=>seg<="1000110";
        when x"d"=>seg<="0100001";
        when x"e"=>seg<="0000110";
        when x"f"=>seg<="0001110";
        when others=>seg<="1111111";
    end case;
    end if;
end process digi_display_num;

end Behavioral;
