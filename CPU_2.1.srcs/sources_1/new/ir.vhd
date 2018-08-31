
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ir is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
    c7: in std_logic;
--    c8: in std_logic;
    
    mbro1_h:in std_logic_vector(7 downto 0);        --mbr's 1st output[15:8]
    iro:out std_logic_vector(7 downto 0)
    );
end ir;

architecture Behavioral of ir is

begin

process(rst,clk,en)
variable reg:std_logic_vector(7 downto 0):=x"00";
begin
    if rst='1' then
        reg:=x"00";
    elsif rising_edge(clk) and en='1' then
        if c7='1' then reg:=mbro1_h;
        end if;
    end if;
    iro<=reg;
end process;

end Behavioral;
