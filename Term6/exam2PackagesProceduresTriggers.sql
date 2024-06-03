--1 (liczby pierwsze)
CREATE OR REPLACE Function sprawdzAM(l1_v in number, l2_v in number)
RETURN varchar2
IS
komunikat_v varchar2;
BEGIN
IF((l1_v - l2_v)=2 OR (l2_v - l1_v)=2) THEN
    komunikat_v := 'Podane liczby S? liczbami pierwszymi';
ELSE
    komunikat_v := 'Podane liczby TO NIE liczby pierwsze!';
END IF;
RETURN komunikat_v;
END sprawdzAM;
/
drop table pracownicy_am;
create table pracownicy_am as select first_name,last_name,email,phone_number,hire_date,job_id from hr.employees;
select * from pracownicy_am;

--2
CREATE OR REPLACE TRIGGER CheckValidation 
BEFORE INSERT OR UPDATE ON pracownicy_am
FOR EACH ROW
BEGIN
    IF :NEW.hire_date < TO_DATE('2020-01-01', 'YYYY-MM-DD') OR :NEW.hire_date > SYSDATE THEN
        IF INSERTING THEN
            :NEW.hire_date := SYSDATE;
        ELSE
            :NEW.hire_date := :OLD.hire_date;
        END IF;
    END IF;
END CheckValidation;
/
--sprawdzenie 2
INSERT INTO pracownicy_am(first_name, last_name, email, phone_number, hire_date, job_id)
VALUES ('Adr', 'Mad', 'aaa@aa', '123', TO_DATE('2000-01-01', 'YYYY-MM-DD'), 'IT_PROG');
/
--3
--deklaracja pakietu
CREATE OR REPLACE PACKAGE KonwersjaAM IS
Function HaToAr(n_v in number) return number;
end KonwersjaAm;
--cialo pakietu (funkcji)
CREATE OR REPLACE PACKAGE BODY KonwersjaAM IS
    FUNCTION HaToAr(n_v IN NUMBER) RETURN NUMBER IS
    BEGIN
        RETURN n_v * 100;
    END HaToAr;
END KonwerszaAM;
/
select * from departamenty_AM;
--4
CREATE OR REPLACE PACKAGE infoDepAM IS
FUNCTION ileDep(loc_id IN NUMBER) RETURN NUMBER;
FUNCTION daneDep(dep_id IN NUMBER) RETURN departamenty_AM.department_name%TYPE;
END infoDepAM;
/
CREATE OR REPLACE PACKAGE BODY infoDepAM IS
    FUNCTION ileDep(loc_id IN NUMBER) RETURN NUMBER IS
        licznik NUMBER;
    BEGIN
        SELECT COUNT(*) INTO licznik
        FROM departamenty_AM
        WHERE location_id = loc_id;
        RETURN licznik;
    END ileDep;

    FUNCTION daneDep(dep_id IN NUMBER) RETURN departamenty_AM.department_name%TYPE IS
        kierownik_dep_id_v departamenty_AM.manager_id%TYPE;
        department_name_v departamenty_AM.department_name%TYPE;
    BEGIN
        SELECT manager_id INTO kierownik_dep_id_v
        FROM departamenty_AM
        WHERE department_id = dep_id;

        SELECT department_name INTO department_name_v
        FROM departamenty_AM
        WHERE department_id = dep_id;

        DBMS_OUTPUT.PUT_LINE('ID kierownika: ' || kierownik_dep_id_v);
        RETURN department_name_v;
    END daneDep;
END infoDepAM;
/

--udost?pnienie
grant access to daneDep for student4;
revoke access to daneDep for student4;





