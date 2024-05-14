create or replace procedure info
(name IN varchar2, lastname IN varchar2, height OUT number)
is
begin
dbms_output.put_line('Hello '||name||' '||lastname);
height:=180;
end;

declare
variable number;
begin
variable:=1;
info('Adrian','M',variable);
dbms_output.put_line('Your height is: '||variable);
end;


declare
  variable2 number;
begin
  variable2:=1;
info(lastname =>'M', height=>variable2, name=>'Adrian');
dbms_output.put_line('Your height is '||variable2);
end;


declare
  counter number(5);
begin
  counter:=1;
loop
  dbms_output.put_line('Im looping ');
  counter:=counter+1; 
exit when counter>7;
end loop;
end;

