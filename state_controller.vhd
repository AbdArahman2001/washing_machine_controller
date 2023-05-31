library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_controller is
	port( 
		clk, reset : in std_logic:= '0' ;
		start: in std_logic := '1'; 
		user_program: in std_logic_vector (4 downto 0);
		state: out  std_logic_vector (1 downto 0)   
	);
end state_controller;

architecture controller of state_controller is


begin
process (clk, user_program) 
variable counter : integer  ; 
variable cotton_loaded : std_logic := '0' ; 
variable rapid_loaded : std_logic := '0' ; 
variable slow_loaded : std_logic := '0' ; 
variable drain_loaded : std_logic := '0' ; 
variable white_loaded : std_logic := '0' ; 
begin
if rising_edge(clk) then 
	if(reset = '1' ) then 
		state <= "11" ; 
	end if ; 
  if (start = '1' ) then 
	if (user_program = "00001") then  -- Cotton
		if(cotton_loaded = '0' ) then 
			counter := 10 ; 
			cotton_loaded := '1' ;
		else 
			counter := counter - 1 ; 
		end if ; 	
		if (counter > 7 ) then -- 7 to 11 
			state <= "00" ; 
		elsif (counter > 2 ) then 
			state <= "01" ; 
		elsif (counter <= 2 and counter > 0 ) then 
			state <= "10" ; 
		else 
			state <= "11" ;
		end if ; 
	elsif (user_program = "00010") then  -- Rapid 
		
		if(rapid_loaded = '0' ) then 
			counter := 6 ; 
			rapid_loaded := '1' ;
		else 
			counter := counter - 1 ; 
		end if ; 	
		if (counter > 4 ) then -- 7 to 11 
			state <= "00" ; 
		elsif (counter > 2 ) then 
			state <= "01" ; 
		elsif (counter <= 2 and counter > 0 ) then 
			state <= "10" ; 
		else 
			state <= "11" ;
		end if ;
		elsif (user_program = "00100") then  -- Slow 
		
		if(slow_loaded = '0' ) then 
			counter := 12 ; 
			slow_loaded := '1' ;
		else 
			counter := counter - 1 ; 
		end if ; 	
		if (counter > 7 ) then -- 7 to 11 
			state <= "00" ; 
		elsif (counter > 2 ) then 
			state <= "01" ; 
		elsif (counter <= 2 and counter > 0 ) then 
			state <= "10" ; 
		else 
			state <= "11" ;
		end if ;
		elsif (user_program = "01000") then  -- Drain 
		
		if(drain_loaded = '0' ) then 
			counter := 4 ; 
			drain_loaded := '1' ;
		else 
			counter := counter - 1 ; 
		end if ; 	

		if (counter > 2 ) then 
			state <= "01" ; 
		elsif (counter <= 2 and counter > 0 ) then 
			state <= "10" ; 
		else 
			state <= "11" ;
		end if ;
		elsif (user_program = "10000") then  -- White 
		
		if(white_loaded = '0' ) then 
			counter := 8 ; 
			white_loaded := '1' ;
		else 
			counter := counter - 1 ; 
		end if ; 	
		if (counter > 5 ) then -- 7 to 11 
			state <= "00" ; 
		elsif (counter > 2 ) then 
			state <= "01" ; 
		elsif (counter <= 2 and counter > 0 ) then 
			state <= "10" ; 
		else 
			state <= "11" ;
		end if ;
	end if ;
	end if ; 
end if ; 
 
end process ; 

end ;