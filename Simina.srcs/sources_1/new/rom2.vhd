----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2018 09:00:17 AM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
    
       
end test_env;

architecture Behavioral of test_env is

    component MPG is
    Port ( clk : in STD_LOGIC;
         en : out STD_LOGIC;
         input : in STD_LOGIC);
    end component;
    
    
    component display is
    Port ( clk : in STD_LOGIC;
           disp : in STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
  
    
    signal cnt          : std_logic_vector(15 downto 0);
    signal disp_data    : std_logic_vector(15 downto 0);
    signal rom_data :std_logic_vector(15 downto 0);
    signal btn0_en      : std_logic;
    signal btn1_en      : std_logic;
begin
    --mpg
    mpgU0: MPG 
    Port map( 
        clk     => clk, 
        en      => btn0_en,
        input   => btn(0)
        );
    
    mpgU1: MPG 
    Port map( 
        clk     => clk, 
        en      => btn1_en,
        input   => btn(1)
        );
         display1: display
           Port map( 
               clk     => clk, 
              disp      => disp_data,
            an   => an,
            cat=>cat
               );

    process(clk, btn0_en, btn1_en)
    begin
        if rising_edge(clk) then
            if btn0_en = '1' then
                cnt <= cnt + 1;
            elsif btn1_en = '1' then
                cnt <= cnt - 1;
            end if;
        end if;
    end process;
    
    
                          
                          
                  
process(sw,disp_data,rom_data,cnt)
begin
case(sw(1 downto 0)) is
   when"000" =>disp_data<=cnt;
    when"001"=>disp_data<=rom_data;
  when others =>disp_data<="0000000000000000";
end case;
end process;
    --output
--    disp_data <= cnt;
--    dipsU: display
--    Port map ( 
--        clk     => clk, 
--        disp    => disp_data, 
--        an      => an, 
--        cat     => cat 
--        );
    
    led <= cnt;
       
    
end Behavioral;
