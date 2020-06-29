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


SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- Retirement eligibility
SELECT Count(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
SELECT * FROM retirement_info;

DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
-- Check the table
SELECT * FROM retirement_info;


-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- Make it more readable
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');



-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;


-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;



-- Step by Step
SELECT * FROM salaries;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);




-- -- Challenge 7 Information -- --


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


SELECT emp_no, first_name, last_name
INTO retiring_employees_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT Count(first_name)
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
WHERE dm.to_date = ('9999-01-01');

SELECT eri.emp_no,
eri.first_name,
eri.last_name,
dp.to_date
INTO current_employees
FROM retiring_employees_info as eri
LEFT JOIN dept_emp as dp
ON eri.emp_no = dp.emp_no
WHERE dp.to_date = ('9999-01-01');

SELECT COUNT(ce.emp_no), de.dept_no
FROM current_employees as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT e.emp_no,
e.first_name,
e.last_name,
s.salary,
de.to_date
INTO employees_info
FROM employees as e
INNER JOIN salaries as s
	on(e.emp_no= s.emp_no)
INNER JOIN dept_emp as de
	on(e.emp_no= de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1995-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

SELECT dm.dept_no,
d.dept_name,
dm.emp_no,
ce.last_name,
ce.first_name,
dm.from_date,
dm.to_date
INTO managers_info
FROM dept_manager as dm
	INNER JOIN departments as d
		on (dm.dept_no = d.dept_no)
	INNER JOIN current_employees as ce
		on (dm.emp_no = ce.emp_no);
	
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO department_info
FROM current_employees as ce
	INNER JOIN dept_emp as de
		on(ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		on(de.dept_no = d.dept_no);
		
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO sales_info
FROM current_employees as ce
	INNER JOIN dept_emp as de
		on(ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		on(de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
INTO sales_dev
FROM current_employees as ce
	INNER JOIN dept_emp as de
		on(ce.emp_no = de.emp_no)
	INNER JOIN departments as d
		on(de.dept_no = d.dept_no)
WHERE d.dept_name in ('Sales','Development')
ORDER BY ce.emp_no;



-- -- -- Challenge 7 -- -- --
-- Number of Retiring Employees by Title

SELECT ce.emp_no,
ce.first_name,
ce.last_name,
tt.title,
tt.from_date,
tt.to_date
INTO retirement_employees_titles
FROM current_employees as ce
	INNER JOIN titles as tt
		on(ce.emp_no = tt.emp_no)
ORDER BY ce.emp_no;

select * from retirement_employees_titles;

-- Show only uniques titles
SELECT emp_no,
first_name,
last_name,
title,
to_date
INTO unique_retirement_employees_titles
FROM (
	SELECT emp_no,
	first_name,
	last_name,
	title,
	to_date, ROW_NUMBER( ) OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM retirement_employees_titles
 ) tmp WHERE rn = 1
ORDER BY emp_no;

select * from unique_retirement_employees_titles;

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_retirement_employees_titles
GROUP BY title
ORDER BY count DESC;

select * from retiring_titles;

-- Mentorship Eligibility
SELECT e.emp_no,
e.first_name,
e.last_name,
e.birth_date,
de.from_date,
de.to_date,
tt.title
INTO mentorship_info
FROM employees as e
	INNER JOIN dept_emp as de
		on(e.emp_no = de.emp_no)
	INNER JOIN titles as tt
		on(de.emp_no = tt.emp_no)
WHERE (de.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

select * from mentorship_info;

-- -- -- Challenge 7 END -- -- --