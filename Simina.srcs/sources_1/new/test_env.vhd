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
      component FetchUnit is
       Port ( j_addr : in STD_LOGIC_VECTOR (15 downto 0);
                b_addr : in STD_LOGIC_VECTOR (15 downto 0);
                PCsrc : in STD_LOGIC;
                jump : in STD_LOGIC;
                rst : in STD_LOGIC;
                 clk : in STD_LOGIC;
                en:in STD_LOGIC;
                instr : out STD_LOGIC_VECTOR (15 downto 0);
                next_adr : out STD_LOGIC_VECTOR (15 downto 0));
                end component;
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
 
       component Reg_file is 
               Port ( clk : in STD_LOGIC;
                      ra1 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
                      ra2 : in STD_LOGIC_VECTOR(3 DOWNTO 0);
                      wa : in STD_LOGIC_VECTOR(3 DOWNTO 0);
                      wd : in STD_LOGIC_VECTOR(15 DOWNTO 0);
                      rd1 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
                      rd2 : out STD_LOGIC_VECTOR(15 DOWNTO 0);
                      wen : in STD_LOGIC);
                      end component;
    
  
    
    signal cnt          : std_logic_vector(15 downto 0);
    signal disp_data    : std_logic_vector(15 downto 0);
    signal rom_data     : std_logic_vector(15 downto 0);
     signal rd_1    : std_logic_vector(15 downto 0);
       signal rd_2     : std_logic_vector(15 downto 0);
        signal en     : std_logic:='0';
         signal en2     : std_logic:='0';
     signal ram_data       :std_logic_vector(15 downto 0);
     signal we    : std_logic_vector(4downto 0);
    signal btn0_en      : std_logic;
    signal btn1_en      : std_logic;
    type ram_type is array (0 to 255) of STD_LOGIC_VECTOR (15 downto 0);
    signal RAM1:ram_type:=(x"1234",
                           x"2345",
                           others=>x"0001");
    type rom_arr is array (0 to 255) of std_logic_vector(15 downto 0);
    signal rom : rom_arr := (
    x"1234",
    x"1A34",
    x"1B34",
    x"12C4",        
    x"123D",
    x"1234",
    others => x"AA00"
    ); 
   


begin
--Paul:FetchUnit Port map(x"0000", x"0001", sw(1),sw(0),en,clk,en2 ,rd_1,rd_2);
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
    
    --rom
    rom_data <= rom(conv_integer(cnt(7 downto 0)));
     
    process(clk)
    begin
    if clk'event and clk='1' then
    if we(1)='1' then 
    RAM1(conv_integer(cnt(7 downto 0)))<=ram_data;
    else
    ram_data<=RAM1(conv_integer(cnt(7 downto 0)));
    end if;
    end if;
    end process;            
                          
 --  outputs                 
    process(sw,disp_data,rom_data,cnt)
    begin
        case(sw(1 downto 0)) is
            when"000"   => disp_data<=cnt;
            when"001"   => disp_data<=rom_data;
            when"010"   =>disp_data<=ram_data;
          when others   => disp_data<="0000000000000000";
        end case;
    end process;
    
    led <= cnt;
 
    dipsU: display
    Port map ( 
        clk     => clk, 
        disp    => disp_data, 
        an      => an, 
        cat     => cat 
        );
    
    led <= cnt;
       
    
end Behavioral;
