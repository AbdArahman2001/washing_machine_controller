library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sev_seg_controller is
	port( 
		clk, reset : in std_logic:= '0' ;
		start: in std_logic := '1'; 
		user_program: in std_logic_vector (4 downto 0);
		state: in  std_logic_vector (1 downto 0);
		sev_seg_data : out std_logic_vector (6 downto 0 ) ; 
		sev_seg_driver : buffer std_logic_vector (7 downto 0) := "11111111"
	);
end sev_seg_controller ;

architecture controller of sev_seg_controller is

begin
 
outputs: process (clk , state)
variable counter : integer range 0 to 16 := 0; 

-- sev_seg_data constants
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
constant bit_0 : std_logic_vector(7 downto 0) := "01111111";
constant bit_1 : std_logic_vector(7 downto 0) := "10111111";
constant bit_2 : std_logic_vector(7 downto 0) := "11011111";
constant bit_3 : std_logic_vector(7 downto 0) := "11101111";
constant bit_4 : std_logic_vector(7 downto 0) := "11110111";
constant bit_5 : std_logic_vector(7 downto 0) := "11111011";


variable enable_wash : std_logic := '0' ; 
variable enable_spin : std_logic := '0' ; 
variable enable_rinse : std_logic := '0' ;
variable enable_cotton : std_logic := '0' ;
variable enable_slow : std_logic := '0' ;
variable enable_rapid : std_logic := '0' ;
variable enable_drain : std_logic := '0' ;
variable enable_white : std_logic := '0' ;
 

begin
if rising_edge(clk) then 
case state is
when "00"  => 
--	if(rising_edge(clk)) then 
		if(enable_wash = '0' ) then 
			counter := 0 ; 
			enable_wash := '1' ;
		end if ; 	
		if (counter = 0 ) then 
			sev_seg_data <= W ;
			sev_seg_driver <= bit_0 ;
		elsif(counter = 1 ) then 
			sev_seg_data <= A ;
			sev_seg_driver <= bit_1;
		elsif(counter = 2 ) then 
			sev_seg_data <= S ;
			sev_seg_driver <= bit_2 ; 
		elsif(counter = 3) then 
			sev_seg_data <= H;
			sev_seg_driver <= bit_3;
			enable_wash := '0' ; 
		end if;
--	end if ; 
	
when "01" => 	
	--if(rising_edge(clk)) then 
		if(enable_spin = '0' ) then 
			counter := 0 ; 
			enable_spin := '1' ;
		end if ;
		if (counter = 0 ) then 
			sev_seg_data <= S ;
			sev_seg_driver <= bit_0 ;
		elsif(counter = 1 ) then 
			sev_seg_data <= P ;
			sev_seg_driver <= bit_1;
		elsif(counter = 2 ) then 
			sev_seg_data <= I ;
			sev_seg_driver <= bit_2;

		elsif(counter = 3 ) then 
			sev_seg_data <= N;
			sev_seg_driver <= bit_3;

	    	enable_spin := '0' ;

		--elsif(counter = 4 ) then 
			--sev_seg_data <= "0110000" ;
			--sev_seg_driver <= "11111" & sev_seg_driver(7 downto 5);
		--elsif(counter = 5 ) then 
			--sev_seg_data <= "1110110" ;
			--sev_seg_driver <= "111111" & sev_seg_driver(7 downto 6);
		--elsif(counter = 6) then 
			--sev_seg_data <= "1011110" ;
			--sev_seg_driver <= "1111111" & sev_seg_driver(7);
		end if;
	--end if ; 
when "10" => 
		if(enable_rinse = '0' ) then 
			counter := 0 ; 
			enable_rinse := '1' ;
		end if ;
--	if (rising_edge(clk)) then 
	if (counter = 0 ) then 
			sev_seg_data <= R;
			sev_seg_driver <= bit_0 ;
		elsif(counter = 1 ) then 
			sev_seg_data <= I ;
			sev_seg_driver <= bit_1;
		elsif(counter = 2 ) then 
			sev_seg_data <= N ;
			sev_seg_driver <= bit_2;
		elsif(counter = 3 ) then 
			sev_seg_data <= S ;
			sev_seg_driver <= bit_3;
		elsif(counter = 4 ) then 
			sev_seg_data <= E ;
			sev_seg_driver <= bit_4;
			enable_rinse := '0' ;

		--elsif(counter = 5 ) then 
			--sev_seg_data <= "1110110" ;
		--	sev_seg_driver <= "11111011";
		--elsif(counter = 6) then 
		--	sev_seg_data <= "1011110" ;
			--sev_seg_driver <= "11111101";
		end if;
