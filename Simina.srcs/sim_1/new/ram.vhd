----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2018 09:15:49 AM
-- Design Name: 
-- Module Name: ram - Behavioral
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

entity ram is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           adr : in STD_LOGIC_vector(7 downto 0);
           di : in STD_LOGIC_vector(15 downto 0);
           do : out STD_LOGIC_vector(15 downto 0));
end ram;

architecture Behavioral of ram is
type ram_type is array (0 to 255) of std_logic_vector (15 downto 0);
 signal RAM: ram_type;
begin
 process (clk)
 begin
 if clk'event and clk = '1' then
      if en = '1' then
      if we = '1' then
         RAM(conv_integer(adr)) <= di;
         else
        do <= RAM( conv_integer(adr));
 end if;
 end if;
 end if;
 end process; 


end Behavioral;
