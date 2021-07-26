library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity datacounter3 is

	port ( resetN     : in    std_logic 				   ;
		   clk 	      : in    std_logic 				   ;
		   start 	  : in    std_logic 				   ;
	       eoc        : out   std_logic                    ;
	       cc        : out   std_logic                    ;
		   dcount     : inout std_logic_vector(3 downto 0) ) ;
		   
end datacounter3;

architecture arc_datacounter3 of datacounter3 is

begin

	process ( resetN, clk )
	
	variable c : std_logic ;
	
	begin
	
		if resetN = '0' then
		   dcount <= ( others => '0' ) ;
		elsif rising_edge(clk) then
		   if c = '1' then
		      if dcount < "1000" then
		         dcount <= dcount + 1;
		      else
		         dcount <= ( others => '0' ) ;
		         c := '0' ;
		      end if ;
		   elsif start = '1' and start'last_value = '0' then
		      c := '1' ;
		   --elsif start = '0' and start'last_value = '0' and dcount = "111" then
		    --  dcount <= ( others => '0' ) ;
		    --  c := '0' ;      
		   end if ;
		end if ;
		
		cc <= c ;
		
	end process;
	
	eoc <= '1' when ( dcount = "1000" ) else '0' ;
	
end arc_datacounter3;