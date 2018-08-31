----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/04/19 17:09:03
-- Design Name: 
-- Module Name: br - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity br is
    Port(clk: in std_logic;
    rst: in std_logic;
    en: in std_logic;
--    c12: in std_logic;
    c9: in std_logic;
    
    mbro1_l:in std_logic_vector(7 downto 0);        --mbr's 1st output[7:0]
    mbro1_h:in std_logic_vector(7 downto 0);        --mbr's 1st output[15:8]
    bro:out std_logic_vector(15 downto 0)
    );
end br;

architecture Behavioral of br is

begin

process(rst,clk,en)
variable reg:std_logic_vector(15 downto 0):=x"0000";
begin
    if rst='1' then
        reg:=x"0000";
    elsif rising_edge(clk) and en='1' then
        if c9='1' then
            reg(15 downto 8):= mbro1_h;
            reg(7 downto 0):= mbro1_l;
        end if;
    end if;
    bro<=reg;
end process;

end Behavioral;
