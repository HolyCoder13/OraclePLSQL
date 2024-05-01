SET SERVEROUTPUT ON;
DECLARE
    CURSOR prog_cursor IS
        SELECT first_name, last_name, hire_date
        FROM hr.employees
        WHERE job_id = 'IT_PROG';
    
    c_prog prog_cursor%ROWTYPE;
BEGIN
    OPEN prog_cursor;
    
    LOOP
        FETCH prog_cursor INTO c_prog;
        EXIT WHEN prog_cursor%ROWCOUNT > 5 OR prog_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(c_prog.first_name || ' ' || c_prog.last_name || ' ' || c_prog.hire_date);
    END LOOP;
    
    CLOSE prog_cursor;
END;
/
Declare
    cursor c_best_paid IS
    Select first_name, last_name, salary from hr.employees 
    order by salary desc;
    
    best_paid c_best_paid%ROWTYPE;
BEGIN
    OPEN c_best_paid;
    LOOP
    FETCH c_best_paid INTO best_paid;
    EXIT WHEN c_best_paid%ROWCOUNT > 5 OR c_best_paid%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('imie '||best_paid.first_name||' nazwisko '||best_paid.last_name||' pensja '||best_paid.salary);
END LOOP;
close c_best_paid;
END;
/
declare
 n number;
 potega number :=1;
begin
 n:= &n;
 for i in 1..n loop
  potega := potega * 3;
  end loop;
  dbms_output.put_line(potega);
  end;
  /
declare 
cursor cur_p is
select job_id from pracownicy_am;
begin
for v_prac in cur_p
loop
if v_prac.job_id = 'IT_PROG' then
update pracownicy_am set salary = salary + 100;
elsif v_prac.job_id like '%MAN%' then update pracownicy_am 
set salary=salary*1.1;
end if;
end loop;
end;
/
--8
declare
cursor c is
select employee_id, first_name, last_name
from pracownicy_am
where to_char(hire_date,'yyyy')<2003;
r_pracownicy c%ROWTYPE;
v_count number;
begin
select count(*) into v_count
from pracownicy_am 
where to_char(hire_date,'YYYY') <2003;
dbms_output.put_line('usunietych '||v_count);
open c;
loop
fetch c into r_pracownicy;
exit when c%NOTFOUND;
dbms_output.put_line(r_pracownicy.employee_id||r_pracownicy.first_name
||r_pracownicy.last_name);
end loop;
close c;
delete from pracownicy_am where to_char(hire_date,
'YYYY')<2003;
end;
/
--
CREATE TABLE departamenty_am AS
SELECT * 
FROM hr.departments;
drop table pracownicy_am;
CREATE TABLE pracownicy_am AS
SELECT * 
FROM hr.employees;
--7
declare
cursor c is
select count(employee_id) as liczba, department_name
from pracownicy_am join departamenty_am 
using(department_id)
group by department_name;
r_p c%ROWTYPE;
v_c number;
begin
 open c;
 loop
    fetch c into r_p;
    exit when c%NOTFOUND;
    dbms_output.put_line('w dep'||r_p.department_name
    ||' pracuje '||r_p.liczba);
 end loop;
 close c;
end; 
/
select * from pracownicy_am;
/
set serveroutput on;

declare
cursor c is
select count(employee_id) as liczba , department_name 
from pracownicy_am join departamenty_am 
using (department_id)
group by department_name;
r_p c%ROWTYPE;
begin
open c;
loop
fetch c into r_p;
dbms_output.put_line('w depratamencie '||r_p.department_name||' pracuje '
||r_p.liczba);
exit when c%NOTFOUND;
end loop;
close c;
end;
/

declare
cursor c is
select employee_id, first_name, last_name from
pracownicy_am where to_char(hire_date,'yyyy')<2003; 
r_p c%ROWTYPE;
begin
loop
fetch c into r_p;
exit when c%NOTFOUND;
end loop;
close c;
delete from pracownicy_am where to_char(hire_date,'yyyy')<2003;
end;
/

set serveroutput on;
declare
cursor c is
select employee_id, first_name, last_name
from pracownicy_am
where to_char(hire_date,'yyyy')<2003;
r_p c%ROWTYPE;
liczba number;
begin
select count(*) into liczba from pracownicy_am where
to_char(hire_date,'yyyy')<2003;
dbms_output.put_line('usunietych '||liczba);
open c;
loop
fetch c into r_p;
exit when c%NOTFOUND;
dbms_output.put_line(r_p.employee_id||r_p.first_name
||r_p.last_name);
end loop;

