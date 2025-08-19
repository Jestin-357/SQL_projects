show DATABASES;
-- creating databases
create DATABASE project1;
use project1;


-- creating  table 1 
create table departments(
  dept_id int AUTO_INCREMENT PRIMARY KEY,
  dept_name VARCHAR(20)
);

insert into Departments (dept_name) VALUES
('HR'),('IT'),('Finance'),('Marketing');

select * from departments;

-- 2nd TABLE

create table employees(
  emp_id int PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(30),
  last_name varchar (30),
  dept_id int,
  salary DECIMAL(10,2),
  hire_date DATE,
  manager_id int null,
  Foreign Key (dept_id) REFERENCES departments (dept_id)
);
INSERT INTO Employees VALUES
(1, 'John', 'Doe', 2, 60000, '2020-05-10', NULL),
(2, 'Jane', 'Smith', 2, 75000, '2019-03-15', 1),
(3, 'Robert', 'Brown', 1, 50000, '2021-07-22', 1),
(4, 'Emily', 'Davis', 3, 80000, '2018-11-12', NULL),
(5, 'Michael', 'Wilson', 3, 45000, '2022-01-10', 4),
(6, 'Sarah', 'Taylor', 4, 70000, '2019-08-05', NULL);


-- tabe 3
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

INSERT INTO Projects VALUES
(101, 'Website Redesign', 2, '2021-01-10', '2021-06-15'),
(102, 'Payroll System', 3, '2020-02-01', '2020-12-31'),
(103, 'Recruitment Drive', 1, '2022-03-01', '2022-05-30'),
(104, 'Marketing Campaign', 4, '2021-07-01', '2021-10-15');

show tables;

