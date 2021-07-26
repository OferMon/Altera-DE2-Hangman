library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity datacounter2 is

	port ( resetN     : in    std_logic 				   ;
		   clk 	      : in    std_logic 				   ;
	       eoc        : out   std_logic                    ;
		   dcount     : inout std_logic_vector(3 downto 0) ) ;
		   
end datacounter2;

architecture arc_datacounter2 of datacounter2 is

begin

	process ( resetN, clk )
	
	begin
	
		if resetN = '0' then
		   dcount <= ( others => '0' ) ;
		elsif rising_edge(clk) then
		   if dcount < "1000" then
		      dcount <= dcount + 1;
		   end if ;
		end if ;
		
	end process;
	
	eoc <= '1' when ( dcount = "1000" ) else '0' ;
	
end arc_datacounter2;