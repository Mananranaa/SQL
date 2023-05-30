use man;
select * from employee_hr_data;
-- Q1 From the following table, write a SQL query to find those employees 
-- who receive a higher salary than the employee with ID 163. Return first name, last name.
select salary from employee_hr_data where employee_id=163;
select first_name,last_name from employee_hr_data where salary>(select salary from employee_hr_data where employee_id=163);
-- Q2From the following table, write a SQL query to find out which employees have the same designation as the employee whose ID is 169.
--  Return first name, last name, department ID and job ID.
select job_id from employee_hr_data where employee_id=169;
select first_name,last_name,department_id,job_id from employee_hr_data where 
job_id in (select job_id from employee_hr_data where employee_id=169);
-- Q3 From the following table, write a SQL query to find those employees whose salary matches the lowest salary of any of the departments. 
-- Return first name, last name and department ID.  
select min(salary) as salary from employee_hr_data group by department_id;
select first_name,last_name,department_id from employee_hr_data where 
salary in (select min(salary) as salary from employee_hr_data group by department_id);
-- Q4From the following table, write a SQL query to find those employees who earn more than the average salary. 
-- Return employee ID, first name, last name.
select avg(salary) from employee_hr_data;
select employee_id,first_name,last_name,salary from employee_hr_data where 
salary>(select avg(salary) from employee_hr_data);
-- Q5 From the following table, write a SQL query to find those employees who report to that manager whose first name is ‘Payam’. 
-- Return first name, last name, employee ID and salary.
select employee_id from employee_hr_data where first_name like '%Payam%';
select first_name,last_name,employee_id,salary from employee_hr_data 
where manager_id in (select employee_id from employee_hr_data where first_name like '%Payam%');
--  Q6From the following tables, write a SQL query to find all those employees who work in the Finance department.
 -- Return department ID, name (first), job ID and department name.
 select department_name from department_hr_data where department_name like '%Finance%';
select department_id from department_hr_data where department_name like  '%Finance%';
select e.first_name,e.department_id,e.job_id,d.department_name
from employee_hr_data e join department_hr_data d on e.department_id=d.department_id
where e.department_id in (select department_id from department_hr_data where department_name like  '%Finance%');
-- Q7 From the following table, write a SQL query to find the employee 
-- whose salary is 3000 and reporting person’s ID is 121. Return all fields. 
select * from employee_hr_data where salary=3000 and manager_id=121;
 -- Q8 From the following table, write a SQL query to find those employees whose ID 
 -- matches any of the numbers 134, 159 and 183.Return all the fields.
 select * from employee_hr_data where employee_id in (134,159,183);
 -- Q9 From the following table, write a SQL query to find those employees 
 -- whose salary is in the range of 1000, and 3000 (Begin and end values have included.). Return all the fields. 
 select * from employee_hr_data where salary between 1000 and 3000;
 -- Q10 From the following table and write a SQL query to find those employees whose salary falls 
 -- within the range of the smallest salary and 2500. Return all the fields. 
select * from employee_hr_data where salary between(select min(salary) from employee_hr_data) and 2500;
--  Q11 From the following tables, write a SQL query to find those employees who do not work 
-- in the departments where managers’ IDs are between 100 and 200 (Begin and end values are included.). Return all the fields of the employeess.
select department_id from department_hr_data where manager_id between 100 and 200;
select * from employee_hr_data 
where department_id not in ( select department_id from department_hr_data where manager_id between 100 and 200);
--  Q12From the following table, write a SQL query to find those employees who get second-highest salary.
--  Return all the fields of the employees.
With Salaries_rank as(select employee_id,first_name,department_id,manager_id,salary, dense_rank() over(order by salary desc) as sal_rank
 from employee_hr_data)
 select * from Salaries_rank salary where sal_rank=2;
 -- Q13  From the following tables, write a SQL query to find those employees who work in the same department as ‘Clara’.
