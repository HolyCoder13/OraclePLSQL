describe hr.employees;

select job_id, avg(salary) from hr.employees group by job_id having max(Salary)>4000;

select job_id from hr.employees group by job_id having max(Salary)>4000;

select department_id, count(employee_id) as ilosc 
from hr.employees group by department_id
having count(employee_id)<>2;

select first_name,last_name,department_id from hr.employees natural join hr.departments;

describe hr.departments;
select * from hr.departments;

select last_name,first_name from hr.employees e join hr.departments d on e.department_id = d.department_id where location_id like '1700';


select last_name, department_name from hr.employees e join hr.departments d using(department_id) where
department_name like 'I%' and last_name like 'A%';

select department_name, count(last_name) as "ilosc" from hr.employees join hr.departments using(department_id) group by department_name order by department_name;


select z.first_name, z.department_id, salary from hr.employees z
where salary > (select avg(salary) from hr.employees e  where e.department_id=z.department_id);

select first_name from hr.employees where
salary > (select min(salary) from hr.employees where department_id like '1100');

select department_name from hr.employees join hr.departments using(department_id) group by department_name
having count(employee_id) = (select max(count(employee_id)) from hr.employees group by department_id);

select min(count(employee_id)) from hr.employees join hr.departments using(department_id) group by department_id;

--select d.department_name, e.last_name, e.hire_date
--from hr.employees e join hr.departments d on e.department_id = d.department_id
--group by e.employee_id having count(hire_date) = (select min(hire_date) from hr.employees group by department_id);


select e.first_name,e.last_name, e.salary,d.department_name from hr.employees e join hr.departments d
on d.department_id = e.employee_id
where e.salary = (select max(p.salary) from hr.employees p where p.department_id = e.department_id);



--department with most hired emplloyees
select department_name, count(employee_id) ilosc from hr.employees join hr.departments using(department_id)
group by department_name
having count(employee_id) = (select max(count(employee_id)) from hr.employees group by department_id);



--najmniej w swoich oddziialach
select department_id, last_name, first_name from hr.employees
where (department_id, salary) in
(select department_id, min(salary) from hr.employees group by department_id);


select department_id, last_name from hr.employees
where (department_id,salary) in
(select department_id, max(salary) from hr.employees group by department_id);

--correlated
select e.first_name, e.last_name from hr.employees e
where salary > (select avg(salary) from hr.employees where e.employee_id = employee_id);


SELECT first_name, last_name, salary FROM HR.employees
WHERE salary IN 
    (SELECT salary FROM HR.employees
    ORDER BY salary DESC
    FETCH NEXT 5 ROWS ONLY);