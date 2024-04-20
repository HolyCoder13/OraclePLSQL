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