-- Exclude all those records where first name is ‘Clara’. Return first name, last name and hire date;
select department_id from employee_hr_data where first_name like '%Clara%';
select first_name,last_name,hire_date from employee_hr_data 
where department_id in (select department_id from employee_hr_data where first_name like '%Clara%') and first_name not like '%Clara%';
--  Q14 From the following tables, write a SQL query to find those employees who work in a department 
-- where the employee’s first name contains the letter 'T'. Return employee ID, first name and last name.
select department_id from employee_hr_data where first_name like '%T%';
select employee_id,first_name,last_name from employee_hr_data  
where department_id in (select department_id from employee_hr_data where first_name like '%T%');
-- Q15 From the following tables, write a SQL query to find those 
-- employees who earn more than the average salary and work in the same department as an employee 
-- whose first name contains the letter 'J'. Return employee ID, first name and salary.
select department_id from employee_hr_data where first_name like '%J%';
select employee_id,first_name,salary from employee_hr_data 
where salary>(select avg(salary) from employee_hr_data) 
and department_id in ( select department_id from employee_hr_data where first_name like '%J%');
-- Q16 From the following table, write a SQL query to find those employees whose department is located at ‘Munich’.
--  Return first name, last name, employee ID, job ID;
select location_id from location_hr_data where city like '%mun%' ;
select department_id from department_hr_data where 
location_id in ( select location_id from location_hr_data where city like '%mun%');
select first_name,last_name,employee_id,job_id from employee_hr_data 
where department_id in ( select department_id from department_hr_data where 
location_id in ( select location_id from location_hr_data where city like '%mun%'));
-- Q17 From the following table, write a SQL query to find those employees whose 
-- salary is lower than that of employees whose job title is ‘MK_MAN’. 
-- Return employee ID, first name, last name, job ID.
select salary from employee_hr_data where job_id like '%MK_MAN%';
select employee_id,first_name,last_name,job_id from employee_hr_data 
where salary<( select salary from employee_hr_data where job_id like '%MK_MAN%');
-- Q18 From the following table, write a SQL query to find those employees 
-- whose salary is lower than that of employees whose job title is "MK_MAN". 
-- Exclude employees of Job title ‘MK_MAN’. Return employee ID, first name, last name, job ID.
select employee_id,first_name,last_name,job_id from employee_hr_data 
where salary<(select salary from employee_hr_data where job_id like '%MK_MAN%') and job_id not like '%MK_MAN%';
--  Q19 From the following table, write a SQL query to find those employees
 -- whose salary exceeds the salary of all those employees whose job title is "PU_MAN".
--  Exclude job title ‘PU_MAN’. Return employee ID, first name, last name, job ID.
select employee_id,first_name,last_name,job_id from employee_hr_data 
where salary>(select salary from employee_hr_data where job_id like '%PU_MAN%') and job_id not like '%PU_MAN%';
-- Q20 From the following table, write a SQL query to find those employees
-- whose salaries are higher than the average for all departments. Return employee ID, first name, last name, job ID.
select avg(salary) as avg_saldep from employee_hr_data group by department_id ;
select employee_id,first_name,last_name,job_id from employee_hr_data where
salary>all(select avg(salary) as avg_saldep from employee_hr_data group by department_id );
 -- Q21 From the following table, write a SQL query to check whether there are any employees with salaries exceeding 3700.
 -- Return first name, last name and department ID;
select first_name,last_name,department_id from employee_hr_data where salary<3700;
-- Q22 From the following table, write a SQL query to calculate
 -- total salary of the departments where at least one employee works. Return department ID, total salary.
 select sum(salary) as total_sal,department_id as sal_dp from employee_hr_data group by department_id having count(*)>0 order by department_id;
  -- Q23 Write a query to display the employee id, name ( first name and last name ) 
 -- and the job id column with a modified title SALESMAN
 -- for those employees whose job title is ST_MAN and DEVELOPER for whose job title is IT_PROG.
 select employee_id,concat(first_name,' ',last_name) as emp_name, 
 case when job_id like '%ST_MAN%' then 'SALESMAN' when job_id like '%IT_PROG%' then 'DEVELOPER'
 else job_id end as job_id_modify from employee_hr_data;
 -- Q24 Write a query to display the employee id, name ( first name and last name ),
