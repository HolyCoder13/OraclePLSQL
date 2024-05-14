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


CREATE OR REPLACE PROCEDURE example_procedure IS
  constant_text CONSTANT VARCHAR2(50) := 'Hello, world!'; -- stała tekstowa
  numeric_variable NUMBER DEFAULT 0; -- zmienna liczbowego z wartością domyślną 0
  text_variable VARCHAR2(50); -- niezainicjowana zmienna tekstowa
BEGIN
  -- Przykładowe działania na zmiennych
  text_variable := constant_text;
  numeric_variable := 10;
  DBMS_OUTPUT.PUT_LINE('Text variable: ' || text_variable);
  DBMS_OUTPUT.PUT_LINE('Numeric variable: ' || numeric_variable);
END;
--call
declare
begin
example_procedure;
end;


CREATE OR REPLACE PROCEDURE example_procedure IS
  constant_text CONSTANT VARCHAR2(50) := 'Hello, world!'; -- stała tekstowa
  numeric_variable NUMBER DEFAULT 0; -- zmienna liczbowego z wartością domyślną 0

  new_region_id NUMBER;
BEGIN
  INSERT INTO hr.regions (region_id, region_name) VALUES (null, constant_text) RETURNING region_id INTO new_region_id;

  UPDATE hr.regions SET region_id = new_region_id WHERE region_id IS NULL;

  DBMS_OUTPUT.PUT_LINE('New row with ID ' || new_region_id || ' has been inserted.');
END;

CREATE OR REPLACE PROCEDURE display_employee_details (p_employee_id IN hr.employees.employee_id%TYPE) AS
  v_first_name hr.employees.first_name%TYPE;
  v_last_name hr.employees.last_name%TYPE;
  v_phone_number hr.employees.phone_number%TYPE;
BEGIN
  SELECT first_name, last_name, phone_number INTO v_first_name, v_last_name, v_phone_number
  FROM hr.employees
  WHERE employee_id = p_employee_id;

  DBMS_OUTPUT.PUT_LINE('Employee ID: ' || p_employee_id);
  DBMS_OUTPUT.PUT_LINE('First name: ' || v_first_name);
  DBMS_OUTPUT.PUT_LINE('Last name: ' || v_last_name);
  DBMS_OUTPUT.PUT_LINE('Phone number: ' || v_phone_number);
END;

declare
begin
display_employee_details(104);
end;

