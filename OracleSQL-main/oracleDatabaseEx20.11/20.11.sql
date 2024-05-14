
  --4
  select UPPEr(job_title), lower(job_title), Initcap(job_title) from hr.jobs; 
  
  --10
  select replace(concat(first_name,last_name),'a','*') from hr.employees; 
  
  --11
  select UPPER(last_name) from hr.employees where last_name like 'A%' or last_name like 'P%' or last_name like 'R%';
  
  --13
  select employee_id, first_name, last_name  from hr.employees where job_id like 'S%' and job_id like 'A%' or job_id like 's%' and job_id like 'a%';
  
  
  --20
 select * from hr.employees where month(hire_date) like "%02%" or month(hire_date) like "%04%" or month(hire_date) like "%06%" or month(hire_date) like "%08%"
 or month(hire_date) like "%10%" or month(hire_date) like "%12%";
  --21
  Select concat(first_name,last_name) as "pracownik", (trunc(months_between(sysdate,hire_date)))/30 as "ilosc dni" from hr.employees;
  --22
  select department_name as "Nazwa" , length(Replace(department_name,' ','')) as "Liczba znakow" from hr.departments order by department_name desc;
  --23
  select concat(first_name,last_name) as Pracownicy, to_char(hire_date,'mm') from hr.employees where to_char(hire_date,'mm')>=6;
  --24
  select concat(first_name,last_name)  as "lista z najdluzszymi nazwiskami " from hr.employees order by length(last_name) desc fetch first 20 rows only;
  --25
select datepart(dy,'2001-10-13') as "dzien tygodnia";