CREATE TABLE Pracownicy_backup AS
SELECT * FROM hr.Employees;

drop table Pracownicy_backup;

CREATE TABLE Departamenty_backup AS
SELECT * FROM hr.Departments;

select * from dictionary where table_name like 'USER%' order by table_name;


CREATE TABLE UTWORY_backup (
    Id_utworu NUMBER(6) PRIMARY KEY,
    Tytul VARCHAR2(200),
    Czas_trwania NUMBER(4,2),
    Jezyk VARCHAR2(100)
);

INSERT INTO UTWORY (Id_utworu, Tytul, Czas_trwania, Jezyk) VALUES (1, 'Piosenka 0', 3.5, 'Polski');
INSERT INTO UTWORY (Id_utworu, Tytul, Czas_trwania, Jezyk) VALUES (2, 'Piosenka 1', 4.2, 'Angielski');
INSERT INTO UTWORY (Id_utworu, Tytul, Czas_trwania, Jezyk) VALUES (3, 'Piosenka 2', 2.8, 'Hiszpański');
INSERT INTO UTWORY (Id_utworu, Tytul, Czas_trwania, Jezyk) VALUES (4, 'Piosenka 3', 5.1, 'Francuski');
INSERT INTO UTWORY (Id_utworu, Tytul, Czas_trwania, Jezyk) VALUES (5, 'Piosenka 4', 3.9, 'Niemiecki');

DELETE FROM UTWORY WHERE Czas_trwania < 1.5; 


ALTER TABLE UTWORY_backup
ADD CONSTRAINT czas_trwania_check_test_a_a CHECK (Czas_trwania >= 1.5);

SELECT table_name
FROM user_tables;

SELECT table_name
FROM all_tables
WHERE owner LIKE 'USER%';

CREATE INDEX idx_jezyk ON UTWORY_backup(Jezyk);

GRANT CREATE ANY INDEX TO lab07;

CREATE VIEW Kierownicy_AM AS
SELECT *
FROM hr.Employees 
WHERE manager_id is not null;


select * from hr.employees;

SELECT table_name, owner
FROM dba_tables;

SELECT privilege
FROM user_sys_privs;

SELECT Username as u, privilege as p, admin_option as grant
FROM user_sys_privs;

SELECT Username AS u, privilege AS p, admin_option AS grant_
FROM user_sys_privs;
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'UTWORY';





