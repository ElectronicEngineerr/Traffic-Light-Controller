
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_traffic_lights_controller is
--  Port ( );
end tb_traffic_lights_controller;

architecture Behavioral of tb_traffic_lights_controller is

component traffic_lights_controller is

		port    (
						--inputs
					clk    : in std_logic;
					reset  : in std_logic;
						-- outputs
						
					road1 : out std_logic_vector(1 downto 0);
					road2 : out std_logic_vector(1 downto 0)
	
				);

end component;

signal clk : std_logic;
signal reset : std_logic;
signal road1 : std_logic_vector ( 1 downto 0 );
signal road2 : std_logic_vector ( 1 downto 0 );

constant clock_period : time := 20 ns;

begin

uut : traffic_lights_controller
    port map (
    
                    clk => clk,
                    reset => reset,
                    road1 => road1,
                    road2 => road2

              );

-- generate clock signal

clock : process
begin
        clk <= '1';
        wait for clock_period/2;
        clk <= '0';
        wait for clock_period/2;
end process;


stim : process
begin

    wait for 20 ns;   
    reset <= '1';
    wait for 20 ns;
    reset <= '0';
    wait for 100 ms;
    wait;
end process;

end Behavioral;