----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2018 12:19:34 AM
-- Design Name: 
-- Module Name: MPG - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MPG is
  Port ( clk : in STD_LOGIC;
         en : out STD_LOGIC;
         input : in STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal count_int : std_logic_vector(15 downto 0) ; 
signal Q1: STD_LOGIC := '0';
signal Q2: STD_LOGIC := '0';
signal Q3: STD_LOGIC := '0';
begin

    process(clk)
    begin 
        if clk = '1' and clk'event then
            count_int <= count_int + 1; 
        end if;
    end process;

    process(clk)
    begin
        if clk'event and clk = '1' then
            if count_int = x"FFFF" then 
                Q1 <= input;
            end if;
        end if;
    end process;

    process(clk)
    begin 
        if clk'event and clk = '1' then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;

    en <= Q2 and (not Q3);
    
end Behavioral;
