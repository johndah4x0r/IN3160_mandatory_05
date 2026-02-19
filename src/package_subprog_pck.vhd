library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package subprog_pck is
    function p_toggle(indata : std_ulogic_vector) return std_ulogic;
end package ; -- subprog_pck 

package body subprog_pck is
    function p_toggle (indata : std_ulogic_vector) return std_ulogic is
        variable result : std_ulogic;
    begin
        result := '0';
        for i in indata'range loop
            if indata(i) = '1' then
                result := not result;
            end if;
        end loop;
        return result;
    end function p_toggle;
end package body subprog_pck;