CREATE TABLE EmployeeProjects (
    emp_id INT,
    project_id INT,
    role VARCHAR(50),
    PRIMARY KEY (emp_id, project_id),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

INSERT INTO EmployeeProjects VALUES
(1, 101, 'Lead Developer'),
(2, 101, 'Developer'),
(4, 102, 'Project Manager'),
(5, 102, 'Accountant'),
(3, 103, 'Recruiter'),
(6, 104, 'Marketing Specialist');



select * from departments;
select * from `EmployeeProjects`;
select * from employees;
select * from projects;


## Questions and answers
# 1. Select all employees.
select * from employees;


# 2. Get first and last names of all employees in the IT department.
select * from departments;
select * from employees;
select first_name,last_name
from employees
where dept_id = (select dept_id from departments where dept_name = 'IT');


# 3. Find employees with salary greater than 60,000.
select * from employees where salary > 60000;


# 4. Show employees hired after 2020-01-01.
select * from employees where hire_date > 2020-01-01;


# 5. Count total number of employees.
select count(*)  as total_employees from employees;
# 6. Get all distinct department names.
select DISTINCT dept_name from departments;


# 7. Find employees whose first name starts with 'J'.
select first_name from employees where first_name like 'J%';


# 8. Show all employees ordered by salary descending.
select * from employees ORDER BY salary desc;


# 9. Get the highest salary in the company.
select * from employees order by salary DESC limit 1;
select max(salary) as highest_salary from employees;


# 10. Find the lowest salary in Finance department.
select min(salary) as lowest_salary from employees;
select salary as lowest_sal from employees order by salary  limit 1;


# 11. Show number of employees in each department.

Find employees without a manager.

Get the sum of all salaries in the IT department.
select * from employees;
SELECT * from departments;
SELECT d.dept_name,count(e.emp_id) as no_of_employees
from employees e
left join departments d 
on e.dept_id = d.dept_id
group by d.dept_name;


# 12. Show details of employee with emp_id = 3
select * from employees;
select * from employees where emp_id = 3;


# 13. List employees working in more than one project.
select * from projects;
select * from EmployeeProjects;
select* from employees;

select first_name,last_name, count(ep.project_id) as no_of_projects
from employees e
left join EmployeeProjects Ep
on e.emp_id = ep.emp_id
group by e.emp_id
ORDER BY no_of_projects DESC;

select first_name,last_name, count(ep.project_id) as no_of_projects
from employees e
inner join  `EmployeeProjects` ep
on e.emp_id = ep.emp_id
group by e.emp_id
having count(ep.project_id) > 1;;


SELECT e.emp_id, e.first_name, e.last_name, COUNT(ep.project_id) AS project_count
FROM employees e
JOIN employeeprojects ep ON e.emp_id = ep.emp_id
GROUP BY e.emp_id
HAVING COUNT(ep.project_id) > 1;


### B. Intermediate (16–35)
# 14. Join Employees and Departments to show emp_name and dept_name.
select * from employees;
select * from departments;

select  first_name,last_name, dept_name,e.dept_id,emp_id
from employees e
left join  departments d
on e.dept_id = d.dept_id;


# 15. Show employees and their project names (if any).
select e.first_name,last_name,p.project_name
from employees e
left join `EmployeeProjects` ep
on e.emp_id = ep.emp_id
left join projects p
on ep.project_id = p.project_id;   


# 16. List all projects with no employees assigned.
select * from `EmployeeProjects`;
select * from projects;

select p. * from `Projects` p 
left join `EmployeeProjects` ep 
ON
p.project_id = ep.project_id
where ep.emp_id is null;


# 17. Find employees working in "Website Redesign".
select * from `EmployeeProjects`;
select * from projects;
select * from employees;

select e.emp_id,first_name,last_name,project_name
from employees e
left join `EmployeeProjects` ep 
on e.emp_id = ep.emp_id 
left join projects p 
on  p.project_id = ep.project_id
where p.project_name = 'website redesign';


# 18. Show average salary per department.
select * from employees;
select  dept_name,avg(salary) as avg_sal
from employees e
left join departments d
on e.dept_id = d.dept_id
group by dept_name; 


# 19. Find departments with more than 2 employees.
select * from departments;
select * from employees;
select d.dept_id, d.dept_name from 
departments d
left join employees e
on d.dept_id = e.dept_id
group by dept_id
having count(e.emp_id) >2;


# 20. Get employees who are managers (their IDs appear in manager_id column).
select * from employees;
 select first_name,last_name,manager_id
 from employees
 where manager_id is NOT null;


#21 Show employees and their manager names.
select * from employees;
 SELECT 
    e.first_name AS emp_first_name,
    e.last_name AS emp_last_name,
    e.emp_id AS emp_id,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name,
    m.emp_id AS manager_id
FROM employees e
LEFT JOIN employees m 
    ON e.manager_id = m.emp_id
WHERE e.manager_id IS NOT NULL;


# 22. Find employees hired in the year 2021.
select * from employees;
select * from employees where hire_date like "2021%";
select * from employees where hire_date BETWEEN "2021-01-01" and "2021-12-31";


#23. Get all projects that started in 2021.
select * from `Projects`;
select * from `Projects`
where start_date >= "2021-01-01";


# 24.Find employees not assigned to any project.
select * from employees;
select * from `EmployeeProjects`;
select * from  employees e
where e.emp_id not in ( 
  select emp_id from `EmployeeProjects`);


# 25. Show employees working in both "Website Redesign" and "Payroll System".
select * from employees;
select * from `EmployeeProjects`;
select * from projects;
select e.emp_id,e.first_name,e.last_name,p.project_name
from employees e
inner join `EmployeeProjects` ep
on e.emp_id = ep.emp_id
inner join `Projects` p 
on ep.project_id = p.project_id
where p.project_name in ("Webstite redesign","payroll system");


# 26. Find total salary cost for each project.
select * from projects;
select * from `EmployeeProjects`;
select * from employees;

select p.project_id, p.project_name, SUM(e.salary) AS total_salary
from `EmployeeProjects` ep 
join employees e on e.emp_id = ep.emp_id
join projects p on p.project_id = ep.project_id
group by p.project_id, p.project_name
order by p.project_id;;


# 27. List all employees with their role in each project.
select * from employees;
select * from `EmployeeProjects`;
select * from `Projects`;




Find projects handled by the 'Finance' department.



Get employees with salary between 50,000 and 70,000.

Show employees whose last name ends with 'son'.

Find employees whose salary is above average.

Count employees in each project.

Find departments with no projects.

C. Advanced (36–50)
Show top 3 highest-paid employees.

Find employees hired the earliest in each department.p

Get department with the maximum average salary.

Show salary difference between highest and lowest paid employee.

Rank employees by salary in each department.

Show cumulative salary per department ordered by hire_date.

Find employees working in all projects of their department.

Show managers with their number of direct reports.

Get employees whose project duration is more than 5 months.

Find departments with the total salary > 150,000.

List projects with overlapping dates.

Find employees who joined before their manager.

Show total number of employees per hire year.

Show employees who are the only ones in their department.

Delete employees who have no projects assigned. (for practice, run on copy)