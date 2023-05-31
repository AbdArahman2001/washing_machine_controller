library ieee;
use ieee.std_logic_1164.all;

entity sev_seg_controller_tb is
end sev_seg_controller_tb;

architecture behavior of sev_seg_controller_tb is

component sev_seg_controller port( 
		clk, reset : in std_logic ;
		start: in std_logic := '1'; 
		user_program: in std_logic_vector (4 downto 0);
		state: in  std_logic_vector (1 downto 0);
		sev_seg_data : out std_logic_vector (6 downto 0 ) ; 
		sev_seg_driver : buffer std_logic_vector (7 downto 0)
	);
	end component;
	
		signal clk_tb, reset_tb :  std_logic ;
		signal start_tb:  std_logic := '1'; 
		signal state_tb : std_logic_vector(1 downto 0);
		signal user_program_tb :  std_logic_vector (4 downto 0);
		signal sev_seg_data_tb :  std_logic_vector (6 downto 0 ) ; 
		signal sev_seg_driver_tb :  std_logic_vector (7 downto 0);
	
begin



	uut: sev_seg_controller
		port map(
			clk => clk_tb,
			reset => reset_tb,
			start => start_tb,
			user_program => user_program_tb,
			state => state_tb,
			sev_seg_data => sev_seg_data_tb,
			sev_seg_driver => sev_seg_driver_tb
		);
		
			
	tb : process
	
		-- set_seg_data constants	
	constant A: std_logic_vector(6 downto 0) := "0001000"; 
	constant C: std_logic_vector(6 downto 0) := "0110001"; 
	constant D: std_logic_vector(6 downto 0) := "1000010"; 
	constant E: std_logic_vector(6 downto 0) := "0110000"; 
	constant H: std_logic_vector(6 downto 0) := "1001000"; 
	constant I: std_logic_vector(6 downto 0) := "1111001";  
	constant L: std_logic_vector(6 downto 0) := "1110001"; 
	constant N: std_logic_vector(6 downto 0) := "0001001"; 
	constant o: std_logic_vector(6 downto 0) := "1100010"; 
	constant P: std_logic_vector(6 downto 0) := "0011000"; 
	constant r: std_logic_vector(6 downto 0) := "0011001"; 
	constant S: std_logic_vector(6 downto 0) := "0100100"; 
	constant t: std_logic_vector(6 downto 0) := "1110000"; 
	constant W: std_logic_vector(6 downto 0) := "1010101"; 
	constant G: std_logic_vector(6 downto 0) := "1011110"; 

	-- set_seg_driver constants
	constant no_one : std_logic_vector(7 downto 0) := "11111111";
	constant bit_0 : std_logic_vector(7 downto 0) := "01111111";
	constant bit_1 : std_logic_vector(7 downto 0) := "10111111";
	constant bit_2 : std_logic_vector(7 downto 0) := "11011111";
	constant bit_3 : std_logic_vector(7 downto 0) := "11101111";
	constant bit_4 : std_logic_vector(7 downto 0) := "11110111";
	constant bit_5 : std_logic_vector(7 downto 0) := "11111011";
	
			begin 
		
				reset_tb <= '0'; 
				start_tb <= '1';
				
				user_program_tb <= "00001";  -- COTTON
				
				wait until rising_edge(clk_tb);
				assert ((sev_seg_data_tb = C ) and (sev_seg_driver_tb = no_one))
				report "test failed for sev_seg_data C" severity error;
				
				wait until rising_edge(clk_tb);
				assert ((sev_seg_data_tb = W ) and (sev_seg_driver_tb = bit_0))
				report "test failed for sev_seg_data W" severity error;
				
				wait until rising_edge(clk_tb);
				assert ((sev_seg_data_tb = A ) and (sev_seg_driver_tb = bit_1))
				report "test failed for sev_seg_data A" severity error;
				
				wait until rising_edge(clk_tb);
				assert ((sev_seg_data_tb = S ) and (sev_seg_driver_tb = bit_2))
				report "test failed for sev_seg_data S" severity error;
				
				wait until rising_edge(clk_tb);
				assert ((sev_seg_data_tb = H ) and (sev_seg_driver_tb = bit_3))
				report "test failed for  sev_seg_data H" severity error;
	
	
	wait; 
	end process;
	
	clk_source : process  -- 20 ns clock
	
	constant period: time := 5 ps;
	constant end_time: time :=  100 ps;
		begin
		 clk_tb <= '0';
		wait for period;
		clk_tb <= '1';
		wait for period;
		
		if(now >= end_time) then
		wait;
		end if;
		end process;
		
		
end architecture;