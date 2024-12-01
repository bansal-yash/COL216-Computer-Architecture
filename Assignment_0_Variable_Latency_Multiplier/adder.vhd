


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity adder is
    Port (
        c_in : in std_logic;
        x : in std_logic_vector(15 downto 0);
        y : in std_logic_vector(15 downto 0);
        c_out: out std_logic;
        res : out std_logic_vector(15 downto 0)
    );
end adder;

architecture Behavioral of adder is
--    signal c_in : std_logic := '0';
    --    signal x : std_logic_vector(15 downto 0) := "0000000000000000";
    --    signal y : std_logic_vector(15 downto 0) := "1111111111111111";
    signal p : std_logic_vector(15 downto 0);
    signal g : std_logic_vector(15 downto 0);
    signal c:  std_logic_vector(16 downto 0);

begin
    p(0) <= x(0) xor y(0);
    p(1) <= x(1) xor y(1);
    p(2) <= x(2) xor y(2);
    p(3) <= x(3) xor y(3);
    g(0) <= x(0) and y(0);
    g(1) <= x(1) and y(1);
    g(2) <= x(2) and y(2);
    g(3) <= x(3) and y(3);
    c(0) <= c_in;
    c(1) <= g(0) or (p(0) and c(0));
    c(2) <= g(1) or (p(1) and g(0)) or (p(1) and p(0) and c(0));
    c(3) <= g(2) or (p(2) and g(1)) or (p(2) and p(1) and g(0)) or (p(2) and p(1) and p(0) and c(0));
    c(4) <= g(3) or (p(3) and g(2)) or (p(3) and p(2) and g(1)) or (p(3) and p(2) and p(1) and g(0)) or (p(3) and p(2)and p(1) and p(0) and c(0));
    res(0) <= p(0) xor c(0);
    res(1) <= p(1) xor c(1);
    res(2) <= p(2) xor c(2);
    res(3) <= p(3) xor c(3);


    p(4) <= x(4) xor y(4);
    p(5) <= x(5) xor y(5);
    p(6) <= x(6) xor y(6);
    p(7) <= x(7) xor y(7);
    g(4) <= x(4) and y(4);
    g(5) <= x(5) and y(5);
    g(6) <= x(6) and y(6);
    g(7) <= x(7) and y(7);
    c(5) <= g(4) or (p(4) and c(4));
    c(6) <= g(5) or (p(5) and g(4)) or (p(5) and p(4) and c(4));
    c(7) <= g(6) or (p(6) and g(5)) or (p(6) and p(5) and g(4)) or (p(6) and p(5) and p(4) and c(4));
    c(8) <= g(7) or (p(7) and g(6)) or (p(7) and p(6) and g(5)) or (p(7) and p(6) and p(5) and g(4)) or (p(7) and p(6)and p(5) and p(4) and c(4));
    res(4) <= p(4) xor c(4);
    res(5) <= p(5) xor c(5);
    res(6) <= p(6) xor c(6);
    res(7) <= p(7) xor c(7);

    p(8) <= x(8) xor y(8);
    p(9) <= x(9) xor y(9);
    p(10) <= x(10) xor y(10);
    p(11) <= x(11) xor y(11);
    g(8) <= x(8) and y(8);
    g(9) <= x(9) and y(9);
    g(10) <= x(10) and y(10);
    g(11) <= x(11) and y(11);
    c(9) <= g(8) or (p(8) and c(8));
    c(10) <= g(9) or (p(9) and g(8)) or (p(9) and p(8) and c(8));
    c(11) <= g(10) or (p(10) and g(9)) or (p(10) and p(9) and g(8)) or (p(10) and p(9) and p(8) and c(8));
    c(12) <= g(11) or (p(11) and g(10)) or (p(11) and p(10) and g(9)) or (p(11) and p(10) and p(9) and g(8)) or (p(11) and p(10)and p(9) and p(8) and c(8));
    res(8) <= p(8) xor c(8);
    res(9) <= p(9) xor c(9);
    res(10) <= p(10) xor c(10);
    res(11) <= p(11) xor c(11);

    p(12) <= x(12) xor y(12);
    p(13) <= x(13) xor y(13);
    p(14) <= x(14) xor y(14);
    p(15) <= x(15) xor y(15);
    g(12) <= x(12) and y(12);
    g(13) <= x(13) and y(13);
    g(14) <= x(14) and y(14);
    g(15) <= x(15) and y(15);
    c(13) <= g(12) or (p(12) and c(12));
    c(14) <= g(13) or (p(13) and g(12)) or (p(13) and p(12) and c(12));
    c(15) <= g(14) or (p(14) and g(13)) or (p(14) and p(13) and g(12)) or (p(14) and p(13) and p(12) and c(12));
    c(16) <= g(15) or (p(15) and g(14)) or (p(15) and p(14) and g(13)) or (p(15) and p(14) and p(13) and g(12)) or (p(15) and p(14)and p(13) and p(12) and c(12));
    res(12) <= p(12) xor c(12);
    res(13) <= p(13) xor c(13);
    res(14) <= p(14) xor c(14);
    res(15) <= p(15) xor c(15);

    c_out <= c(16);
end Behavioral;
