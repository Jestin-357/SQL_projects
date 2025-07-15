
use  parks_and_recreation;


-- joins

select * from employee_demographics;
select * from employee_salary;

SELECT * 
from employee_demographics
inner JOIN
employee_salary
on employee_demographics.employee_id = employee_salary.employee_id;


SELECT * 
from employee_demographics d
inner JOIN
employee_salary s
on d.employee_id = s.employee_id;

SELECT  d.employee_id,age,occupation 
from employee_demographics d
inner JOIN
employee_salary s
on d.employee_id = s.employee_id;
