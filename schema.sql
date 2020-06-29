-- Creating tables for PH-EmployeeDB

CREATE TABLE departments (
     dept_no varchar(4) NOT NULL,
     dept_name varchar(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

CREATE TABLE employees (
	emp_no int NOT NULL,
    birth_date date NOT NULL,
	first_name varchar NOT NULL,
	last_name  varchar NOT NULL,
	gender varchar NOT NULL,
	hire_date date NOT NULL,
    PRIMARY KEY(emp_no)
);

CREATE TABLE dept_manager (
    dept_no varchar(4) NOT NULL,
	emp_no int NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE salaries (
	emp_no int NOT NULL,
	salary int NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no)
);

CREATE TABLE dept_emp (
	emp_no int NOT NULL,
    dept_no varchar(4) NOT NULL,
	from_date date NOT NULL,
	to_date date NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

CREATE TABLE titles (
	emp_no int NOT NULL,
	title varchar(50) NOT NULL,
	from_date date NOT NULL,
	to_date date,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no, title, from_date)
);