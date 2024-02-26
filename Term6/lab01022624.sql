select * from employees_ar;
 
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM hr.departments d
JOIN hr.employees e ON d.department_id = e.department_id
WHERE e.hire_date >= TO_DATE('01-01-2024', 'DD-MM-YYYY') 
AND e.hire_date <= TO_DATE('30-06-2024', 'DD-MM-YYYY')
GROUP BY d.department_name;
 
 
--18
select m.last_name as nazwisko, count(e.employee_id) as liczba_podwladnych 
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id
group by m.last_name
having count(e.employee_id) >=5;
--
SELECT c.country_name,
       CASE 
           WHEN COUNT(l.location_id) > 0 THEN 'Jest prowincja'
           ELSE 'Nie ma prowincji'
       END AS informacja_o_prowincji
FROM hr.countries c
LEFT JOIN hr.locations l ON c.country_id = l.country_id
GROUP BY c.country_name;
 
SELECT d.department_id, MAX(e.salary) AS maksymalna_pensja
FROM hr.employees e
JOIN hr.departments d ON e.department_id = d.department_id
WHERE e.job_id != 'Purchasing'
GROUP BY d.department_id;
--14
SELECT AVG(salary) AS srednie_zarobki
FROM hr.employees
WHERE job_id IN ('SA_MAN', 'SA_REP')
GROUP BY job_id
HAVING COUNT(commission_pct) > 0;
--15
SELECT c.country_name, COUNT(d.department_id) AS liczba_oddzialow
FROM hr.countries c
JOIN hr.locations l ON c.country_id = l.country_id
JOIN hr.departments d ON l.location_id = d.location_id
GROUP BY c.country_name;
 
SELECT first_name, last_name, hire_date, department_id
FROM (
    SELECT first_name, last_name, hire_date, department_id,
           RANK() OVER (PARTITION BY department_id ORDER BY hire_date DESC) AS ranking
    FROM hr.employees
) ranked_employees
WHERE ranking = 1;
 
Select job_title,max(salary) as MaxWyplata
from hr.jobs inner join hr.employees using(job_id)
group by job_title
having avg(salary)>6000
order by MaxWyplata;