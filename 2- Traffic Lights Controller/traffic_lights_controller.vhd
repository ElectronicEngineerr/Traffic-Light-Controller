-- TRAFFIC LIGHT DESING WITH FPGA FOR 50 MHz 

library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.all;
USE IEEE.NUMERIC_STD.ALL;


entity traffic_lights_controller is

		port    (
						--inputs
					clk    : in std_logic;
					reset  : in std_logic;
						-- outputs
						
					road1 : out std_logic_vector(1 downto 0);
					road2 : out std_logic_vector(1 downto 0)
	
				);

end entity;

architecture Behavioral of traffic_lights_controller is

type traffic_light_states is ( RED1_YELLOW2, RED1_GREEN2, YELLOW1_RED2, GREEN1_RED2);
signal state : traffic_light_states := GREEN1_RED2;
signal counter : unsigned(31 downto 0) := (others => '0'); 

begin

	my_States : process ( clk, reset)

		begin
		    
			if ( reset = '1') then
				state <= GREEN1_RED2;
			elsif ( rising_edge(clk)) then
				case state is
				-------------------------------------------------------------------------
					when GREEN1_RED2 =>
						if ( counter = 5) then  -- 100 ns
							counter <= (others => '0');
							state <= YELLOW1_RED2;
							
						else
							counter <= counter + 1 ;
						end if;
				-------------------------------------------------------------------------	
					when YELLOW1_RED2 =>
						if ( counter = 2) then   -- 40 ns
							counter <= ( others => '0');
							state <= RED1_GREEN2;
						else
							counter <= counter + 1;
							
					
						end if;
				-------------------------------------------------------------------------
					
					when RED1_YELLOW2 =>
						if ( counter = 2) then  -- 40 ns
						
							counter <= ( others => '0');
							state <= RED1_GREEN2;
						
						else
						
							counter <= counter + 1 ;
						end if;
				-------------------------------------------------------------------------
							
					when RED1_GREEN2 =>
						if ( counter = 5) then   -- 100 ns
							counter <= ( others => '0');  
							state <= GREEN1_RED2;
						else
							counter <=  counter + 1 ;
							
						end if;
							
					when others =>
						counter <= (others => '0');
						state <= GREEN1_RED2;
				

				end case;
			end if;	
				
	
	
	
	end process;
	
	
	
	
	roads : process ( state )
	begin
			road1 <= "10";  -- default GREEN1
			road2 <= "00";	-- default RED2
			
			case state is
			
				when GREEN1_RED2 =>
				
					road1 <= "10";  -- GREEN1
					road2 <= "00";	-- RED2 
				
				when YELLOW1_RED2 =>
				
					road1 <= "01";	-- YELLOW1
					road2 <= "00";  -- RED2
					
				when RED1_YELLOW2 =>
					
					road1 <= "00"; -- RED1 
					road2 <= "01"; -- YELLOW2
					
				when RED1_GREEN2 =>
				
					road1 <= "00"; -- RED1 
					road2 <= "10";  -- GREEN2
			
				when others =>
				
					road1 <= "10";  -- default GREEN1
					road2 <= "00";	-- default RED2
			end case;
					
	
	
	
	end process;
	
	



end Behavioral;