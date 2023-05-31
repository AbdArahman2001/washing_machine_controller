library ieee;
use ieee.std_logic_1164.all;

entity state_controller_tb is
end state_controller_tb;

architecture behavior of state_controller_tb is

component state_controller is
	port( 
		clk, reset : in std_logic:= '0' ;
		start: in std_logic := '1'; 
		user_program: in std_logic_vector (4 downto 0);
		state: out  std_logic_vector (1 downto 0) :="00"		
	);
	end component;
	
		signal clk_tb, reset_tb :  std_logic ;
		signal start_tb:  std_logic := '1'; 
		signal state_tb : std_logic_vector(1 downto 0);
		signal user_program_tb :  std_logic_vector (4 downto 0);

	shared variable clk_counts : Integer range 0 to 100 := 0;

	
begin



	uut: state_controller
		port map(
			clk => clk_tb,
			reset => reset_tb,
			start => start_tb,
			user_program => user_program_tb,
			state => state_tb
		);
		
			
	tb : process
	
	
			begin 
		
				reset_tb <= '0'; 
				start_tb <= '1';
				
				user_program_tb <= "00001";  -- COTTON
				
				wait until (rising_edge(clk_tb) and (clk_counts = 1)) ;
				assert (state_tb = "00")
				report "test failed for program COTTON state 00" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 4)) ;
				assert (state_tb = "01")
				report "test failed for program COTTON state 01" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 9)) ;
				assert (state_tb = "10")
				report "test failed for program COTTON state 10" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 11)) ;
				assert (state_tb = "11")
				report "test failed for program COTTON state 11" severity error;
				
				clk_counts :=0;
				user_program_tb <= "00010";  -- RAPID
				
				wait until rising_edge(clk_tb)  ;
				wait until rising_edge(clk_tb)  ;
				assert (state_tb = "00")
				report "test failed for program RAPID state 00" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 4)) ;
				assert (state_tb = "01")
				report "test failed for program RAPID state 01" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 6)) ;
				assert (state_tb = "10")
				report "test failed for program RAPID state 10" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 8)) ;
				assert (state_tb = "11")
				report "test failed for program RAPID state 11" severity error;
				
				wait until rising_edge(clk_tb);
				clk_counts :=0;
				user_program_tb <= "00100";  -- SLOW
				
				wait until rising_edge(clk_tb)  ;
				wait until rising_edge(clk_tb)  ;
				assert (state_tb = "00")
				report "test failed for program SLOW state 00" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 7)) ;
				assert (state_tb = "01")
				report "test failed for program SLOW state 01" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 12)) ;
				assert (state_tb = "10")
				report "test failed for program SLOW state 10" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 14)) ;
				assert (state_tb = "11")
				report "test failed for program SLOW state 11" severity error;
				
				wait until rising_edge(clk_tb)  ;
				clk_counts :=0;
				user_program_tb <= "01000";  -- DRAIN
				
				wait until rising_edge(clk_tb)  ;
				wait until rising_edge(clk_tb)  ;
				assert (state_tb = "01")
				report "test failed for program DRAIN state 01" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 5)) ;
				assert (state_tb = "10")
				report "test failed for program DRAIN state 10" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 7)) ;
				assert (state_tb = "11")
				report "test failed for program DRAIN state 11" severity error;
				
				
				clk_counts :=0;
				user_program_tb <= "10000";  -- WHITE
				
				wait until (rising_edge(clk_tb) and (clk_counts = 4)) ;
				assert (state_tb = "00")
				report "test failed for program WHITE state 00" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 7)) ;
				assert (state_tb = "01")
				report "test failed for program WHITE state 01" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 9)) ;
				assert (state_tb = "10")
				report "test failed for program WHITE state 10" severity error;
				
				wait until (rising_edge(clk_tb) and (clk_counts = 12)) ;
				assert (state_tb = "11")
				report "test failed for program WHITE state 11" severity error;
	
	
	wait; 
	end process;
	
	clk_source : process  -- 10 ns clock
	
	constant period: time := 5 ps;
	constant end_time: time :=  600 ps;
		begin
		 clk_tb <= '0';
		wait for period;
		clk_tb <= '1';
		wait for period;
		clk_counts := clk_counts +1;
		if(now >= end_time) then
		wait;
		end if;
		end process;
		
		
end architecture;