DECLARE
  emp_record hr.employees%ROWTYPE;
BEGIN
  -- Pobierz dane z tabeli employees i przypisz je do zmiennej rekordowej emp_record
  SELECT * INTO emp_record FROM hr.employees WHERE employee_id = 100;

  -- Wyświetl zawartość rekordu emp_record
  DBMS_OUTPUT.PUT_LINE('Employee ID: ' || emp_record.employee_id);
  DBMS_OUTPUT.PUT_LINE('First Name: ' || emp_record.first_name);
  DBMS_OUTPUT.PUT_LINE('Last Name: ' || emp_record.last_name);
  DBMS_OUTPUT.PUT_LINE('Email: ' || emp_record.email);
  DBMS_OUTPUT.PUT_LINE('Phone Number: ' || emp_record.phone_number);
  DBMS_OUTPUT.PUT_LINE('Hire Date: ' || emp_record.hire_date);
  DBMS_OUTPUT.PUT_LINE('Job ID: ' || emp_record.job_id);
  DBMS_OUTPUT.PUT_LINE('Salary: ' || emp_record.salary);
  DBMS_OUTPUT.PUT_LINE('Commission Pct: ' || emp_record.commission_pct);
  DBMS_OUTPUT.PUT_LINE('Manager ID: ' || emp_record.manager_id);
  DBMS_OUTPUT.PUT_LINE('Department ID: ' || emp_record.department_id);
END;


DECLARE
  employees_copy hr.employees%ROWTYPE;
BEGIN
  Select * Into employees_copy from hr.employees where employee_id = 100;
DBMS_OUTPUT.PUT_LINE(employees_copy.first_name||' '||employees_copy.job_id);
END;






DECLARE
  CURSOR c1 IS
    SELECT * FROM hr.employees WHERE first_name LIKE 'A%';
  employees_copy hr.employees%ROWTYPE;
BEGIN
  OPEN c1;
  LOOP
    FETCH c1 INTO employees_copy;
    EXIT WHEN c1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(employees_copy.first_name||' '||employees_copy.job_id);
  END LOOP;
  CLOSE c1;
END;
