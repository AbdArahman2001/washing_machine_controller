library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity washing_machine_main_cont is
	port( 
		clk, reset : in std_logic:= '0' ;
		start: in std_logic := '1'; 
		user_program: in std_logic_vector (4 downto 0);
		state: out  std_logic_vector (1 downto 0);
		sev_seg_data : out std_logic_vector (6 downto 0 ) ; 
		sev_seg_driver : out std_logic_vector (7 downto 0) 
	);
end washing_machine_main_cont ;

architecture controller of washing_machine_main_cont is
signal state_out : std_logic_vector (1 downto 0 ) ; 

component state_controller is
	port(
		clk, reset, start : in std_logic;
		user_program : in std_logic_vector (4 downto 0);
		state : out std_logic_vector (1 downto 0)
	);
	end component;
	component sev_seg_controller is
	port(
		clk, reset, start : in std_logic;
		user_program : in std_logic_vector (4 downto 0);
		state : in std_logic_vector (1 downto 0);
		sev_seg_data : out std_logic_vector (6 downto 0 ) ; 
		sev_seg_driver : out std_logic_vector (7 downto 0) 

	);
	end component;
	
	

begin
state_controller_lbl : state_controller
			port map(
						clk , reset , start , user_program , state_out);
						
seven_seg_driver_data : sev_seg_controller
			port map(
					clk , reset , start , user_program , state_out  ,sev_seg_data , sev_seg_driver ) ;
					
state <= state_out ; 
end controller; 