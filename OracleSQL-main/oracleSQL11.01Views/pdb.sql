create table pracownicy_07 as select * from hr.employees;

create table oddzialy_07 as select * from hr.departments;

create table stanowiska_07 as select * from hr.jobs;

create or replace view widok1 as select first_name from pracownicy;
select * from widok1;
--1
select job_id, avg(salary) srednia_pensja, max(salary) max_pensja, count(employee_id) liczba_prac from pracownicy_07 join stanowiska using(job_id) group by job_id order by 3;
create or replace view PENSJA_STANOWISKA as 
select job_id, avg(salary) srednia_pensja, max(salary) max_pensja, count(employee_id) liczba_prac from pracownicy join stanowiska using(job_id) group by job_id order by 2;
select * from pensja_stanowiska;
--inny sposob
drop view pensja_stanowiska; --usuniêcie widoku
create or replace view PENSJA_STANOWISKA(job_id, srednia_pensja, max_pensja, liczba_prac) as  
select job_id, avg(salary), max(salary), count(employee_id) from pracownicy join stanowiska using(job_id) group by job_id order by 3;
--nie jest modyfikowalna, bo zawiera grupowania; nie mo¿na wykonaæ operacji update, delete i insert przez ta perspektywe
--modyfikowalne : bez: distinct, ORDER BY, wyrazeñ na atrybutach, operatorow zbiorowych, funcji agregujacych, GROUP BY, podzapytañ w klauzuli SELECT
--przy INSERT perspektywa ma udostêpniaæ pola klucza gównego i pola wymagane
select * from pensja_stanowiska;
update pensja_stanowiska set srednia_pensja=1500 where job_id='IT_PROG'; --niedozwolona
delete pensja_stanowiska where job_id='IT_PROG'; ---niedozwolona
--insert into pensja_stanowiska ...; --niewykonalne
--3
create or replace view prac_5000 as
select * from pracownicy where salary <5000;
describe pracownicy;
insert into prac_5000 values ((select max(employee_id)+1 from pracownicy),'Joanna', 'Wasiura','sss','659.345.3434',sysdate,'IT_PROG',6000,null,103,60);
select * from pracownicy_07;
select * from prac_5000;
insert into prac_5000 values ((select max(employee_id)+1 from pracownicy),'Joanna', 'Wasiura','sss','659.345.3434',sysdate,'IT_PROG',4200,null,103,60);
--6  -- perspektywy tylko do odczytu
create or replace view prac_oddzial_60 as
select * from pracownicy where department_id=60 WITH READ ONLY;
select * from prac_oddzial_60;
insert into prac_oddzial_60 values ((select max(employee_id)+1 from pracownicy),'Joanna', 'Wasiura','sss','659.345.3434',sysdate,'IT_PROG',4200,null,103,60);
--7
select first_name, last_name, salary from prac_oddzial_60 where salary > (select avg(salary) from prac_oddzial_60);
--12 -- perspektywy WITH CHECK OPTION sprawdzaja warunek
create or replace view pensja_12000 as
select * from pracownicy where salary <12000 WITH CHECK OPTION;
--13
select * from pensja_12000 where last_name like 'G%';
update pensja_12000 set salary=20000 where last_name='Grant';
update pensja_12000 set salary=10000 where last_name='Grant';

select * from user_objects;  --obiekty u¿ytkownika
create or replace view prac_oddzial_60_1 as
select first_name, last_name, salary from prac_oddzial_60 where salary > (select avg(salary) from prac_oddzial_60);
drop view prac_oddzial_60;  -- jeœli usuniemy wewnêtrzny widok, to usunie, ale zmieni status na 'invalid' w tabeli user_objects;
select * from prac_oddzial_60_1;  
drop view prac_oddzial_60_1; --zewnêtrzne widoki mo¿emy usuwaæ bez problemu

--15
create or replace view zarobki as 
select salary,employee_id from pracownicy_07 
where salary < (select m.salary from pracownicy_07 m where m.employee_id like employee_id);

describe zarobki;

describe pracownicy_07;

--16
create or replace view perspektywaMarketing as 
select salary,employee_id from pracownicy_07 
where salary > (select m.salary from pracownicy_07 m where department_id like 'Marketing');

describe perspektywaMarketing;

--17
create or replace view nazwy17 as
select department_name, avg(salary) from HR.employees inner join hr.departments using(department.id)
where avg(salary)>
(select avg(salary) from hr.employees);