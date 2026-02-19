-- *******************************************************
-- ** Pargen, parity bit is odd (1) if the parity is odd *
-- ** If the parity is even parity bit is even (0)       *
-- *******************************************************

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.subprog_pck.all;

entity pargen_modified is 
    generic (
        WIDTH : integer := 16
    );
    port (
        rst_n        : in  std_ulogic;
        mclk         : in  std_ulogic;
        indata1      : in  std_ulogic_vector(WIDTH-1 downto 0);
        indata2      : in  std_ulogic_vector(WIDTH-1 downto 0);
        par          : out std_ulogic
    );
end pargen_modified;

architecture rtl of pargen_modified is 
    signal toggle_parity, xor_parity, combined_parity : std_ulogic;
begin  
    --Method 1: parity toggle, using for, loop and variables.
    toggle_parity <= p_toggle(indata1);

    -- Method: 2 parity using xor function (VHDL 2008)
    xor_parity <= xor(indata2);  -- Cascaded XORs 

    -- combining parity using the xor operator 
    combined_parity <= toggle_parity xor xor_parity; 
  
    -- clocked process for creating stable and synchronized output
    process (mclk) is    
    begin
        if rising_edge(mclk) then 
            par <= 
                '0' when rst_n = '0' else 
                combined_parity ;
        end if;
    end process;
end rtl;
