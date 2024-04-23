select * from pracownicy_am;
--5
select * from pracownicy_jw;
CREATE TABLE pracownicy_am AS
SELECT * FROM hr.employees;
/
SET SERVEROUT ON
DECLARE
    v_job_id pracownicy_am.job_id%TYPE;
    v_first_name pracownicy_am.first_name%TYPE;
    v_last_name pracownicy_am.last_name%TYPE;
    v_bonus pracownicy_am.commission_pct%TYPE;

    CURSOR c_employees IS
        SELECT first_name, last_name, commission_pct, job_id
        FROM pracownicy_am
        WHERE job_id = v_job_id;

BEGIN
    v_job_id := UPPER('&job_id');

    FOR r_employee IN c_employees LOOP
        IF r_employee.commission_pct IS NOT NULL THEN
            v_bonus := r_employee.commission_pct * 100;
            DBMS_OUTPUT.PUT_LINE('Pracownik ' || r_employee.first_name || ' ' || r_employee.last_name || ' posiada premię w wysokości ' || v_bonus || '%');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Pracownik ' || r_employee.first_name || ' ' || r_employee.last_name || ' nie posiada premii');
        END IF;
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Brak pracowników dla stanowiska!');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Wystąpił inny błąd!');
END;
/
--6
DECLARE
    v_department_id NUMBER;
    v_increase NUMBER := 0.05;

BEGIN
    v_department_id := TO_NUMBER('&department_id');

    UPDATE pracownicy_am
    SET commission_pct = NVL(commission_pct, 0) + v_increase
    WHERE department_id = v_department_id;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Brak pracowników w departamencie!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Podwyżka premii dla pracowników zakończona pomyślnie.');
    END IF;

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Błędny numer departamentu!');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Wystąpił inny błąd!');
END;
/

--7
DECLARE
    v_quarter NUMBER;
    v_start_date DATE;
    
CURSOR cur_jobs IS
    SELECT DISTINCT job_id FROM pracownicy_am;
    
BEGIN
    v_quarter := TO_NUMBER('&quarter');
    
    FOR job_rec IN cur_jobs LOOP
        DECLARE
            v_count NUMBER;
            v_end_date DATE;
        BEGIN
            CASE v_quarter
                WHEN 1 THEN
                    v_start_date := TO_DATE('01-JAN-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                    v_end_date := TO_DATE('31-MAR-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                WHEN 2 THEN
                    v_start_date := TO_DATE('01-APR-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                    v_end_date := TO_DATE('30-JUN-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                WHEN 3 THEN
                    v_start_date := TO_DATE('01-JUL-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                    v_end_date := TO_DATE('30-SEP-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                WHEN 4 THEN
                    v_start_date := TO_DATE('01-OCT-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                    v_end_date := TO_DATE('31-DEC-' || TO_CHAR(TO_NUMBER('&year')), 'DD-MON-YYYY');
                ELSE
                    RAISE VALUE_ERROR;
            END CASE;
            
            SELECT COUNT(*) INTO v_count
            FROM pracownicy_am
            WHERE job_id = job_rec.job_id
            AND hire_date BETWEEN v_start_date AND v_end_date;

            DBMS_OUTPUT.PUT_LINE('Stanowisko: ' || job_rec.job_id || ', Liczba pracowników: ' || v_count);
            
        END;
    END LOOP;

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Błędny kwartał! Wprowadź numer kwartału (1-4).');

    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Wystąpił inny błąd!');
END;
