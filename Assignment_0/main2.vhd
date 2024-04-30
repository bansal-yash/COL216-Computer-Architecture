----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.01.2024 12:57:25
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main2 is
    --    Port (
    ----        c: out std_logic_vector(31 downto 0)
    --    );
end main2;

architecture Behavioral of main2 is
    component adder
        Port (
            c_in : in std_logic;
            x : in std_logic_vector(15 downto 0);
            y : in std_logic_vector(15 downto 0);
                        c_out: out std_logic;
            res : out std_logic_vector(15 downto 0)
        );
    end component;

    signal clk : std_logic := '0';
    signal a : std_logic_vector(15 downto 0) := "1111111111111111";
    signal b : std_logic_vector(15 downto 0) := "1101010110111001";
    signal x : std_logic_vector(15 downto 0) := (others => '0');
    signal c_1075 : std_logic_vector(31 downto 0) := (others => '0');
    signal y : std_logic_vector(15 downto 0) := (others => '0');
    signal res : std_logic_vector(15 downto 0) := (others => '0');
    signal c_out : std_logic := '0';
    signal cycle : integer := 0;
    signal c_in : std_logic := '0';
    signal no_of_cycles_1133 : integer := 0;
begin

    clock : process
    begin
        wait for 5 ns;
        clk <= not clk;
    end process;

    addition : adder PORT MAP(
            c_in => c_in,
            x => x,
            y => y,
            res => res,
            c_out => c_out);
    multiplier : process(clk)
        variable cycle2 : integer := 0;
    begin
        if rising_edge(clk) then
            if cycle < 16 then
                if cycle2 = 0 then
                    x <= c_1075(15+cycle downto cycle);
                    if b(cycle) = '0' then
                        y <= "0000000000000000";
                        cycle <= cycle + 1;
                        no_of_cycles_1133 <= no_of_cycles_1133 + 1;
                    else
                        y <= a;
                        cycle2 := 1;
                        no_of_cycles_1133 <= no_of_cycles_1133 + 1;
                    end if;
                else
                    c_1075(15+cycle downto cycle) <= res;
                    c_1075(16+cycle) <= c_out;
                    cycle2 := 0;
                    cycle <= cycle + 1;
                    no_of_cycles_1133 <= no_of_cycles_1133 + 1;
                end if;
            end if;
            
        end if;
    end process;

end Behavioral;