--  salary and the SalaryStatus column with a title HIGH and LOW respectively for those 
-- employees whose salary is more than and less than the average salary of all employees.
select employee_id,concat(first_name,' ',last_name) as name,
case when salary>(select avg(salary) from employee_hr_data) then 'HIGH' 
when salary<(select avg(salary) from employee_hr_data) then 'LOW'
else salary end as salary_status  from employee_hr_data ;
-- Q 25 Write a query to display the employee id, name ( first name and last name ), 
-- SalaryDrawn, AvgCompare (salary - the average salary of all employees)
 -- and the SalaryStatus column with a title HIGH and LOW respectively for 
 -- those employees whose salary is more than and less than the average salary of all employees;
 select employee_id,concat(first_name,' ',last_name) as name, salary as salary_drawn,
salary-(select avg(salary) from employee_hr_data) as avg_compare, 
case when salary>(select avg(salary) from employee_hr_data) then 'HIGH' 
when salary<(select avg(salary) from employee_hr_data) then 'LOW' 
else salary end as salary_status from employee_hr_data;
-- Q26 From the following table, write a SQL query to find all those departments 
-- where at least one employee is employed. Return department name;
select d.department_name from 
employee_hr_data e join department_hr_data d on e.department_id=d.department_id 
group by d.department_name having  count(*)>0 ;
-- Q27 From the following tables, write a SQL query to find employees 
-- who work in departments located in the United States of America. Return first name;
select country_id from countries_hr_data where country_id like '%US%';
select location_id from location_hr_data where 
country_id in (select country_id from countries_hr_data where country_id like '%US%');
select department_id from department_hr_data where 
location_id in ( select location_id from location_hr_data where 
country_id in (select country_id from countries_hr_data where country_id like '%US%'));
select first_name from employee_hr_data 
where department_id in ( select department_id from department_hr_data where 
location_id in ( select location_id from location_hr_data where 
country_id in (select country_id from countries_hr_data where country_id like '%US%')));
-- Q28 From the following table, write a SQL query to find out which employees are earning more than the average salary 
-- and who work in any of the IT departments. Return last name. 
select department_id from department_hr_data where department_name like 'IT%'; 
select last_name from employee_hr_data where 
salary>(select avg(salary) from employee_hr_data)
and department_id in (select department_id from department_hr_data where department_name like 'IT%');
-- Q29From the following table, write a SQL query to find all those employees who earn more than an employee whose last name is 'Ozer'. 
-- Sort the result in ascending order by last name. Return first name, last name and salary.
select salary from employee_hr_data where last_name like '%ozer%';
select first_name,last_name,salary from employee_hr_data where 
salary>(select salary from employee_hr_data where last_name like '%ozer%') order by last_name;
-- Q30  From the following tables, write a SQL query find the employees who report to a manager 
-- based in the United States. Return first name, last name.
select location_id from location_hr_data where country_id like '%US%';
select department_id from department_hr_data where 
location_id in (select location_id from location_hr_data where country_id like '%US%');
select first_name,last_name,manager_id from employee_hr_data 
where manager_id in (select employee_id from employee_hr_data 
where department_id in ( select department_id from department_hr_data where 
location_id in (select location_id from location_hr_data where country_id like '%US%')));
-- Q31 From the following tables, write a SQL query to find those employees whose salaries exceed 50% of their
--  department's total salary bill. Return first name, last name
select sum(salary)/50 from employee_hr_data group by department_id;
select e.first_name,e.last_name,e.salary from employee_hr_data e
where salary>(select sum(salary)/2 from employee_hr_data  e1 where e.department_id=e1.department_id);
-- Q32  From the following tables, write a SQL query to find those employees who are managers.
 -- Return all the fields of employees table.
