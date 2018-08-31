library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;


entity alu is
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
end alu;

architecture Behavioral of alu is

begin
p0:process(clk)
variable reg32:std_logic_vector(31 downto 0):=x"00000000";
variable temp,total: integer;
begin
    if rst='1' then
        reg32:=x"00000000";
    elsif rising_edge(clk) and en='1' then
        if calu=x"0E" then reg32:=x"00000000";       -- clear alu when sent 0b(0000)
        elsif c12='1' and c11='1' then     --double operand operations
            case calu is
                when x"01"=>            --add
                    reg32(15 downto 0):=aco+bro;      --signed or unsigned?? bits not match??
                when x"03"=>            --sub
                    reg32(15 downto 0):=aco-bro;
                when x"05"=>            --mul
                    reg32:=aco*bro;
                when x"07"=>
                    reg32(15 downto 0):=aco and bro;
                when x"09"=>
                    reg32(15 downto 0):=aco or bro;
                when x"11"=>
                    temp:=Conv_Integer(bro);
                    total:=Conv_Integer(aco);
                    for 
                    reg32(15 downto 0):=Conv_Integer(aco)/Conv_Integer(bro);
                when others=> null;
                end case;
        elsif c11='1' then              -- single operand operations
            case calu is
                when x"02"=>
                    reg32(15 downto 0):=not aco;
                when x"04"=>
                    reg32(15 downto 0):='0'&aco(15 downto 1);
                when x"06"=>
                    reg32(15 downto 0):=aco(14 downto 0)&'0';
                when x"08"=>
                    reg32(15 downto 0):=aco(15)&aco(15 downto 1);
                when x"0a"=>
                    reg32(15 downto 0):=aco(15)&aco(13 downto 0)&'0';
                when others=>null;
                end case;
        end if;
        
        if calu/=x"00" then
            if reg32(15 downto 0)>=0 then flg_gez<='1';     -- 负数怎么表示？Negative nums?
            else flg_gez<='0'; end if;
        end if;
--        if reg32>"FFFF" then          --flags not set yet
--        if reg32=x"00000000" then
    end if;

    aluo<=reg32(15 downto 0);
end process p0;

end Behavioral;