--	end if; 
when others => 
--if (rising_edge(clk)) then 
	case user_program is 
	when "00001" => 
		if(enable_cotton = '0' ) then 
			counter := 0 ; 
			enable_cotton := '1' ;
		end if ;
		if (counter = 0 ) then 
			sev_seg_data <= C ;
			sev_seg_driver <= bit_0 ;
		elsif(counter = 1 ) then 
			sev_seg_data <= O ;
			sev_seg_driver <= bit_1;
		elsif(counter = 2 ) then 
			sev_seg_data <=T ;
			sev_seg_driver <= bit_2;
		elsif(counter = 3 ) then 
			sev_seg_data <= T ;
			sev_seg_driver <= bit_3;
		elsif(counter = 4 ) then 
			sev_seg_data <= O ;
			sev_seg_driver <= bit_4;
		elsif(counter = 5 ) then 
			sev_seg_data <= N ;
			sev_seg_driver <= bit_5;
			enable_cotton := '0' ; 
		--elsif(counter = 6) then 
			--sev_seg_data <= "1011110" ;
			--sev_seg_driver <= "1111111" & sev_seg_driver(7);
		end if;
	when "00010" => 
		if(enable_rapid = '0' ) then 
			counter := 0 ; 
			enable_rapid := '1' ;
		end if ;
		if (counter = 0 ) then 
			sev_seg_data <= R ;
			sev_seg_driver <= bit_0 ;

		elsif(counter = 1 ) then 
			sev_seg_data <= A ;
			sev_seg_driver <= bit_1 ;
		elsif(counter = 2 ) then 
			sev_seg_data <= P ;
			sev_seg_driver <= bit_2 ;
		elsif(counter = 3 ) then 
			sev_seg_data <= I ;
			sev_seg_driver <= bit_3 ;
		elsif(counter = 4 ) then 
			sev_seg_data <= D ;
			sev_seg_driver <= bit_4 ;
			enable_rapid := '0' ; 
		--elsif(counter = 5 ) then 
			--sev_seg_data <= "1110110" ;
			--sev_seg_driver <= "111111" & sev_seg_driver(7 downto 6);
		--elsif(counter = 6) then 
			--sev_seg_data <= "1011110" ;
			--sev_seg_driver <= "1111111" & sev_seg_driver(7);
	end if;
	when "00100" => 
		if(enable_slow = '0' ) then 
			counter := 0 ; 
			enable_slow := '1' ;
		end if ;
		if (counter = 0 ) then 
			sev_seg_data <= S ;
			sev_seg_driver <= bit_0 ;
		elsif(counter = 1 ) then 
			sev_seg_data <= L ;
			sev_seg_driver <= bit_1 ;
		elsif(counter = 2 ) then 
			sev_seg_data <= O ;
			sev_seg_driver <= bit_2 ;
		elsif(counter = 3 ) then 
			sev_seg_data <= W ;
			sev_seg_driver <= bit_3 ;
			enable_slow := '0' ;

		--elsif(counter = 4 ) then 
			--sev_seg_data <= "1111100" ;
			--sev_seg_driver <= "11111" & sev_seg_driver(7 downto 5);
		--elsif(counter = 5 ) then 
			--sev_seg_data <= "1110110" ;
			--sev_seg_driver <= "111111" & sev_seg_driver(7 downto 6);
		--elsif(counter = 6) then 
			--sev_seg_data <= "1011110" ;
			--sev_seg_driver <= "1111111" & sev_seg_driver(7);
		end if;
		when "01000" => 
		if(enable_drain = '0' ) then 
			counter := 0 ; 
			enable_drain := '1' ;
		end if ;

		if (counter = 0 ) then 
			sev_seg_data <= D ;
			sev_seg_driver <= bit_0;
		elsif(counter = 1 ) then 
			sev_seg_data <= R;
			sev_seg_driver <= bit_1 ;
		elsif(counter = 2 ) then 
			sev_seg_data <= A ;
			sev_seg_driver <= bit_2 ;
		elsif(counter = 3 ) then 
			sev_seg_data <= I ;
			sev_seg_driver <= bit_3 ;
		elsif(counter = 4 ) then 
			sev_seg_data <= N;
			sev_seg_driver <= bit_4 ;
			enable_drain := '0' ; 
		--elsif(counter = 5 ) then 
			--sev_seg_data <= "1110110" ;
			--sev_seg_driver <= "111111" & sev_seg_driver(7 downto 6);
		--elsif(counter = 6) then 
			--sev_seg_data <= "1011110" ;
			--sev_seg_driver <= "1111111" & sev_seg_driver(7);
		end if;
		when "10000" => 
		if(enable_white = '0' ) then 
			counter := 0 ; 
			enable_white := '1' ;
		end if ;

		if (counter = 0 ) then 
			sev_seg_data <= W;
			sev_seg_driver <= bit_0;
		elsif(counter = 1 ) then 
			sev_seg_data <= H ;
			sev_seg_driver <= bit_1 ;
		elsif(counter = 2 ) then 
			sev_seg_data <= I ;
			sev_seg_driver <= bit_2 ;
		elsif(counter = 3 ) then 
			sev_seg_data <= T;
			sev_seg_driver <= bit_3;
		elsif(counter = 4 ) then 
			sev_seg_data <= E;
			sev_seg_driver <= bit_4 ;
			enable_white := '0' ; 
		--elsif(counter = 5 ) then 
			--sev_seg_data <= "1110110" ;
			--sev_seg_driver <= "111111" & sev_seg_driver(7 downto 6);
		--elsif(counter = 6) then 
			--sev_seg_data <= "1011110" ;
			--sev_seg_driver <= "1111111" & sev_seg_driver(7);
		end if;
		when others => null ; 
		end case ; 
	--end if;   -- Other wise the program name 
end case;
counter := counter + 1 ; 
end if ; 
end process;
end controller ; 