select * from employee_hr_data where 
manager_id in (select distinct(manager_id) from employee_hr_data);
-- Q33  From the following table, write a SQL query to find those employees who manage a department.
--  Return all the fields of employees table.
select * from employee_hr_data where 
employee_id in (select distinct(manager_id) from department_hr_data);
select manager_id from department_hr_data;
select employee_id from employee_hr_data where first_name like '%Steven%' or first_name like '%Neena%';
-- q34 From the following table, write a SQL query to search for employees who receive such a salary, 
-- which is the maximum salary for salaried employees, hired between 
-- January 1st, 2002 and December 31st, 2003. Return employee ID, first name, 
-- last name, salary, department name and city.
select max(salary) from employee_hr_data where hire_date in (2002,2003);
select e.employee_id,e.first_name,e.last_name,e.salary,d.department_name,l.city from 
employee_hr_data e join department_hr_data d on e.department_id=d.department_id join 
location_hr_data l on d.location_id=l.location_id join countries_hr_data c on l.country_id=c.country_id
 where e.salary =(select max(salary) 
from employee_hr_data where hire_date in (2002,2003));
--  q35 From the following tables, write a SQL query to find those departments that are located in the city of munich. 
--  Return department ID, department name.
select location_id from location_hr_data where city like '%munich%';
select department_id,department_name from department_hr_data where 
location_id =(select location_id from location_hr_data where city like '%munich%');
-- q36 From the following table, write a SQL query to find those employees who earn more than the average salary. Sort the result-set in descending order by salary. 
-- Return first name, last name, salary, and department ID.
select first_name,last_name,salary,department_id from employee_hr_data
where salary>(select avg(salary) from employee_hr_data) order by salary desc;
 -- q 37 From the following table, write a SQL query to find those employees who earn more than the maximum salary for a department of ID 40.
--  Return first name, last name and department ID. 
select max(salary) from employee_hr_data where department_id=40;
select first_name,last_name,department_id from employee_hr_data 
where salary>(select max(salary) from employee_hr_data where department_id=40);
 -- q 38 From the following table, write a SQL query to find departments for a particular location. 
 -- The location matches the location of the department of ID 30. Return department name and department ID;
 select location_id from department_hr_data where department_id=30;
select department_name,department_id from department_hr_data 
where location_id=( select location_id from department_hr_data where department_id=30);
-- Q39 From the following table, write a SQL query to find employees 
-- who work for the department in which employee ID 201 is employed.
 -- Return first name, last name, salary, and department ID;
 select first_name,last_name,salary,department_id from employee_hr_data
 where department_id in (select department_id from employee_hr_data where employee_id=201);
--  Q40 From the following table, write a SQL query to find those employees whose salary matches
--  that of the employee who works in department ID 40.
--  Return first name, last name, salary, and department ID.
 select first_name,last_name,salary,department_id from employee_hr_data
 where salary in (select salary from employee_hr_data where department_id=40);
 --  Q41 From the following table, write a SQL query to find those employees who work in the department 'Marketing'.
--  Return first name, last name and department ID. 
select first_name,last_name,department_id from employee_hr_data where 
department_id =(select department_id from department_hr_data where department_name like '%Marketing%');
 -- Q42 From the following table, write a SQL query to find those employees who earn 
 -- more than the minimum salary of a department of ID 40. Return first name, last name, salary, and department ID;
 select trim(first_name),last_name,salary,department_id from employee_hr_data
 where salary>(select min(salary) from employee_hr_data where department_id=40);
--  Q43 From the following table, write a SQL query to find those employees who joined after the employee whose ID is 165.
--   Return first name, last name and hire date. 
select hire_date from employee_hr_data where employee_id=165;
select first_name,last_name,hire_date from employee_hr_data 
where hire_date>( select hire_date from employee_hr_data where employee_id=165);
-- Q44 From the following table, write a SQL query to find those employees who earn less than 
-- the minimum salary of a department of ID 70. Return first name, last name, salary, and department ID.
select first_name,last_name,salary,department_id from employee_hr_data
where salary<(select min(salary) from employee_hr_data where department_id=70);
-- Q45 From the following table, write a SQL query to find those employees
 -- who earn less than the average salary and 
