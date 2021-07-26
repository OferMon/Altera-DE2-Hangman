library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
USE ieee.numeric_std.all ;

entity wgame is

	port ( resetN : in  std_logic ;
	       clk : in  std_logic ;
		   check : in  std_logic ;
		   activec : out std_logic ;
		   endcheck : out std_logic ;
		   din : in std_logic_vector(0 to 7) ;
		   mistakes : buffer std_logic_vector(2 downto 0) ;
		   dout : out std_logic_vector(71 downto 0) ) ;
		   
end wgame;

architecture arc_wgame of wgame is
	
	constant firstletter : std_logic_vector(0 to 7) := "00000000" + character'pos('a') ;
	constant word : string(1 to 4) := "amos" ;
	signal nwin : std_logic := '1';
	
begin
	
	process ( resetN, clk )
	
	variable letter : std_logic_vector(0 to 7) ;
	variable ss : std_logic_vector(0 to 7) ;
	variable mist : std_logic ;
	variable xxx : std_logic_vector(71 downto 0) ;
	variable usedletters : std_logic_vector(0 to 25) ;
	variable zxc : std_logic_vector(2 downto 0) := "111" ;
	
	begin
		
		mist := '0'; 
		xxx := "000000000000000000000000000000000000000000000000000000000000000000000000" ;
		if resetN = '0' then
		   dout <= (others => '0') ;
		   usedletters := "00000000000000000000000000" ;
		   endcheck <= '0' ;
		   mistakes <= "111";
		   zxc := "111";
		   nwin <= '1';
		elsif rising_edge(clk) then
		   nwin <= '0';
           if check = '1' then
	          ss := din - firstletter ;
			  usedletters(to_integer(unsigned(ss))) := '1' ;
			  for i in 1 to word'length loop
	              letter := "00000000" + character'pos(word(i)) ;
	              ss := letter - firstletter ;
	              if usedletters(to_integer(unsigned(ss))) = '1' then
	                 xxx := letter & xxx(71 downto 8);
	              else
	                 xxx := ("00000000" + character'pos('_')) & xxx(71 downto 8);
	                 nwin <= '1' ;
	              end if ;
	              xxx := ("00000000" + character'pos(' ')) & xxx(71 downto 8);
	          end loop ;
	          xxx := ("00000000" + character'pos(LF)) & xxx(71 downto 8);
		      dout <= xxx ;
			  endcheck <= '1' ;
			  for i in 1 to word'length loop
			      letter := "00000000" + character'pos(word(i)) ;
			      if letter = din then
			         mist := '1'; 
			      end if;
			  end loop;
			  if mist = '0' then
					zxc := std_logic_vector(unsigned(zxc) / 2) ;
			  end if;
		   else 
	          for i in 1 to word'length loop
	              letter := "00000000" + character'pos(word(i)) ;
	              ss := letter - firstletter ;
	              if usedletters(to_integer(unsigned(ss))) = '1' then
	                 xxx := letter & xxx(71 downto 8);
	              else
	                 xxx := ("00000000" + character'pos('_')) & xxx(71 downto 8);
	                 nwin <= '1' ;
	              end if ;
	              xxx := ("00000000" + character'pos(' ')) & xxx(71 downto 8);
	          end loop ;
	          xxx := ("00000000" + character'pos(LF)) & xxx(71 downto 8);
		      dout <= xxx ;
			  endcheck <= '0' ;
	       end if;
	       mistakes <= zxc ;
		end if;
		
	end process ;
	
	activec <= '0' when (mistakes = "000" or nwin = '0') else '1' ;
	
end arc_wgame;