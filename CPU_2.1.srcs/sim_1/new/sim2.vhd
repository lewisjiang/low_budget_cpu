----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2018/04/22 18:06:02
-- Design Name: 
-- Module Name: sim2 - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sim2 is
--  Port ( );
end sim2;

architecture Behavioral of sim2 is
component top is
    port(clk0: in std_logic;
    select_clk: in std_logic;
    en: in std_logic;
    rst: in std_logic;
    no:out std_logic_vector(7 downto 0);
    seg:out std_logic_vector(6 downto 0)
    );
end component;
signal clk: std_logic:='0';
signal en: std_logic:='0';
signal rst: std_logic:='0';
signal select_clk: std_logic:='0';
signal no:std_logic_vector(7 downto 0);
signal seg:std_logic_vector(6 downto 0);
begin

uut: top port map(clk0=>clk,en=>en,rst=>rst,select_clk=>select_clk,no=>no,seg=>seg);

clock:process
begin
    wait for 50 ns;
    clk<=not clk;
end process;

process
begin
    wait for 230 ns;
    en<='1';
    wait;
end process;

process
variable a: std_logic:='0';
begin
    wait for 170 ns;
        rst<='1';
    wait for 110 ns;
        rst<='0';
    --wait for 3000 ns;
    wait;
 end process;
 
end Behavioral;