-- work at the department where Laura (first name) is employed. Return first name, last name, salary, and department ID; 
select first_name,last_name,salary,department_id from employee_hr_data where
salary<(select avg(salary) from employee_hr_data)
 and department_id=(select department_id from employee_hr_data where first_name like '%Laura%');
-- Q46 From the following tables, write a SQL query to find all employees whose department is located in Munich.
--  Return first name, last name, salary, and department ID.
select first_name,last_name,salary,department_id from employee_hr_data 
where department_id in ( select department_id from department_hr_data where 
location_id in ( select location_id from location_hr_data where city like '%Munich%'));
-- Q47 From the following tables, write a SQL query to find the city of the employee of ID 134. Return city. 
select l.city from location_hr_data l join department_hr_data d on l.location_id=d.location_id
join employee_hr_data e on d.department_id=e.department_id where e.employee_id=134;
select city from location_hr_data where 
location_id in (select location_id from department_hr_data where 
department_id in (select department_id from employee_hr_data where employee_id=134));
-- Q48 From the following tables, write a SQL query to find those departments where maximum salary is 7000 and above.
 -- The employees worked in those departments have already completed one or more jobs. 
 -- Return all the fields of the departments;
 select * from department_hr_data where 
 department_id in (select department_id from employee_hr_data where 
 employee_id in (select employee_id from job_history_hr_data group by
 employee_id having count(*)>1) group by department_id having max(salary)>=7000);
  -- Q49 From the following tables, write a SQL query to find those
 -- departments where the starting salary is at least 8000. Return all the fields of departments;
 select * from department_hr_data where 
department_id in (select department_id from employee_hr_data  group by department_id having min(salary)>=8000);
--  Q50 From the following table, write a SQL query to find those managers who supervise four or more employees.
--  Return manager name, department ID.
select manager_id from employee_hr_data group by manager_id having count(*)>=4;
select trim(concat(first_name,' ',last_name)) as manager_name, department_id from employee_hr_data 
where employee_id in (select manager_id from employee_hr_data group by manager_id having count(*)>=4);
 -- Q51 From the following table, write a SQL query to find employees who have previously worked as 'Sales Representatives'.
--  Return all the fields of jobs.
select * from jobs_hr_data where
job_id in (select job_id from employee_hr_data where 
employee_id in (select employee_id from job_history_hr_data where 
job_id like '%SA_REP%'));
--  Q53 From the following table, write a SQL query to find those employees who earn the
 -- second-lowest salary of all the employees.
--  Return all the fields of employees. 
With Sal_list as (select first_name,last_name,hire_date,salary,dense_rank() over(order by salary) as sal_rank
 from employee_hr_data ) select * from sal_list where sal_rank=2;
  -- Q53  From the following table, write a SQL query to find the departments managed by Susan. 
 -- Return all the fields of departments;
 select * from department_hr_data where 
 department_id in (select department_id from employee_hr_data where 
 first_name like '%Susan%');
  -- Q54 From the following table, write a SQL query to find those employees who earn the highest 
--   salary in a department.
--   Return department ID, employee name, and salary
select max(salary) as sallist,department_id  from employee_hr_data group by department_id;
select department_id,concat(first_name,' ',last_name) as employee_name,salary from employee_hr_data where
salary in ( select max(salary) as sallist  from employee_hr_data group by department_id);
 -- Q55 From the following table, write a SQL query to find those employees who have not had a job in the past.
 -- Return all the fields of employees.
 select * from employee_hr_data where 
 employee_id not in (select employee_id from job_history_hr_data);
 select e.first_name,e.last_name,e.salary,d.department_name,
  case when e.job_id like '%SA_MAN%' then 'Salesman' when e.job_id like '%IT_Prog%' then 'developer' 
else e.job_id end  as job_id_modify from 
employee_hr_data e join department_hr_data d on e.department_id=d.department_id ;
 
 