close c;
delete from pracownicy_am where to_char(hire_date,
'YYYY')<2003;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No records found.');
end;
/
select * from pracownicy_am;
DECLARE
v_id pracownicy_am.job_id%TYPE;
    v_bonus NUMBER;
   
BEGIN
     CURSOR c IS
        SELECT first_name, last_name, commission_pct, job_id
        FROM pracownicy_am
        WHERE job_id = v_id;
r_p c%ROWTYPE;
    v_id := UPPER('&job_id');
    open c;
    loop
    fetch c into r_p;
        IF r_p.commission_pct IS NOT NULL THEN
            v_bonus := r_employee.commission_pct * 100;
            DBMS_OUTPUT.PUT_LINE('Pracownik ' || r_employee.first_name || ' ' || r_employee.last_name || ' posiada premi? w wysoko?ci ' || v_bonus || '%');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Pracownik ' || r_employee.first_name || ' ' || r_employee.last_name || ' nie posiada premii');
        END IF;
    END LOOP;
    close c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Brak pracowników dla stanowiska!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Wyst?pi? inny b??d!');
END;
/
--5
SET SERVEROUTPUT ON
DECLARE
    v_id pracownicy_am.job_id%TYPE;
    v_bonus pracownicy_am.commission_pct%TYPE;    
    CURSOR c IS
        SELECT *
        FROM pracownicy_am
        WHERE job_id = v_id;
    r_p pracownicy_am%ROWTYPE;
BEGIN
    v_id := UPPER('&job_id');
    OPEN c;
    LOOP
        FETCH c INTO r_p;
        EXIT WHEN c%NOTFOUND;
        IF r_p.commission_pct IS NOT NULL THEN
            v_bonus := r_p.commission_pct * 100;
            DBMS_OUTPUT.PUT_LINE('Pracownik ' || r_p.first_name
            || ' ' || r_p.last_name || ' posiada premi? w wysoko?ci ' || v_bonus || '%');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Pracownik ' || r_p.first_name
            || ' ' || r_p.last_name || ' nie posiada premii');
        END IF;
    END LOOP;
    CLOSE c;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Brak pracowników dla stanowiska!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Wyst?pi? inny b??d!');
END;
/
SET SERVEROUTPUT ON;
declare 
cursor c is
select first_name, last_name, hire_date
from pracownicy_am where job_id like 'IT_PROG';
r_p c%ROWTYPE;
begin
open c;
loop
fetch c into r_p;
exit when c%NOTFOUND;
dbms_output.put_line(r_p.first_name||' '||
r_p.last_name||' '||
r_p.hire_date);
end loop;
close c;
end;
/
select * from pracownicy_am;
/
declare
cursor c is
select first_name, last_name, salary from
pracownicy_am order by salary desc;
r_p c%ROWTYPE;
begin
open c;
loop
fetch c into r_p;
dbms_output.put_line(r_p.first_name||' '
||r_p.last_name||' '||r_p.salary);
exit when c%ROWCOUNT > 5;
end loop;
close c;
end;
/
declare 
n number;
potega number := 1;
begin
n := &n;
for i in 1..n loop
potega := potega * 3;
dbms_output.put_line(potega);
end loop;
end;
/
--4
declare 
cursor c is
select first_name, last_name, salary 
from pracownicy_am where job_id = 'IT_PROG';
r_p c%ROWTYPE;
begin
update pracownicy_am 
set salary = salary+100 
where job_id = 'IT_PROG';
open c;
loop
fetch c into r_p;
exit when c%NOTFOUND;
dbms_output.put_line('Po zmianie :' ||r_p.first_name||
' '||r_p.last_name||' '|| r_p.salary);
end loop;
close c;
end;
/
--5
declare 
v_l char(1);
cursor c is
select FIRST_name, last_name, job_id
from pracownicy_am WHERE 
UPPER(SUBSTR(last_name, 1, 1)) = UPPER(v_l);
r_p c%ROWTYPE;
begin
 v_l := UPPER(SUBSTR('&Podaj_litere_nazwiska_pracownika', 1, 1));
 open c;
 loop
 fetch c into r_p;
DBMS_OUTPUT.PUT_LINE(r_p.last_name || ' ' ||
                     r_p.first_name || ' ' ||
                     r_p.job_id);
exit when c%NOTFOUND;
end loop;
close c;
end;











