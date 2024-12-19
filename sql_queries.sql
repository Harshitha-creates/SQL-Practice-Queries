CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    salary DECIMAL(10, 2),
    department_id INT,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

CREATE TABLE Project (
    project_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

INSERT INTO DEPARTMENT(department_id,name) VALUES (2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

select * from Department;

INSERT INTO Employee (emp_id, name, age, salary, department_id, hire_date) VALUES
(1, 'John Doe', 28, 50000.00, 1, '2020-01-15'),
(2, 'Jane Smith', 34, 60000.00, 2, '2019-07-23'),
(3, 'Bob Brown', 45, 80000.00, 1, '2018-02-12'),
(4, 'Alice Blue', 25, 45000.00, 3, '2021-03-22'),
(5, 'Charlie P.', 29, 50000.00, 2, '2019-12-01'),
(6, 'David Green', 38, 70000.00, 4, '2022-05-18'),
(7, 'Eve Black', 40, 55000.00, 3, '2021-08-30');

select * from Project;
INSERT INTO Project (project_id, name, department_id) VALUES
(2, 'Project Beta', 2),
(3, 'Project Gamma', 1),
(4, 'Project Delta', 3),
(5, 'Project Epsilon', 4),
(6, 'Project Zeta', 4),
(7, 'Project Eta', 3);

--1.Select all columns from the Employee table.
select * from Employee;

--2.Select only the name and salary columns from the Employee table.
select name,salary from Employee;

--3.Select employees who are older than 30.
select * from Employee where age>30;

--4.Select the names of all departments.
select name from Department;

--5.Select employees who work in the IT department.
select e.* from EMPLOYEE e where e.department_id in (select d.department_id from department d where name='IT');




--String Matching Queries

--6.Select employees whose names start with 'J'.
select * from Employee where upper(name) like 'J%';

--7.Select employees whose names end with 'e'.
select * from Employee where lower(name) like '%e';

--8.Select employees whose names contain 'a'.
select * from Employee where lower(name) like '%a%';

--9.Select employees whose names are exactly 9 characters long.
select * from Employee where length(name)=9;

--10.Select employees whose names have 'o' as the second character.
select * from Employee where lower(name) like '_o%';



--Date Queries

--11. Select employees hired in the year 2020.
select * from employee where year(hire_date)='2020';

--12. Select employees hired in January of any year.
Select * from employee where month(hire_date)='01';

--13. Select employees hired before 2019.
select * from employee where year(hire_date)<'2019';

--14. Select employees hired on or after March 1, 2021.
select * from Employee where hire_date>='2021-03-21';

--15. Select employees hired in the last 2 years.
select * from employee where YEAR(CURRENT_DATE) - YEAR(HIRE_DATE) <=2;



--Aggregate Queries

--16.Select the total salary of all employees.
select sum(salary) as total_sal from employee;

--17.Select the average salary of employees.
select avg(salary) as avg_sal from employee;

--18.Select the minimum salary in the Employee table.
select min(salary) from Employee;

--19.Select the number of employees in each department.
select department_id,count(emp_id) as emp_count from Employee group by department_id;

--20.Select the average salary of employees in each department.
select department_id,avg(salary) as avg_sal from Employee group by department_id;



--Group By Queries

--21. Select the total salary for each department.
select department_id,sum(salary) as total_sal from employee group by department_id;

--22. Select the average age of employees in each department.
select department_id,avg(age) from employee group by department_id;

--23. Select the number of employees hired in each year.
select year(hire_date),count(emp_id) from employee group by year(hire_date);

--24.Select the highest salary in each department.
select department_id,max(salary) as max_sal from employee group by department_id;

--25.Select the department with the highest average salary.
select department_id,avg(salary) as highest_avg_sal from employee group by department_id order by avg(salary)desc limit 1;
select max(avg_sal) from (select avg(salary) as avg_sal from Employee group by department_id);



--Having Queries

--26.Select departments with more than 2 employees.
select department_id,count(emp_id) from employee group by department_id having count(emp_id)>2;

--27.Select departments with an average salary greater than 55000.
select avg(salary) as avg_sal from Employee group by department_id having avg_sal>55000;

--28.Select years with more than 1 employee hired.
select year(hire_date),count(emp_id) from Employee group by year(hire_date) having count(emp_id)>1;

--29.Select departments with a total salary expense less than 100000.
select department_id,sum(salary) from Employee group by department_id having sum(salary)<100000;

--30.Select departments with the maximum salary above 75000.
select sum(salary),department_id from Employee group by department_id having sum(salary)>75000;



--Order By Queries

--31.Select all employees ordered by their salary in ascending order.
select * from Employee order by salary ASC;

--32.Select all employees ordered by their age in descending order.
select * from Employee order by age DESC;

--33.Select all employees ordered by their hire date in ascending order.
select * from Employee order by hire_date ASC;

--34.Select employees ordered by their department and then by their salary.
select * from Employee order by department_id ASC , salary ASC;

--35.Select departments ordered by the total salary of their employees.
select sum(salary) as total_sal,department_id from Employee group by department_id order by total_sal DESC;




--Join Queries

--36.Select employee names along with their department names.
select Employee.name as emp_name,Department.name as dept_name from Employee JOIN Department on Employee.department_id=Department.department_id;

--37. Select project names along with the department names they belong to.
select Department.name as Dept_name,Project.name as proj_name from DEPARTMENT join PROJECT on DEPARTMENT.department_id=Project.department_id;

--38.Select employee names and their corresponding project names.
select distinct (Employee.name) as emp_name,Project.name as proj_name from Employee JOIN Department on Employee.department_id=Department.department_id join PROJECT on DEPARTMENT.department_id=Project.department_id;

--39.Select all employees and their departments, including those without a department.
select * from Employee LEFT JOIN DEPARTMENT on Employee.department_id=Department.department_id;

--40.Select all departments and their employees, including departments without employees.
select * from Employee right JOIN DEPARTMENT on Employee.department_id=Department.department_id;

--41.Select employees who are not assigned to any project.
select (Employee.name) from Employee JOIN Department on Employee.department_id=Department.department_id join PROJECT on DEPARTMENT.department_id=Project.department_id where project_id is null;

--42.Select employees and the number of projects their department is working on.
select D.department_id, count(distinct E.emp_id),count(distinct P.project_id) from Employee E JOIN Department D on E.department_id=D.department_id join PROJECT P on D.department_id=P.department_id group by D.department_id;

--43.Select the departments that have no employees.
select D.NAME FROM Employee E right JOIN Department D on E.department_id=D.department_id where emp_id is null;

--44.Select employee names who share the same department with 'John Doe'.
SELECT e2.name AS employee_name
FROM Employee e1
JOIN Employee e2 ON e1.department_id = e2.department_id
WHERE e1.name = 'John Doe' AND e2.name <> 'John Doe';

--45.Select the department name with the highest average salary.
select D.name from Employee E join Department D where salary in (select max(salary) as max_sal from Employee group by department_id order by max_sal desc limit 1) limit 1;



--Nested and Correlated Queries

--46.Select the employee with the highest salary.
select name,salary from Employee where salary in (select max(salary) from employee);

--47.Select employees whose salary is above the average salary.
select name,salary from employee where salary>(select avg(salary) from employee);

--48.Select the second highest salary from the Employee table.
select name,salary from employee where salary<(select max(salary) from employee) order by salary desc limit 1;

--49.Select the department with the most employees.
select name from department where department_id = (select department_id  from employee  group by department_id 
   order by count(*) desc limit 1)

--50.Select employees who earn more than the average salary of their department.
select name,department_id,salary ,avg(salary) over (partition by department_id) as avg_sal from employee qualify salary>avg_sal;

--51.Select the nth highest salary (for example, 3rd highest).
select name,salary from (SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rank
    FROM employee) where rank=5;

--52.Select employees who are older than all employees in the HR department.
select * from employee where age > (select max(employee.age) from Employee JOIN Department on Employee.department_id=Department.department_id where department.name='HR');

--53.Select departments where the average salary is greater than 55000.
select avg(salary) as avg_sal from Employee group by department_id having avg_sal>55000;

--54.Select employees who work in a department with at least 2 projects.
select count(PROJECT_ID),EMP_ID from employee join project on employee.department_id=project.department_id group by emp_id having count(PROJECT_ID)<=2;

--55.Select employees who were hired on the same date as 'Jane Smith'.
select * from employee where hire_date in (select hire_date from employee where name='Jane Smith');

--56.Select the total salary of employees hired in the year 2020.
select sum(salary) from employee where year(hire_date)='2020';

--57.Select the average salary of employees in each department, ordered by the average salary in descending order.
select avg(salary) from employee group by department_id order by avg(salary) desc;

--58.Select departments with more than 1 employee and an average salary greater than 55000.
select department_id,avg(salary),count(emp_id) from employee group by department_id having avg(salary)>55000 and count(emp_id)>1;

--59.Select employees hired in the last 2 years, ordered by their hire date.
select * from employee where year(current_date)- year(hire_date)<=2 order by hire_date;

--60.Select the total number of employees and the average salary for departments with more than 2 employees.
select count(emp_id),avg(salary),department_id from employee group by department_id having count(emp_id)>2;

--61.Select the names of employees who are hired on the same date as the oldest employee in the company.
select name from employee where hire_date in (select hire_date from employee order by hire_date asc limit 1);

--62.Select the name and salary of employees whose salary is above the average salary of their department.
SELECT name, salary, department_id
FROM employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
    WHERE department_id = e.department_id
);

--63.Select the department names along with the total number of projects they are working on, ordered by the number of projects.
select d.name,count(project_id) from department d join project p on d.department_id=p.department_id group by d.name order by count(project_id);

--64.Select the employee name with the highest salary in each department.
SELECT name, salary, department_id
FROM employee e
WHERE salary = (
    SELECT max(salary)
    FROM employee
    WHERE department_id = e.department_id
);

--65.Select the names and salaries of employees who are older than the average age of employees in their department.
SELECT name, salary, department_id
FROM employee e
WHERE salary > (
    SELECT AVG(salary)
    FROM employee
    WHERE department_id = e.department_id
);


