library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity mbr is
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
end mbr;

architecture Behavioral of mbr is

begin

process(rst,clk,en)
variable reg:std_logic_vector(15 downto 0):=x"0000";
begin
    if rst='1' then
        reg:=x"0000";
    elsif rising_edge(clk) and en='1' then
        if c0='1' then reg:=ram2mbr;
        elsif c3='1' then reg:=aco;
        end if;
    end if;
    mbr2ram<=reg;
    mbro1_l<=reg(7 downto 0);
    mbro1_h<=reg(15 downto 8);
end process;
end Behavioral;
