--1
Select first_name, last_name, salary from hr.employees where salary > (select avg(salary)
from hr.employees);
--2 
describe hr.employees
select  first_name, last_name, salary, department_id from hr.employees where 
department_id IN 
(select department_id from hr.employees where last_name like 'King' );

select  first_name, last_name, salary, department_id from hr.employees where 
department_id = 
(select department_id from hr.employees where first_name like 'Alexis' and last_name like 'Bull');
--3
select first_name, last_name, salary, job_id from hr.employees where
job_id = (select job_id from hr.employees where last_name like 'Weiss');


--4
select first_name, last_name, salary, department_id from hr.employees where
department_id IN (select department_id from hr.employees where last_name like 'R%');
--5

select first_name,last_name from hr.employees where
manager_id = (select employee_id from hr.employees where last_name like 'Hunold');
--6
select first_name,last_name,salary from hr.employees where salary > ANY
(select salary from hr.employees where department_id= 60);
--7
select first_name,last_name,salary from hr.employees where salary > ALL
(select salary from hr.employees where department_id= 80);
--8

--9
select first_name,last_name,salary from hr.employees where salary > 
(select avg(salary) from hr.employees) and job_id = 
(select job_id from hr.employees where last_name='Abel');

select first_name,last_name,salary from hr.employees where salary > 
(select avg(salary) from hr.employees) and job_id IN 
(select job_id from hr.employees where last_name='King');
--10

--11

--12

--13

--14
--correlated
select first_name,last_name,salary, p.department_id from hr.employees p
where p.salary =(select max(e.salary) from hr.employees e where e.department_id = p.department_id);

--15
select first_name,last_name,salary, p.department_id, d.department_name from hr.employees p join hr.departments d on 
p.department_id = d.department_id
where p.salary =(select max(e.salary) from hr.employees e where e.department_id = p.department_id);
--16


--17

--18

--19

--20

--21

--22
select job_title, avg(salary) from hr.employees natural join hr.jobs group by job_title
having avg(salary)>(select avg(salary) from hr.employees);
--23

--24

--25
describe hr.employees;

select p.last_name from hr.employees p where exists (select * from employees e where e.manager_id = p.employee_id);
--26

--27

--28

--29

--30

--31

--32

--33

--34

--35

--36

--37
select last_name as nazwiska_departmentsy, 'nazwiska' as czy_nazwsiko_department from hr.employees union select department_name,'departamenty' from hr.departments;
--38
select distinct job_title, hire_date from hr.jobs natural join hr.employees where extract(year from hire_date)=2008
intersect
select distinct job_title, hire_date from hr.jobs natural join hr.employees where extract(year from hire_date)=2005;

--39
select last_name, salary,
case
when salary<4820 then 'mniej niz 4820'
when salary=4820 then 'rowna 4820'
else 'wieksza niz 4820'
end as jaka_pensja
from hr.employees;

-- union method
select last_name salary, 'mniej niz' from hr.employees where salary<4820
union
select last_name salary, 'wiecej niz' from hr.employees where salary>4820;


--40
select department_id from hr.departments
minus
select distinct department_id from hr.employees where department_id is not null;