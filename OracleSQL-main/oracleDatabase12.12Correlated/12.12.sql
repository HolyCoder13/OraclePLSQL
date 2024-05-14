select first_name, last_name from hr.employees
where department_id in (select department_id from hr.employees where last_name like 'R%');

select e.first_name,e.last_name from hr.employees e where
e.manager_id = (select m.employee_id from hr.employees m where last_name like 'Hunold');

select first_name, last_name, salary
from hr.employees 
where salary >
(select max(salary)
from hr.employees 
where department_id = 
(select department_id from hr.departments
where department_id = (select department_id from hr.departments where department_name = 'Marketing')
)
);

select first_name, salary from hr.employees
where salary >
All (select salary from hr.employees  join hr.departments  
on hr.employees.department_id = hr.departments.department_id
--using(department_id) 
where  department_name like 'Marketing');


--12
select avg(salary), department_id from hr.employees
group by department_id
having avg(salary) = (select max(avg(salary)) from hr.employees  group by department_id); 

select e.first_name,e.last_name, e.salary,d.department_name from hr.employees e join hr.departments d
on d.department_id = e.employee_id
where e.salary = (select max(p.salary) from hr.employees p where p.department_id = e.department_id);
--21
select first_name, last_name, salary, job_id from hr.employees
where (job_id, salary) in (select job_id, max(salary) from hr.employees group by job_id);

--8
select first_name, last_name,salary from hr.employees
where salary > (select max(salary) from hr.employees where department_id = (select department_id from hr.departments where department_name = 'Marketing'));

select first_name,last_name, salary from hr.employees
where salary > (select max(e.salary) from hr.employees e join hr.departments d on e.department_id = d.department_id where department_name like 'M%'); 

--23
select first_name, last_name,salary from hr.employees
where salary > (select 0.5*avg(salary) from hr.employees where department_id =80);


select e.first_name, e.last_name from hr.employees e
where salary > (select avg(salary)*0.5 from hr.employees e2 where e.department_id = e2.department_id);