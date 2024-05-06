drop table pracownicy_am;
create table pracownicy_am as
select * from hr.employees;
SET SERVEROUTPUT ON;
--1
declare 
v_liczba number;
begin
v_liczba := ('&liczba');
if mod(v_liczba,4) = 0 THEN
DBMS_OUTPUT.PUT_LINE('Liczba podzielna przez 4');
else
DBMS_OUTPUT.PUT_LINE('Liczba nie jest podzielna przez 4');
end if;
end;
/
--2
declare 
v_liczba number;
wynik number;
begin
v_liczba := ('&liczba');
if v_liczba > 0 AND v_liczba < 5 THEN
wynik := 3*v_liczba - 2;
DBMS_OUTPUT.PUT_LINE('Wynik to: '||wynik);
else
wynik := 5*v_liczba + 1;
DBMS_OUTPUT.PUT_LINE('Wynik to: '||wynik);
end if;
end;
/
--3
declare
v_stanowisko varchar;
v_podwyzka number; 

v_imie pracownicy_am.first_name%TYPE;
v_nazw pracownicy_am.last_name%TYPE;
v_salary pracownicy_am.salary%TYPE;

cursor c is 
select first_name, last_name, job_id, salary
from pracownicy_am where job_id = v_stanowisko;

r_p c%ROWTYPE;
begin
v_stanowisko :='&stanowisko';
v_podwyzka :='&podwyzka';
open c;
loop
    FETCH c in r_p;
    EXIT WHEN c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Przed podwyzk¹ dla pracownikow: '|| r_p.first_name||' '||r_p.last_name||' '||r_p.salary);
end loop;
close c;
    UPDATE pracownicy_am set salary = salary + v_podwyzka WHERE job_id = v_stanowisko;
     Select first_name, last_name, salary INTO v_imie, v_nazw, v_salary from pracownicy_am where job_id = v_stanowisko;
    DBMS_OUTPUT.PUT_LINE('Po podwy¿ce dla pracowników '||v_imie' '||v_nazw||' '||v_salary);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Nie znaleziono stanowiska o podanym identyfikatorze');
    end;
end;
/
select * from pracownicy_am order by hire_date desc;
--4
declare 
cursor c is
select first_name, last_name, hire_date 
from pracownicy_am
order by hire_date desc;
r_p c%ROWTYPE;
begin
    open c;
    LOOP
    FETCH c into r_p;
    exit when c%ROWCOUNT > 5;
    DBMS_OUTPUT.PUT_LINE(r_p.first_name||' '||r_p.last_name||' '||r_p.hire_date);
end loop;
close c;
end;
--5
/
declare 
v_rok number;
cursor c is
select first_name, last_name, hire_date 
from pracownicy_am where hire_date > v_rok
for update;
r_p c%ROWTYPE;
begin
v_rok := '&Rok zatrudnienia';
    open c;
    LOOP
    FETCH c into r_p;
    exit when c%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Pracownicy do usuniecia zatrudnieni po: '||v_rok||' roku '||r_p.first_name||' '||r_p.last_name||' '||r_p.hire_date);
end loop;
DELETE * from pracownicy_am where hire_date > v_rok;
close c;
end;

