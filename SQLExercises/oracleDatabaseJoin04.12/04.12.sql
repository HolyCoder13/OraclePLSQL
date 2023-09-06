--5
select count(employee_id), department_name from hr.employees e join hr.departments d on e.employee_id = d.department_id group by department_name order by count(employee_id);

--7
select sum(salary), job_title from hr.employees e join hr.jobs j on e.job_id = j.job_id group by job_title;

select sum(salary), job_title from hr.employees e join hr.jobs j using(job_id) group by job_title;

--9
select count(employee_id), job_title from hr.jobs join hr.employees using(job_id) group by job_title having count(employee_id)>=3;

--10
select department_name ,avg(salary) from hr.departments join hr.employees using(department_id) group by department_name  having avg(salary)>=5000 and avg(salary)<=7000;

--12
select department_name ,avg(salary) from hr.departments join hr.employees using(department_id) group by department_name having avg(salary)<10000 order by avg(salary) desc;

--14
select job_title, count(employee_id) from hr.employees e join hr.jobs j on e.job_id = j.job_id  where job_title like 'Manager' group by job_title;

--19
select salary, department_name, country_name from hr.employees join hr.departments using(department_id)
join hr.locations using(location_id) join hr.countries using(country_id) where country_name not like 'Canada';
--23
select count(employee_id) as "iczba pracownikow",  department_name as "nazwa oddzialu" 
, job_title as "nazwa stanowiska"  from hr.employees  join  hr.jobs using(job_id) join hr.departments using(department_id) group by department_name, job_title;

--24
select m.employee_id, m.last_name as "Nazwisko keirownika" , count(e.employee_id) as "Liczba pracowinkow" 
from hr.employees e join hr.employees m on m.employee_id = e.manager_id group by m.employee_id, m.last_name
having count(e.employee_id)<=10; 


--25
select department_name, hire_date, employee_id from hr.employees  join hr.departments using(department_id)
where hire_date <('2015-1-1') order by department_name;

