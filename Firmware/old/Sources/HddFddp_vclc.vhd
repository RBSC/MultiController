----------------------------------------------------------------
-- FDD-IDE firmware v1.00
-- Copyright 2015-2022 (C) RBSC
----------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity HddFddp_vclc is
  port(
    pSltAdr     : IN std_logic_vector(15 downto 0);
	ROMAdr14	: OUT std_logic;
	ROMAdr15	: OUT std_logic;
	ROMAdr16	: OUT std_logic;
	ROMAdr17	: OUT std_logic;
	conf0		: IN std_logic;
	conf1		: IN std_logic;
	conf2		: IN std_logic;
    pSltDat     : INOUT std_logic_vector(7 downto 0);
    pIDEAdr		: OUT std_logic_vector(2 downto 0);
    pIDEDat		: INOUT std_logic_vector(15 downto 0);
    WDCReset	: OUT std_logic;
	pIDECS1_n	: OUT std_logic;
	pIDECS3_n	: OUT std_logic;
	pIDERD_n	: OUT std_logic;
	pIDEWR_n	: OUT std_logic;
    pSltRd_n    : IN std_logic;	
    pSltRst_n   : IN std_logic;
    pSltCLC		: IN std_logic;    
    ROMCs_n		: OUT std_logic;  
    ROMWe_n		: OUT std_logic;  
    pSltSltsl_n : IN std_logic;
    WDCCs_n		: OUT std_logic;  
    WDCLDOR_n	: OUT std_logic;  
	pSltWr_n    : IN std_logic    
  );
end HddFddp_vclc;

architecture RTL of HddFddp_vclc is



--  signal pSltClk_n   : std_logic;
  signal cReg	     : std_logic_vector(7 downto 0);
  signal ExpSltReg   : std_logic_vector(7 downto 0);
  signal DecExp1s0     : std_logic;
  signal DecExp0s1     : std_logic;
  signal DecExp1s1     : std_logic;
  signal DecExp1s2     : std_logic;
  signal DecExp0s2     : std_logic;
  signal IDEReg        : std_logic;
  signal IDEsOUT	   : std_logic_vector(7 downto 0);
  signal IDEsIN		   : std_logic_vector(7 downto 0);
--  signal expFlash	   : std_logic;
--  signal expEnCount	   : std_logic_vector(1 downto 0);
  signal DecIDEconf    : std_logic;
  signal CLC_n		   : std_logic;
  signal RD_hT1	   : std_logic;
  signal RD_hT2	   : std_logic;
--  signal RD_hT3	   : std_logic;
  signal WR_hT1    : std_logic;
  signal WR_hT2    : std_logic;
--  signal pSltWr	   : std_logic;
  signal rdtn	   : std_logic;
--  signal CLCcount  : std_logic_vector(15 downto 0);
--  signal countRun  : std_logic;
  signal FDDregDec    : std_logic;
--  signal DecSccA     : std_logic;
--  signal DecSccB     : std_logic;


begin

  ----------------------------------------------------------------
  -- Dummy pin
  ----------------------------------------------------------------
  


  ----------------------------------------------------------------
  -- Expand slot decoding
  ----------------------------------------------------------------
  -- 0000h-3FFFh
  DecExp1s0 <= '1' when pSltSltsl_n = '0' and pSltAdr(15 downto 14) = "00" and ExpSltReg(1 downto 0) = "0" & (not conf1)
			       else '0';
  -- 4000h-7FFFh
  DecExp0s1 <= '1' when pSltSltsl_n = '0' and pSltAdr(15 downto 14) = "01" and ExpSltReg(3 downto 2) = "0" & conf1
			       else '0';
  DecExp1s1 <= '1' when pSltSltsl_n = '0' and pSltAdr(15 downto 14) = "01" and ExpSltReg(3 downto 2) = "0" & (not conf1)
			       else '0';
  -- 8000h-BFFFh
  DecExp1s2 <= '1' when pSltSltsl_n = '0' and pSltAdr(15 downto 14) = "10" and ExpSltReg(5 downto 4) = "0" & (not conf1)
			       else '0';
  DecExp0s2 <= '1' when pSltSltsl_n = '0' and pSltAdr(15 downto 14) = "10" and ExpSltReg(5 downto 4) = "0" & conf1
			       else '0';			       
  DecIDEconf <= '1' when DecExp0s1 = '1' and pSltAdr(15 downto 0) = "0100000100000100" 
                   else '0';
  ----------------------------------------------------------------
  -- Adapt timing
  ----------------------------------------------------------------
  CLC_n		<= not pSltCLC;
