CREATE OR REPLACE FUNCTION SILNIA 
(
  P_LICZBA IN NUMBER 
) RETURN NUMBER AS 
v_result number;
BEGIN
v_result :=1;
    for i in 1..p_liczba loop
    v_result:=v_result*i;
    end loop;
  RETURN v_result;
END SILNIA;