select first_name, last_name
from employees
where birth_date between '1952-01-01' and '1955-12-31';
--90328

select first_name, last_name
from employees
where birth_date between '1952-01-01' and '1952-12-31';
--21600


select first_name, last_name
from employees
where birth_date between '1953-01-01' and '1953-12-31';
--22857

select first_name, last_name
from employees
where birth_date between '1954-01-01' and '1954-12-31';
--23228

select first_name, last_name
from employees
where birth_date between '1955-01-01' and '1955-12-31';
--23104

-- Retirement eligibility
select first_name, last_name
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');
--41380

-- Number of employees retiring
select count(first_name)
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Retirement eligibility - export
select first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Drop table - missing column
drop table retirement_info;

--Create new table for retiring employees
select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');
--Check table
select*from retirement_info;


-- Joining departments and dept_manager tables
select d.dept_name,
		dm.emp_no,
		dm.from_date,
		dm.to_date
from departments as d
inner join dept_manager as dm
on d.dept_no = dm.dept_no;

select*from retirement_info;
select*from dept_emp;
drop table dept_emp cascade;

-- Joining retirement_info and dept_emp tables
select retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_emp.to_date
from retirement_info
left join dept_emp
on retirement_info.emp_no = dept_emp.emp_no;

select ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.to_date
into current_emp
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.to_date=('9999-01-01');

--Employee count by department number
select count(ce.emp_no), de.dept_no
into employee_per_dept
from current_emp as ce
left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
order by de.dept_no;

select*from salaries
order by to_date desc;

--Create new table for retiring employees
select emp_no, first_name, last_name, gender
into emp_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Join with salary table
select e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
into emp_info
from employees as e
inner join salaries as s
on (e.emp_no = s.emp_no)
inner join dept_emp as de
on (e.emp_no = de.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
and (e.hire_date between '1985-01-01' and '1988-12-31')
and (de.to_date = '9999-01-01');

-- List of managers per department
select dm.dept_no, d.dept_name, dm.emp_no, ce.last_name, ce.first_name,
		dm.from_date, dm.to_date
into manager_info
from dept_manager as dm
inner join departments as d
on (dm.dept_no = d.dept_no)
inner join current_emp as ce
on (dm.emp_no = ce.emp_no);

select*from manager_info;

-- list of department retirees
select ce.emp_no, ce.first_name, ce.last_name, d.dept_no
into dept_info
from current_emp as ce
inner join dept_emp as de
on (ce.emp_no = de.emp_no)
inner join departments as d
on (de.dept_no = d.dept_no);

-- Sales retirees
select ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.dept_no
into sales_info
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.dept_no=('d007');

select*from sales_info;

-- Sales and Development retirees
select ri.emp_no,
		ri.first_name,
		ri.last_name,
		de.dept_no
into sales_dev_info
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no 
where de.dept_no in ('d007', 'd005')
order by de.dept_no;

select*from sales_dev_info;

-- Challenge table 1
-- how many employees are retirement-ready per positions
-- create a list that shows how many vacancies they can expect for each job title.
--Employee number, First and last name, Title, from_date, Salary

select*from titles;

select ei.emp_no, ei.first_name, ei.last_name, t.title, t.from_date,
		ei.salary, t.to_date
into table_1Z_temp
from emp_info ei
left join titles as t
on ei.emp_no = t.emp_no;

select emp_no, first_name, last_name, title,from_date,salary
into table_1
from 
	(select emp_no, first_name, last_name, title,from_date,salary,
	row_number() over
	(partition by emp_no
	order by to_date desc) rn
	from table_1Z_temp )
	tmp where rn=1
	order by emp_no;
	
select*from table_1;

select count(emp_no), title
into retirees_per_title
from table_1
group by title
order by title;


-- Challenge table 2
-- Table 2 will list those employees from Table 1 who are eligible for 
-- the mentorship program (birth date that falls between January 1, 1965
-- and December 31, 1965
-- Employee number, First and last name, Title, from_date and to_date

select count(e.emp_no), de.dept_no
into mentor_per_dept
from employees e
inner join dept_emp de
on (e.emp_no = de.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31')
and (de.to_date = '9999-01-01')
group by de.dept_no
order by de.dept_no; 
-- 1549

select e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
into table_2_mentors
from employees e
left join titles as t
on e.emp_no = t.emp_no
where e.birth_date between '1965-01-01' and '1965-12-31'
and t.to_date = '9999-01-01';

select first_name, last_name, count(*)
from table_2_mentors
group by first_name, last_name
having count(*)>1;
-- None

select count (emp_no)
from dept_emp
where to_date = '9999-01-01'
--240124
