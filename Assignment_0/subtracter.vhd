----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.01.2024 00:26:31
-- Design Name: 
-- Module Name: subtracter - Behavioral
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

entity subtracter is
Port (
        --        c_in : in std_logic;
        x : in std_logic_vector(32 downto 0);
        y : in std_logic_vector(32 downto 0);
        res : out std_logic_vector(31 downto 0)
    );
end subtracter;

architecture Behavioral of subtracter is
    signal c_in : std_logic := '1';
    signal p : std_logic_vector(31 downto 0);
    signal g : std_logic_vector(31 downto 0);
    signal c:  std_logic_vector(32 downto 0);
begin
    p(0) <= x(0) xor not(y(0));
    p(1) <= x(1) xor not(y(1));
    p(2) <= x(2) xor not(y(2));
    p(3) <= x(3) xor not(y(3));
    g(0) <= x(0) and not(y(0));
    g(1) <= x(1) and not(y(1));
    g(2) <= x(2) and not(y(2));
    g(3) <= x(3) and not(y(3));
    c(0) <= c_in;
    c(1) <= g(0) or (p(0) and c(0));
    c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c(0));
    c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and c(0));
    c(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2)and p(1) and p(0) and c(0));
    res(0) <= p(0) xor c(0);
    res(1) <= p(1) xor c(1);
    res(2) <= p(2) xor c(2);
    res(3) <= p(3) xor c(3);


    p(4) <= x(4) xor not(y(4));
    p(5) <= x(5) xor not(y(5));
    p(6) <= x(6) xor not(y(6));
    p(7) <= x(7) xor not(y(7));
    g(4) <= x(4) and not(y(4));
    g(5) <= x(5) and not(y(5));
    g(6) <= x(6) and not(y(6));
    g(7) <= x(7) and not(y(7));
    c(5) <= g(4) or (p(4) and c(4));
    c(6) <= g(5) or (p(5) and g(4)) or (p(5) and p(4) and c(4));
    c(7) <= g(6) or (p(6) and g(5)) or (p(6) and p(5) and g(4)) or (p(6) and p(5) and p(4) and c(4));
    c(8) <= g(7) or (p(7) and g(6)) or (p(7) and p(6) and g(5)) or (p(7) and p(6) and p(5) and g(4)) or (p(7) and p(6)and p(5) and p(4) and c(4));
    res(4) <= p(4) xor c(4);
    res(5) <= p(5) xor c(5);
    res(6) <= p(6) xor c(6);
    res(7) <= p(7) xor c(7);

    p(8) <= x(8) xor not(y(8));
    p(9) <= x(9) xor not(y(9));
    p(10) <= x(10) xor not(y(10));
    p(11) <= x(11) xor not(y(11));
    g(8) <= x(8) and not(y(8));
    g(9) <= x(9) and not(y(9));
    g(10) <= x(10) and not(y(10));
    g(11) <= x(11) and not(y(11));
    c(9) <= g(8) or (p(8) and c(8));
    c(10) <= g(9) or (p(9) and g(8)) or (p(9) and p(8) and c(8));
    c(11) <= g(10) or (p(10) and g(9)) or (p(10) and p(9) and g(8)) or (p(10) and p(9) and p(8) and c(8));
    c(12) <= g(11) or (p(11) and g(10)) or (p(11) and p(10) and g(9)) or (p(11) and p(10) and p(9) and g(8)) or (p(11) and p(10)and p(9) and p(8) and c(8));
    res(8) <= p(8) xor c(8);
    res(9) <= p(9) xor c(9);
    res(10) <= p(10) xor c(10);
    res(11) <= p(11) xor c(11);

    p(12) <= x(12) xor not(y(12));
    p(13) <= x(13) xor not(y(13));
    p(14) <= x(14) xor not(y(14));
    p(15) <= x(15) xor not(y(15));
    g(12) <= x(12) and not(y(12));
    g(13) <= x(13) and not(y(13));
    g(14) <= x(14) and not(y(14));
    g(15) <= x(15) and not(y(15));
    c(13) <= g(12) or (p(12) and c(12));
    c(14) <= g(13) or (p(13) and g(12)) or (p(13) and p(12) and c(12));
    c(15) <= g(14) or (p(14) and g(13)) or (p(14) and p(13) and g(12)) or (p(14) and p(13) and p(12) and c(12));
    c(16) <= g(15) or (p(15) and g(14)) or (p(15) and p(14) and g(13)) or (p(15) and p(14) and p(13) and g(12)) or (p(15) and p(14)and p(13) and p(12) and c(12));
    res(12) <= p(12) xor c(12);
    res(13) <= p(13) xor c(13);
    res(14) <= p(14) xor c(14);
    res(15) <= p(15) xor c(15);

    p(16) <= x(16) xor not(y(16));
    p(17) <= x(17) xor not(y(17));
    p(18) <= x(18) xor not(y(18));
    p(19) <= x(19) xor not(y(19));
    g(16) <= x(16) and not(y(16));
    g(17) <= x(17) and not(y(17));
    g(18) <= x(18) and not(y(18));
    g(19) <= x(19) and not(y(19));
    c(17) <= g(16) or (p(16) and c(16));
    c(18) <= g(17) or (p(17) and g(16)) or (p(17) and p(16) and c(16));
    c(19) <= g(18) or (p(18) and g(17)) or (p(18) and p(17) and g(16)) or (p(18) and p(17) and p(16) and c(16));
    c(20) <= g(19) or (p(19) and g(18)) or (p(19) and p(18) and g(17)) or (p(19) and p(18) and p(17) and g(16)) or (p(19) and p(18)and p(17) and p(16) and c(16));
    res(16) <= p(16) xor c(16);
    res(17) <= p(17) xor c(17);
    res(18) <= p(18) xor c(18);
    res(19) <= p(19) xor c(19);

    p(20) <= x(20) xor not(y(20));
    p(21) <= x(21) xor not(y(21));
    p(22) <= x(22) xor not(y(22));
    p(23) <= x(23) xor not(y(23));
    g(20) <= x(20) and not(y(20));
    g(21) <= x(21) and not(y(21));
    g(22) <= x(22) and not(y(22));
    g(23) <= x(23) and not(y(23));
    c(21) <= g(20) or (p(20) and c(20));
    c(22) <= g(21) or (p(21) and g(20)) or (p(21) and p(20) and c(20));
    c(23) <= g(22) or (p(22) and g(21)) or (p(22) and p(21) and g(20)) or (p(22) and p(21) and p(20) and c(20));
    c(24) <= g(23) or (p(23) and g(22)) or (p(23) and p(22) and g(21)) or (p(23) and p(22) and p(21) and g(20)) or (p(23) and p(22)and p(21) and p(20) and c(20));
    res(20) <= p(20) xor c(20);
    res(21) <= p(21) xor c(21);
    res(22) <= p(22) xor c(22);
    res(23) <= p(23) xor c(23);

    p(24) <= x(24) xor not(y(24));
    p(25) <= x(25) xor not(y(25));
    p(26) <= x(26) xor not(y(26));
    p(27) <= x(27) xor not(y(27));
    g(24) <= x(24) and not(y(24));
    g(25) <= x(25) and not(y(25));
    g(26) <= x(26) and not(y(26));
    g(27) <= x(27) and not(y(27));
    c(25) <= g(24) or (p(24) and c(24));
    c(26) <= g(25) or (p(25) and g(24)) or (p(25) and p(24) and c(24));
    c(27) <= g(26) or (p(26) and g(25)) or (p(26) and p(25) and g(24)) or (p(26) and p(25) and p(24) and c(24));
    c(28) <= g(27) or (p(27) and g(26)) or (p(27) and p(26) and g(25)) or (p(27) and p(26) and p(25) and g(24)) or (p(27) and p(26)and p(25) and p(24) and c(24));
    res(24) <= p(24) xor c(24);
    res(25) <= p(25) xor c(25);
    res(26) <= p(26) xor c(26);
    res(27) <= p(27) xor c(27);

    p(28) <= x(28) xor not(y(28));
    p(29) <= x(29) xor not(y(29));
    p(30) <= x(30) xor not(y(30));
    p(31) <= x(31) xor not(y(31));
    g(28) <= x(28) and not(y(28));
    g(29) <= x(29) and not(y(29));
    g(30) <= x(30) and not(y(30));
    g(31) <= x(31) and not(y(31));
    c(29) <= g(28) or (p(28) and c(28));
    c(30) <= g(29) or (p(29) and g(28)) or (p(29) and p(28) and c(28));
    c(31) <= g(30) or (p(30) and g(29)) or (p(30) and p(29) and g(28)) or (p(30) and p(29) and p(28) and c(28));
    c(32) <= g(31) or (p(31) and g(30)) or (p(31) and p(30) and g(29)) or (p(31) and p(30) and p(29) and g(28)) or (p(31) and p(30)and p(29) and p(28) and c(28));
    res(28) <= p(28) xor c(28);
    res(29) <= p(29) xor c(29);
    res(30) <= p(30) xor c(30);
    res(31) <= p(31) xor c(31);

end Behavioral;
