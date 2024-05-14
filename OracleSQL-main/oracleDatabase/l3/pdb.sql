--8
select first_name, last_name, salary from hr.employees order by salary desc;

--14 
Select distinct job_id from hr.employees;

--18
Select first_name, last_name from hr.employees where last_name like '%i%' or last_name like '%o%' or last_name like '%a%';

--22
Select department_id from hr.employees group by department_id;

--23
select last_name, first_name, salary from hr.employees where salary > 10000;
--25
select * from hr.employees where department_id = 100;
--27
select * from locations_ak where city like 'S%';
--28
select country_id from countries_ak group by country_id;
--29
select country_name from countries_ak order by country_name asc;
--30
select last_name as "nazwisko", hire_date as "data zatrudnienia", salary as "pensja", salary+1000 as "pensja po podwyzce o 1000" from hr.employees;