--  pSltWr	<= not pSltWR_n;
--  rdtn		<= '0' when ((pSltRst_n = '1' and pSltRd_n = '0') and pSltSltsl_n = '0') and pSltWr_n = '1'
--               else '1';
  process(pSltRst_n, CLC_n, pSltRd_n)
  begin
 --   if (pSltRst_n = '0') then
---    if (RD_hT2 = '0') then
---      if (pSltRd_n = '0' and CLC_n = '0' and IDEReg = '1' and (pSltAdr(9) = '1' or pSltAdr(0) = '0')) then 
---        RD_hT1 <= '1';
---      end if;
---    elsif (pSltRd_n'event and pSltRd_n = '1') then
---     if(RD_hT2 = '1') then
---        RD_hT1 <= '0';
---     end if;
---    end if;
    if (pSltRd_n = '1') then
      RD_hT1 <= '0';
    elsif (RD_hT2 = '0') then
      if (pSltRd_n = '0' and CLC_n = '0' and IDEReg = '1' and (pSltAdr(9) = '1' or pSltAdr(0) = '0')) then
        RD_hT1 <= '1';
      end if;
    end if;
--    if (pSltRst_n = '0') then
--      RD_hT2 <= '0';
--    elsif (CLC_n'event and CLC_n = '1') then
    if (CLC_n'event and CLC_n = '1') then
      RD_hT2 <= not pSltRd_n;
    end if;
  end process;
  
    process(pSltRst_n, CLC_n)
  begin
    if (pSltRst_n = '0') then
      WR_hT2 <= '0';
    elsif (CLC_n'event and CLC_n = '0') then
      WR_hT2 <= WR_hT1;
    end if;
  end process;
  
 
  process(pSltWr_n,WR_hT2)
  begin
 --   if (WR_hT2 = '0') then
 --     if (pSltWr_n = '0' and IDEReg = '1' and (pSltAdr(9) = '1' or pSltAdr(0) = '1')) then
 --       WR_hT1 <= '1';
 --     end if;
 --   elsif (pSltWr_n'event and pSltWr_n = '1') then
 --     if (WR_hT2 = '1') then
 --       WR_hT1 <= '0';
 --     end if;
 --   end if;
    if (pSltWr_n = '1') then
      WR_hT1 <= '0';
    elsif (WR_hT2 = '0') then
      if (pSltWr_n = '0' and IDEReg = '1' and (pSltAdr(9) = '1' or pSltAdr(0) = '1')) then
        WR_hT1 <= '1';
      end if;
    end if;
        
  end process;
   ----------------------------------------------------------------
  -- Set Register
  ----------------------------------------------------------------
  process(pSltRst_n, pSltWr_n)
  begin

    if (pSltRst_n = '0') then

      ExpSltReg		<= "00000000";
      cReg			<= "00000000";
     
    elsif (pSltWr_n'event and pSltWr_n = '0') then

	  -- Expand Slot Register
      if (pSltSltsl_n = '0' and pSltAdr(15 downto 0) = "1111111111111111" and
          conf0 = '0') then
        ExpSltReg <= pSltDat;
      end if;
	  -- Config IDE Sunrise Register
      if (DecIDEconf = '1') then
        cReg <= pSltDat;
      end if;

    end if;
  end process;
  
  ----------------------------------------------------------------
  -- FDD WDC controler decoder
  ---------------------------------------------------------------- 
  
  FDDregDec		<= '1' when DecExp1s1 = '1' and  pSltAdr(13 downto 2) = "111111111100" -- 3FF(0/1/2/3)
                       else '0';
  WDCReset 		<= '1' when pSltRst_n = '0' 
					   else '0';
  WDCCs_n		<= '0' when ((DecExp1s2 = '1' or DecExp1s0 = '1') and pSltAdr(13 downto 12) = "00") or 
                            (FDDregDec = '1' and pSltAdr(1) = '0')
                       else '1';
  WDCLDOR_n     <= '0' when ((DecExp1s2 = '1' or DecExp1s0 = '1') and pSltAdr(13 downto 12) = "01") or 
                            (FDDregDec = '1' and pSltAdr(1) = '1')
                       else '1';
                 
  ----------------------------------------------------------------
  -- ROM decoder
  ---------------------------------------------------------------- 
  
 -- ROMReset_n	<= pSltRst_n;

  ROMCs_n		<= '0' when ((DecExp1s1 = '1' and FDDregDec = '0') or DecExp0s1 = '1' or (DecExp0s2 = '1' and pSltRd_n = '1'--and expFlash = '1'
                                                                                     )) and IDEReg = '0'
					   else '1';
  ROMAdr14		<= cReg(7) when DecExp1s1 = '0' 
						   else '1';            -- fdd rom 1C000-1FFFF
  ROMAdr15		<= cReg(6) when DecExp1s1 = '0' 
						   else '1';            -- fdd rom
  ROMAdr16      <= cReg(5) when DecExp1s1 = '0' 
						   else '1';            -- fdd rom
  ROMAdr17		<= cReg(4) or conf2 when DecExp1s1 = '0' -- and expFlash = '1' -- Expand Flash
						   -- else conf2   when DecExp1s1 = '0'
						   else '0';            -- fdd rom  

  ROMWe_n  		<= '0' when DecExp0s2 = '1' and WR_hT1 = '1' -- pSltWr_n = '0' -- and expFlash = '1'
					   else '1'; 						   
  ----------------------------------------------------------------
  -- IDE Processing
  ---------------------------------------------------------------- 
 
  IDEReg 		<= '0' when	pSltAdr(9 downto 8) = "11"
					   else '1' when DecExp0s1 = '1' and cReg(0) = '1' and pSltAdr(13 downto 10) = "1111" -- 7C00h-7FEFh
					   else '0';
  process(IDEReg, RD_hT1)
  begin
    if (CLC_n'event and CLC_n = '0') then
      if (IDEReg = '1' and pSltAdr(9) = '0' and  pSltAdr(0) = '0' and pSltRd_n = '0' and RD_hT2 = '1') then 
        IDEsIN <=  pIDEDat(15 downto 8);	
      end if;
    end if;    
  end process;
  process(IDEReg)
  begin
    if (IDEReg = '1' and pSltAdr(9) = '0' and pSltWr_n = '0' and pSltAdr(0) = '0') then 
      IDEsOUT <=  pSltDat;	
  end if;   
  end process; 
  pIDEDat(15 downto 8) 	<= 	pSltDat when IDEReg = '1' and pSltAdr(9) = '1' and RD_hT1 = '0' 
                                         -- and RD_hT2 = '0' 
                                         and pSltRd_n = '1'
                            else pSltDat when IDEReg = '1' and RD_hT1 = '0' 
                                         -- and RD_hT2 = '0' 
                                         and pSltRd_n = '1' 
							else (others => 'Z');
  pIDEDat(7 downto 0) 	<= 	pSltDat when IDEReg = '1' and pSltAdr(9) = '1' and RD_hT1 = '0' 
                                         -- and RD_hT2 = '0' 
                                         and pSltRd_n = '1' 
							else IDEsOUT when IDEReg = '1' and pSltAdr(9) = '0' and pSltAdr(0) = '1' 
							                  and RD_hT1 = '0' -- and RD_hT2 = '0' -- and pSltRd_n = '1'
							else (others => 'Z');  
 
  pIDEAdr		<= pSltAdr(2 downto 0) when pSltAdr(9) = '1'
                   else "000";
  pIDECS1_n		<= pSltAdr(3) when pSltAdr(9) = '1'
				   else '0';
  pIDECS3_n		<= not pSltAdr(3) when pSltAdr(9) = '1'
				   else '1';
--  pIDERD_n		<= '0' when IDEReg = '1' and (pSltAdr(9) = '1' or pSltAdr(0) = '0') and RD_hT1 = '1' -- and pSltRd_n = '0' 
--				   else '1';
--  pIDEWR_n		<= '0' when IDEReg = '1' and (pSltAdr(9) = '1' or pSltAdr(0) = '1') and WR_hT1 = '1' -- and pSltWr_n = '0'
--				   else '1';
  pIDERD_n		<= not RD_hT1;
  pIDEWR_n		<= not WR_hT1;
    ----------------------------------------------------------------
  -- Read DATA
  ---------------------------------------------------------------- 
  
  pSltDat	<= not ExpSltReg when pSltSltsl_n = '0' and pSltAdr(15 downto 0) = "1111111111111111" and 
				                  conf0 = '0' and pSltRd_n = '0' -- and RD_hT1 ='1' 
                                    
  			else IDEsIN      when IDEReg = '1' and pSltAdr(9) = '0' and pSltAdr(0) = '1'
  			                                   and pSltRd_n = '0' -- and RD_hT1 = '1' 
			else pIDEDat(7 downto 0) when IDEReg = '1' and (pSltAdr(0) = '0' or pSltAdr(9) = '1') 
			                              and  pSltRd_n = '0' -- and RD_hT1 = '1'
			else (others => 'Z');  


end RTL;
