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
