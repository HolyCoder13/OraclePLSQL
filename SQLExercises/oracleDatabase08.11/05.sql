--3 

Select department_name from hr.departments where manager_id is null; 

--5 

Select first_name,last_name,hire_date from hr.employees order by hire_date desc fetch next 10 rows only; 

--7 

Select job_id, salary from hr.employees order by salary asc fetch next 10 rows only; 

--10 

Select * from hr.employees where hire_date>= '01/01/05' and email is not null order by salary asc fetch first 10 PERCENT rows only; 

--11
select salary from hr.employees where (job_id like 'SA_MAN' or job_id like 'SA_REP') and commission_pct is not null; 

--13 

Select * from hr.employees where department_id like 50 or department_id like 60 or department_id like 80 order by hire_date desc fetch first 15 percent rows only; 

--15 

select job_id from hr.employees where job_id like 'S%' or job_id like 's%' or  job_id like '%S%' or job_id like '%s%' or job_id like '%S' or job_id like '%s' order by job_id offset 9 rows fetch next 5 rows only; 

--16 

select job_history from hr.employees where employee_id = 101; 

--18 

select * from hr.departments where department_id = 1700 and manager_id is not null order by manager_id fetch first 5 rows only; 

--19 
select commission_pct from hr.employees order by commission_pct asc fetch first 1 rows only;