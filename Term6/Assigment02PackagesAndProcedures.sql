--2
--deklaracja
CREATE OR REPLACE PACKAGE Depart IS
    CURSOR c_DepartmentsByLocation (p_location_id IN departments.location_id%TYPE) IS
    SELECT department_id, department_name
    FROM departments
    WHERE location_id = p_location_id;
    PROCEDURE NowyDep(p_department_id IN departments.department_id%TYPE,
    p_department_name IN departments.department_name%TYPE,
    p_manager_id IN departments.manager_id%TYPE,
    p_location_id IN departments.location_id%TYPE);
    
    FUNCTION LiczbaDepLok(p_location_id IN departments.location_id%TYPE) RETURN NUMBER;
    
    PROCEDURE InfoDep(p_department_id IN departments.department_id%TYPE);
    
    PROCEDURE WyswietlDep(p_order IN VARCHAR2);

    PROCEDURE UsunDep(p_department_id IN departments.department_id%TYPE);
END Depart;
/
--ciała procedur
CREATE OR REPLACE PACKAGE BODY Depart IS
    PROCEDURE NowyDep(p_department_id IN departments.department_id%TYPE,
                      p_department_name IN departments.department_name%TYPE,
                      p_manager_id IN departments.manager_id%TYPE,
                      p_location_id IN departments.location_id%TYPE) IS
    BEGIN
        INSERT INTO departments (department_id, department_name, manager_id, location_id)
        VALUES (p_department_id, p_department_name, p_manager_id, p_location_id);
        COMMIT;
    END NowyDep;

    FUNCTION LiczbaDepLok(p_location_id IN departments.location_id%TYPE) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM departments
        WHERE location_id = p_location_id;
        RETURN v_count;
    END LiczbaDepLok;

    PROCEDURE InfoDep(p_department_id IN departments.department_id%TYPE) IS
        v_department_name departments.department_name%TYPE;
        v_manager_id departments.manager_id%TYPE;
        v_location_id departments.location_id%TYPE;
    BEGIN
        SELECT department_name, manager_id, location_id
        INTO v_department_name, v_manager_id, v_location_id
        FROM departments
        WHERE department_id = p_department_id;

        DBMS_OUTPUT.PUT_LINE('Department ID: ' || p_department_id);
        DBMS_OUTPUT.PUT_LINE('Department Name: ' || v_department_name);
        DBMS_OUTPUT.PUT_LINE('Manager ID: ' || v_manager_id);
        DBMS_OUTPUT.PUT_LINE('Location ID: ' || v_location_id);
    END InfoDep;

    PROCEDURE WyswietlDep(p_order IN VARCHAR2) IS
        CURSOR c_departments IS
        SELECT department_id, department_name
        FROM departments
        ORDER BY 
        CASE 
            WHEN p_order = 'ASC' THEN department_name 
            ELSE NULL 
        END ASC, 
        CASE 
            WHEN p_order = 'DESC' THEN department_name 
            ELSE NULL 
        END DESC;
    BEGIN
        FOR r IN c_departments LOOP
            DBMS_OUTPUT.PUT_LINE('Departament ID: ' || r.department_id || ' Departament Name: ' || r.department_name);
        END LOOP;
    END WyswietlDep;

    PROCEDURE UsunDep(p_department_id IN departments.department_id%TYPE) IS
    BEGIN
        DELETE FROM departments
        WHERE department_id = p_department_id;
        COMMIT;
    END UsunDep;
END Depart;
/


--4
CREATE OR REPLACE TRIGGER CheckHD
BEFORE INSERT OR UPDATE OF hire_date ON employees
FOR EACH ROW
BEGIN
    IF :NEW.hire_date > SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20001, 'Data nie może być późniejsza niż aktualna');
    END IF;
END CheckHD;
/