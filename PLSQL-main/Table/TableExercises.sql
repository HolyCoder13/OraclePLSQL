declare
type tablica is table of varchar(1000)
index by binary_integer;
liczba_wypelnionych number :=0;
moja_tablica tablica;
begin
for i in 1..979 loop
moja_tablica(i):='null'||i;
end loop;
for j in moja_tablica.first..moja_tablica.last loop
    if moja_tablica(j) is not null then
    liczba_wypelnionych:=liczba_wypelnionych+1;
	end if;
end loop;
dbms_output.put_line('liczba pol w tablicy wypelnionych '|| liczba_wypelnionych);
end;