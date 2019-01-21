----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2018 08:05:24 AM
-- Design Name: 
-- Module Name: RAM - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           addr : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           di : in STD_LOGIC_VECTOR(15 DOWNTO 0);
           dO : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end RAM;

architecture Behavioral of RAM is
type ram_type is array (0 to 255) of STD_LOGIC_VECTOR (15 downto 0);
signal RAM1:ram_type:=(x"1234",
                       x"2345",
                       others=>x"0001");
begin
process(clk)
begin
if clk'event and clk='1' then
if we='1' then 
RAM1(conv_integer(addr))<=di;
else
do<=RAM1(conv_integer(addr));
end if;
end if;
end process;


end Behavioral;
