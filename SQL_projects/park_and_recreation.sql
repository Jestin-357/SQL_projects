show DATABASES;

DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;

use parks_and_recreation;

CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

select * from employee_demographics;

drop table employee_salary;

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);

-- to see the tables in the database
show tables;

select * from employee_salary;

select first_name from employee_demographics;
select * from employee_demographics where first_name= 'Leslie';
SELECT  employee_id from  employee_salary where occupation = 'Nurse';

SELECT * from  employee_salary where occupation = 'Nurse';


# drop the dupplicate  rows
delete from  employee_salary where  employee_id = 7 LIMIT 1;  

# to find out the name of a employee based on the occupation
select first_name from employee_salary where occupation = 'office Manager';


# group by the first name of the employee based on the occupation
 select first_name from employee_salary where occupation = 'office Manager' group by first_name;


SELECT first_name, last_name ,age 
from employee_demographics;

SELECT first_name, last_name ,age , age*10+1
from employee_demographics;


select gender, count(*) as total_gender FROM employee_demographics 
group by gender;


SELECT * from employee_demographics;
select  gender from  employee_demographics;

# distinct values
select DISTINCT(gender) from employee_demographics;
select distinct gender from employee_demographics;

select distinct first_name, gender from employee_demographics;

# where clause

SELECT * from employee_salary;
select * from employee_demographics;

select * from employee_salary where first_name = 'Leslie';


delete from employee_demographics where employee_id = 1;   

select * from employee_salary where salary >50000;

select DISTINCT employee_salary.salary from employee_salary where salary > 50000;

# not equal to
SELECT *
from employee_demographics where gender != 'female';

SELECT *
from employee_demographics where birth_date >1990-01-01;;



# and or not  logical operators

select * from employee_demographics;
select * from employee_demographics WHERE first_name = 'Tom' and age = 36;
select * from 
employee_demographics where (first_name  = 'Jerry' and age = 61) or employee_id >=6;


# like statement
-- % and _

select * from employee_demographics where first_name like 'jer%' ;

SELECT * from employee_demographics where first_name like '__r%';

select * from employee_demographics where birth_date like '1980%';

-- group by 

select  first_name from employee_demographics
group by first_name;;

select gender from employee_demographics
GROUP BY gender;

select gender, avg(age)
from employee_demographics
GROUP BY gender;

select gender, AVG(age) ,MAX(age)
from employee_demographics
GROUP BY gender;

select gender, AVG(age) ,MAX(age), min(age)
from employee_demographics
GROUP BY gender;

select gender, AVG(age) ,MAX(age), min(age), count(age)
from employee_demographics
GROUP BY gender;



select gender, AVG(age) as average,MAX(age) as highest
from employee_demographics
GROUP BY gender;



select occupation,salary
from employee_salary
GROUP BY occupation,salary;


-- order by
select * from employee_demographics;

select * from employee_demographics
order by first_name desc;

select * from employee_demographics
order by gender,age;

-- order by with multiple columns
select * from employee_demographics
order by age, gender;

-- here we can use column index as well (5th column is gender and 4th column is  age )
select * from employee_demographics
order by 5,4;


-- having clause 

select gender, avg(age)
from employee_demographics
GROUP BY gender;

-- again we can use having clause to filter
select gender, avg(age)
from employee_demographics
GROUP BY gender
having avg(age) > 40;

SELECT occupation, avg(salary)
FROM employee_salary
GROUP BY occupation;


SELECT occupation, avg(salary)
FROM employee_salary
where occupation  like '%Manager%'
GROUP BY occupation;



SELECT occupation, avg(salary)
FROM employee_salary
where occupation  like '%Manager%'
GROUP BY occupation
having AVG(salary)>75000;


-- limit & Aliasing

SELECT * from employee_demographics;


SELECT * from employee_demographics
limit 3;

SELECT * from employee_demographics
ORDER BY age desc
limit 3;

SELECT * from employee_demographics
ORDER BY age  -- this will give the age in ascending order
limit 0,2; -- this will give us the first 2 rows from starting from 0 index

-- aliasing

select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40;

select gender, avg(age) as avg_age -- this is called aliasing
from employee_demographics
group by gender
having avg_age > 40;

select gender, avg(age) avg_age -- this is also  called aliasing without giving 'AS'
from employee_demographics
group by gender
having avg_age > 40;

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
