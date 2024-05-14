create or replace procedure dzielenie(liczbaA number, liczbaB number)
is
  wlasny_wyjatek exception;
begin
  if liczbaA = LiczbaB then raise wlasny_wyjatek;
end if;

dbms_output.put_line('Wynik dzielenia a przez b to '||liczbaA/liczbaB);
dbms_output.put_line('Wynik dzielenia b przez a to '||liczbaB/liczbaA);

exception 
  when ZERO_DIVIDE then
    dbms_output.put_line('Nastapilo dzielenie przez 0! ');
  when wlasny_wyjatek then
    dbms_output.put_line('Obydwie liczba sa takie same! ');
end;

--wywolanie gornej procedury z wyjatkami
begin
dzielenie(10,2);
dzielenie(0,10);
dzielenie(5,5);
end;


