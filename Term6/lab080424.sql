SET SERVEROUT ON
declare
  cursor cur_programisci is 
    select first_name, last_name, hire_date, job_id from pracownicy_jw where job_id='IT_PROG';
    
  v_imie pracownicy_jw.first_name%TYPE;  
  v_nazwisko pracownicy_jw.last_name%TYPE;
  v_data_zatr pracownicy_jw.hire_date%TYPE;
  v_stanowisko pracownicy_jw.job_id%TYPE;
begin
  open cur_programisci;
  loop 
   fetch cur_programisci into v_imie, v_nazwisko, v_data_zatr, v_stanowisko;
   exit when cur_programisci%NOTFOUND;
   dbms_output.put_line('Programista '||v_imie||' '||v_nazwisko||' pracuje od '||v_data_zatr||' na stanowisku '||v_stanowisko||'.');
  end loop; 
  close cur_programisci; 
end;
/
DECLARE
    CURSOR cur_top_earning_employees IS
        SELECT first_name, last_name, salary
        FROM employees
        ORDER BY salary DESC
        FETCH FIRST 5 ROWS ONLY; 
    
    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    OPEN cur_top_earning_employees; 
      
        LOOP
            FETCH cur_top_earning_employees INTO v_first_name, v_last_name, v_salary;
            EXIT WHEN cur_top_earning_employees%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' || v_last_name || ', zarobki: ' || v_salary);
        END LOOP;
   


    CLOSE cur_top_earning_employees;
END;
/
DECLARE
    n NUMBER;
    potega NUMBER := 1;
BEGIN
    n := &n;
    FOR i IN 1..n LOOP
        potega := potega * 3;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Potęga 3 do potęgi ' || n || ' wynosi ' || potega);
END;
/
DECLARE
    CURSOR cur_top_earning_employees IS
        SELECT first_name, last_name, salary
        FROM (SELECT first_name, last_name, salary
              FROM employees
              ORDER BY salary DESC)
        WHERE ROWNUM <= 5;

    v_first_name employees.first_name%TYPE;
    v_last_name employees.last_name%TYPE;
    v_salary employees.salary%TYPE;
    v_count NUMBER := 0; 
BEGIN
    FOR emp_rec IN cur_top_earning_employees LOOP
        v_first_name := emp_rec.first_name;
        v_last_name := emp_rec.last_name;
        v_salary := emp_rec.salary;
        DBMS_OUTPUT.PUT_LINE(v_first_name || ' ' || v_last_name || ', zarobki: ' || v_salary);
        v_count := v_count + 1; 
    END LOOP;

    IF v_count < 5 THEN
        DBMS_OUTPUT.PUT_LINE('Uwaga: Mniej niż 5 pracowników zostało zwróconych.');
    END IF;
END;
/
declare
  cursor cur_prac is select job_id from pracownicy_jw for update of salary;
begin
 for v_prac in cur_prac  -- pętla for nie wymaga otwierania i zamykania kursor
 loop
  if v_prac.job_id='IT_PROG' then update pracownicy_jw set salary=salary+100 where current of cur_prac;
  elsif v_prac.job_id like '%MAN%' then update pracownicy_jw set salary=salary*0.1 where current of cur_prac;
  end if;
 end loop;
end;
/
DECLARE
    v_deleted_count NUMBER := 0;
    CURSOR c_employees IS
        SELECT employee_id, first_name, last_name, department_id, job_id
        FROM employees
        WHERE hire_date < TO_DATE('2003-01-01', 'YYYY-MM-DD');
BEGIN
    -- Usuwanie pracowników zatrudnionych przed 2003 rokiem
    FOR emp IN c_employees LOOP
        DELETE FROM employees WHERE employee_id = emp.employee_id;
        v_deleted_count := v_deleted_count + 1;
    END LOOP;
    
    -- Wyświetlanie liczby usuniętych pracowników
    DBMS_OUTPUT.PUT_LINE('Liczba usuniętych pracowników: ' || v_deleted_count);
    
  
    
END;
/
DECLARE
    v_department_id employees.department_id%TYPE;
    v_job_id employees.job_id%TYPE;
    v_salary_increase NUMBER := 1.15; -- 15% wzrost płacy
    
    CURSOR c_employees(p_department_id NUMBER, p_job_id VARCHAR2) IS
        SELECT employee_id, salary
        FROM employees
        WHERE department_id = p_department_id AND job_id = p_job_id;
BEGIN
    
    v_department_id := &department_id; -- Pobranie działu od użytkownika
    
   
    v_job_id := '&job_id'; -- Pobranie stanowiska od użytkownika
    
 
    FOR emp IN c_employees(v_department_id, v_job_id) LOOP
        UPDATE employees
        SET salary = emp.salary * v_salary_increase
        WHERE employee_id = emp.employee_id;
    END LOOP;
    
  
    DBMS_OUTPUT.PUT_LINE('Płace pracowników na stanowisku ' || v_job_id || ' w dziale ' || v_department_id || ' zostały podniesione o 15%.');
    
  
    COMMIT;
END;

