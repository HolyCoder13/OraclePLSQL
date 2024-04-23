SET SERVEROUTPUT ON;
declare
  cursor cur_programisci is 
    select first_name, last_name, hire_date, job_id from hr.employees where job_id='IT_PROG';
    
  v_imie hr.employees.first_name%TYPE;  
  v_nazwisko hr.employees.last_name%TYPE;
  v_data_zatr hr.employees.hire_date%TYPE;
  v_stanowisko hr.employees.job_id%TYPE;
begin
  open cur_programisci; --otwarcie kursora
  loop  --pobieranie danych, przetwarzanie
   fetch cur_programisci into v_imie, v_nazwisko, v_data_zatr, v_stanowisko;
   exit when cur_programisci%NOTFOUND;
   dbms_output.put_line('Programista '||v_imie||' '||v_nazwisko||' pracuje od '||v_data_zatr||' na stanowisku '||v_stanowisko||'.');
  end loop; 
  close cur_programisci; --zamkniecie kursora
end;
/
declare
    cursor cur_best_paid is
    select first_name, last_name, salary from hr.employees
    order by salary desc;
    imie hr.employees.first_name%TYPE;
    nazwisko hr.employees.last_name%TYPE;
    pensja hr.employees.salary%TYPE;
begin
    open cur_best_paid;
    loop
    fetch cur_best_paid into imie, nazwisko, pensja;
    exit when cur_best_paid%NOTFOUND or cur_best_paid%ROWCOUNT > 5;
    dbms_output.put_line(imie||' '||nazwisko||' '||pensja);
    end loop;
    close cur_best_paid;
end;    


SET SERVEROUT ON
--Napisz program wyswietlajacy imie i nazwisko pracownika z dzialu 60. 
--Bez kursorow (wykorzystaj select ...into). Obsluz bledy.

declare
 v_imie pracownicy_jw.first_name%TYPE;
 v_nazwisko pracownicy_jw.last_name%TYPE;
begin
 select first_name, last_name into v_imie, v_nazwisko from pracownicy_jw where department_id=4000;
 dbms_output.put_line(v_imie||' '||v_nazwisko);
exception
 when NO_DATA_FOUND then dbms_output.put_line('Brak pracowników w dziale.'); --raise_application_error(-20001,'Brak pracowników w dziale 60.' );
 when TOO_MANY_ROWS then dbms_output.put_line('Wi?cej ni? jeden pracownik w dziale.');--raise_application_error(-20002,'Wi?cej ni? jeden pracownik w dziale 60.' );
 when OTHERS then dbms_output.put_line('Wystapil inny blad.'); --raise_application_error(-20003,'Wystapil inny blad.' );
end;

--1
declare
    cursor cur_man is
        select employee_id, salary from pracownicykm where job_id like '%MAN' for update;
    v_salary number(10,2);
begin
    for v_man in cur_man loop
        select sum(salary) into v_salary from pracownicykm
        where manager_id=v_man.employee_id;
        if v_salary*0.1+v_man.salary > 15000 then
            raise_application_error(-20009,'Salary too high');
        else
            update pracownicykm set salary=salary+v_salary*0.1 where current of cur_man;
        end if;
    end loop;
end;
--2 bez EXCEPTION
declare
 cursor cur_prac(p_etat varchar2) is   --kursor z parametrem p_etat
 select last_name from pracownicy_jw where job_id=p_etat;
 v_etat pracownicy_jw.job_id%TYPE :='&id_etatu';
 brak_pracownikow boolean :=true;  --sprawdza czy petla for z kursorem sie wykona
begin
 for r_prac in cur_prac(v_etat) 
  loop
    dbms_output.put_line(r_prac.last_name);
    brak_pracownikow :=false;
  end loop; 
if brak_pracownikow then dbms_output.put_line('Brak pracownika na etacie.'); --raise_application_error(-20002,'Brak pracownika na etacie.' );
end if;
end;
--
declare
 cursor cur_prac(p_etat varchar2) is   --kursor z parametrem p_etat
 select last_name from pracownicy_jw where job_id=p_etat;
 v_etat pracownicy_jw.job_id%TYPE :='&id_etatu';

 e_brak_prac EXCEPTION;
 PRAGMA exception_init(e_brak_prac, -20001);
 
 v_ile number;

begin
select count(*) into v_ile from pracownicy_jw where job_id=v_etat;
if v_ile=0 
then raise e_brak_prac;
else
for r_prac in cur_prac(v_etat) 
  loop
    dbms_output.put_line(r_prac.last_name);
  end loop;  
end if;
exception
   when e_brak_prac THEN
        dbms_output.put_line('Brak pracownikow na etacie ' || v_etat);
end;
--4   --kursory niejawne
declare
  e_brak_wynikow EXCEPTION;  --deklaracja wyjatku(bledu) uzytkownika
  v_rok number(4):=2000;
begin
 delete from pracownicy_jw where to_char(hire_date, 'YYYY')< v_rok;
 if SQL%ROWCOUNT=0 then raise e_brak_wynikow;
 end if;
exception
  when e_brak_wynikow then dbms_output.put_line('Brak pracownikow zatrudnionych poni?ej danego roku'); --raise_application_error(-20002,'Brak pracownikow zatrudnionych poni?ej danego roku.' );
end;

--inny sposob
declare
  v_rok number(4):=2000;
begin
 delete from pracownicy_jw where to_char(hire_date, 'YYYY')< v_rok;
 if SQL%FOUND 
 then dbms_output.put_line('Usunietych rekordów: '||SQL%ROWCOUNT); 
 else raise_application_error(-20002,'Brak rekordow do usuniecia.' ); 
 end if;
end;



