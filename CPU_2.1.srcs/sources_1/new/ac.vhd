library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity ac is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    --    c11: in std_logic;
    --    c3: in std_logic;
    c10: in std_logic;
    
    aluo:in std_logic_vector(15 downto 0);
    aco:out std_logic_vector(15 downto 0)
    );
end ac;

architecture Behavioral of ac is

begin

process(clk,rst,en)
variable reg:std_logic_vector(15 downto 0):=x"0000";
begin
    if rst='1' then
        reg:=x"0000";
    elsif rising_edge(clk) and en='1' then
        if c10='1' then reg:=aluo;
        end if;
    end if;
    aco<=reg;
end process;

end Behavioral;
