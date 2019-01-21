----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/15/2018 08:17:53 AM
-- Design Name: 
-- Module Name: rom - Behavioral
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

entity rom is
    Port ( clk : in STD_LOGIC;
           adr : in STD_LOGIC_VECTOR(7 DOWNTO 0);
           rom_data : out STD_LOGIC_VECTOR(15 DOWNTO 0));
end rom;

architecture Behavioral of rom is
type arr_type is array (0 to 255)of STD_LOGIC_VECTOR(15 DOWNTO 0);
signal sig:arr_type:=(x"0001",
                      x"0010",
                      x"0011",
                      x"0100",
                      x"0101",
                      x"0110",
                      x"0111",
                      x"1000",
                      others =>x"FFFF");
                      
                      
begin
rom_data<=arr_type(conv_integer(adr));

end Behavioral;
