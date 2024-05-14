describe hr.employees;
describe hr.departments;

--4
select first_name,last_name,salary,department_id from hr.employees
where
department_id IN( select department_id from hr.employees where last_name like 'R%');

--5
select e.first_name, e.last_name from hr.employees e where
e.manager_id = (select m.employee_id from hr.employees m where last_name like 'Hunold');

--8
select e.first_name, e.last_name, e.salary, d.department_name from hr.employees e join hr.departments d using(department_id)
where  e.salary > ALL(select salary from hr.employees where department_name like 'Marketing');
--10
select count(e.employee_id) as "ilosc", department_id from hr.employees e
where
"ilosc" > All (select count(employee_id) from hr.employees);

--12
select e.salary, e.department_id from hr.employees e  where e.salary = (select max(p.salary) from hr.employees p 
where e.department_id = p.department_id);

--13
select e.salary, e.department_id,department_name from hr.employees e join hr.departments on e.employee_id = hr.departments.department_id where e.salary = (select max(p.salary) from hr.employees p 
where e.department_id = p.department_id);
--14
select p.first_name, p.last_name, p.salary, p.department_id from HR.employees p 
where p.salary = (select max(e.salary) from HR.employees e where e.department_id=p.department_id ); 

--where e.salary = (select max(p.salary) from hr.employees p where p.department_id = e.department_id);
--26
select b.last_name from hr.employees b where not exists(select * from hr.employees e where e.manager_id = b.employee_id);

--27
describe hr.jobs;
select salary, job_title from hr.employees join hr.jobs using(job_id)
 where salary = (select max(salary) from hr.employees);
 
--28
select first_name, last_name from hr.employees e where salary > (select 0.5*avg(salary) from hr.employees d where e.department_id = d.department_id);

--29
select d.department_name,e.first_name, e.last_name, (select max(h.salary) from hr.employees h where h.department_id = e.department_id)-e.salary 
as roznica_W_Pensji_Min_Max_W_Dziale
from hr.employees e join hr.departments d on e.employee_id = d.department_id order by d.department_id;


--12
select avg(salary),department_id from hr.employees where salary > (select avg(salary) from hr.employees) group by department_id;

--16
select first_name,last_name,salary from hr.employees where salary > (select avg(salary) from hr.employees) fetch next 5 rows only;