library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity mar is
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
end mar;

architecture Behavioral of mar is

begin

p1:process(rst,clk,en)
begin
if rst='1' then
    maro<=x"00";
elsif rising_edge(clk) and en='1' then
    if c4='1' then maro<=mbro1_l;
    elsif c5='1' then maro<=pco;
    end if;
end if;

end process;
end Behavioral;
