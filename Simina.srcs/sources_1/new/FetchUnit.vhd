----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2018 06:25:58 PM
-- Design Name: 
-- Module Name: iff - Behavioral
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

entity fetch is
    Port ( j_addr : in STD_LOGIC_VECTOR (15 downto 0);
           b_addr : in STD_LOGIC_VECTOR (15 downto 0);
           PCsrc : in STD_LOGIC;
           jump : in STD_LOGIC;
           rst : in STD_LOGIC;
            clk : in STD_LOGIC;
           en:in STD_LOGIC;
           instr : out STD_LOGIC_VECTOR (15 downto 0);
           next_adr : out STD_LOGIC_VECTOR (15 downto 0));
           
end fetch;

architecture Behavioral of fetch is
type comp_rom is array (0 to 256-1) of std_logic_vector(16-1 downto 0);

signal r_name: comp_rom := (
"0001110000000101", --sub 1c05
"0001110000000000",--sll 1c00
"0001110000000110", --and 1c06
"0001110000000111", --or 1c07
"0101000100000000", --sw 5100
"0010110010000000", --lw 2c80
"0001011011010000", --add 16d0
"1000000010000000",--addi 8080
 others => x"FFFF" 
);
signal suma:std_logic_vector (15 downto 0):=x"0000";
signal iesire1:std_logic_vector (15 downto 0):=x"0000";
signal iesire2:std_logic_vector (15 downto 0):=x"0000";
signal iesire_pc:std_logic_vector (15 downto 0):=x"0000";
begin

process(PCsrc,b_addr,suma)
begin
if(PCsrc='1') then
 iesire1<=b_addr;
 else
 iesire1<=suma;
end if;

end process;

process(jump,j_addr,iesire1)
begin

if(jump='1') then
  iesire2<=j_addr;
  else
  iesire2<=iesire1;
  end if;

end process;
process(clk)
begin

if rising_edge(clk) then
 if(en='1') then
iesire_pc<=iesire2;
end if;
end if;

end process;


  suma<=iesire_pc+1;
  next_adr<=suma;


process(iesire_pc)
begin

instr<=r_name(conv_integer(iesire_pc));

end process;
end Behavioral;
