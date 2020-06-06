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
	emp_no int not null,
	dept_no varchar(4) not null,
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