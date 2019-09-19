DROP TABLE IF EXISTS employees;
CREATE TABLE employees
(
	emp_no INT PRIMARY KEY NOT NULL,
	birth_date VARCHAR(30) NOT NULL,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	gender VARCHAR(1) NOT NULL,
	hire_date VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS departments;
CREATE TABLE departments
(
	dept_no VARCHAR (4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(30) NOT NULL
);

DROP TABLE IF EXISTS dept_employees;
CREATE TABLE dept_employees
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
	
);

DROP TABLE IF EXISTS dept_managers;
CREATE TABLE dept_managers
(
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
	
);

DROP TABLE IF EXISTS salaries;
CREATE TABLE salaries
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	salary INT NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
	
);

DROP TABLE IF EXISTS titles;
CREATE TABLE titles
(
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	title VARCHAR(30) NOT NULL,
	from_date VARCHAR(30) NOT NULL,
	to_date VARCHAR(30) NOT NULL
	
);

--1 List out the following for each employeer employee number, last name, first name, gender, and salary

SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM salaries AS s
INNER JOIN employees AS e ON
e.emp_no = s.emp_no;

--2 List employees who were hired in 1986

SELECT * FROM employees
WHERE hire_date LIKE '1986%';


--3 List the manager of each department with the following info: department number and department name,
-- manager's employee number, last name, first name, and start and end employment dates.

SELECT d.dept_no, d.dept_name, m.emp_no, e.last_name, e.first_name, m.from_date, m.to_date
FROM departments AS d
INNER JOIN dept_managers AS m ON
m.dept_no = d.dept_no
JOIN employees AS e ON
e.emp_no = m.emp_no;

-- 4 List the department of each employee with the following information:
--employee number, last name, first name, and department name.

SELECT e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_employees AS d ON
e.emp_no = d.emp_no
INNER JOIN departments as dp on
dp.dept_no = d.dept_no;

--5 List all employess whose first name is "Hercules" and last names begin with "B".

SELECT * FROM employees 
WHERE first_name LIKE 'Hercules'
AND last_name LIKE 'B%';

--6 List all employees in the sales dept, including their employee number, last name, first name, 
--and department name

Select e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_employees AS d ON
e.emp_no = D.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales';

-- 7 List all employees in the Sales and Development departments including their employee number, last name, first name, 
--and department name

Select e.emp_no, e.last_name, e.first_name, dp.dept_name
FROM employees AS e
INNER JOIN dept_employees AS d ON
e.emp_no = d.emp_no
INNER JOIN departments AS dp ON
dp.dept_no = d.dept_no
WHERE dp.dept_name LIKE 'Sales'
OR dp.dept_name LIKE 'Development';

--8 In descending order, list the frequency count of employee last name ie how many employees share each last name?

SELECT last_name, COUNT(*)AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;






