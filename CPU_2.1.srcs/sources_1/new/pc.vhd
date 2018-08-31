library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity pc is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    c6: in std_logic;
    c5: in std_logic;
    
    mbro1_l:in std_logic_vector(7 downto 0);        --mbr's 1st output[15:8]
    pco:out std_logic_vector(7 downto 0)
    );
end pc;

architecture Behavioral of pc is

begin
process(rst,clk,en)
variable reg:std_logic_vector(7 downto 0):=x"00";
variable delay:std_logic:='0';
begin
    if rst='1' then
        reg:=x"00";
    elsif rising_edge(clk) and en='1' then
        if c6='1' then reg:=mbro1_l;        
        elsif c5='1' and delay='0' then delay:='1';           --可能需要人工延时 possible manual delay needed
        elsif delay='1' then reg:=reg+1;delay:='0';
        end if;
    end if;
    pco<=reg;
end process;

end Behavioral;
