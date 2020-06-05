-- Creating tables for PH EmployeeDB
CREATE TABLE departments (
	dept_no varchar(4) not null,
	dept_name varchar(40) not null,
	primary key (dept_no),
	unique (dept_name)
);

-- Creating tables for Employees
CREATE TABLE employees (
	emp_no int not null,
	birth_date date not null,
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	gender varchar (20) not null,
	hire_date date not null,
	primary key (emp_no)
);

-- Create table for dept managers
create table dept_manager (
	dept_no varchar(4) not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key (emp_no,dept_no)
	);
	
-- Create salary table
Create table salaries (
	emp_no int not null,
	salary int not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	primary key (emp_no)
);

-- Create dept employee table
create table dept_emp (
	dept_no varchar(4) not null,
	emp_no int not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no),
	foreign key (dept_no) references departments (dept_no),
	primary key (emp_no,dept_no)
);

-- Create titles table 
create table titles (
	emp_no int not null,
	title varchar (40) not null,
	from_date date not null,
	to_date date not null,
	foreign key (emp_no) references employees (emp_no)
	
);

select * from departments;
select * from titles;

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
