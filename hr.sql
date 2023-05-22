--hr

CREATE TABLE hr.users (
	user_id SERIAL PRIMARY KEY
);

CREATE TABLE hr.work_orders (
	woro_id SERIAL PRIMARY KEY,
	woro_start_date TIMESTAMP,
	woro_status VARCHAR(15) CHECK (woro_status IN ('OPEN', 'CLOSED', 'CANCELLED')),
	woro_user_id INTEGER,
	FOREIGN KEY (woro_user_id) REFERENCES hr.users(user_id)
);

CREATE TABLE hr.facilities (
	faci_id SERIAL PRIMARY KEY
);

CREATE TABLE hr.service_tasks (
	seta_id SERIAL PRIMARY KEY
);

CREATE TABLE hr.job_role (
	joro_id SERIAL PRIMARY KEY,
	joro_name VARCHAR(55) UNIQUE,
	joro_modified_date TIMESTAMP
);

CREATE TABLE hr.employee (
	emp_id SERIAL PRIMARY KEY,
	emp_national_id VARCHAR(25) UNIQUE,
	emp_birth_date TIMESTAMP,
	emp_marital_status CHAR(1) CHECK (emp_marital_status IN ('M', 'S')),
	emp_gender CHAR(1) CHECK (emp_gender IN ('M', 'F')),
	emp_hire_date TIMESTAMP,
	emp_salaried_flag CHAR(1) CHECK (emp_salaried_flag IN ('0', '1')),
	emp_vacation_hours SMALLINT,
	emp_sickleave_hours SMALLINT,
	emp_current_flag SMALLINT CHECK (emp_current_flag IN ('0', '1')),
	emp_photo VARCHAR(255),
	emp_modified_date TIMESTAMP,
	emp_emp_id INTEGER,
	emp_joro_id INTEGER,
	FOREIGN KEY (emp_emp_id) REFERENCES hr.employee(emp_id),
	FOREIGN KEY (emp_joro_id) REFERENCES hr.job_role(joro_id)
);

CREATE TABLE hr.work_order_detail (
	wode_id SERIAL PRIMARY KEY,
	wode_task_name VARCHAR(255),
	wode_status VARCHAR(15) CHECK (wode_status IN ('INPROGRESS', 'COMPLETED', 'CANCELLED')),
	wode_start_date TIMESTAMP,
	wode_end_date TIMESTAMP,
	wode_notes VARCHAR(255),
	wode_emp_id INTEGER,
	wode_seta_id INTEGER,
	wode_faci_id INTEGER,
	wode_woro_id INTEGER,
	FOREIGN KEY (wode_emp_id) REFERENCES hr.employee(emp_id),
	FOREIGN KEY (wode_seta_id) REFERENCES hr.service_tasks(seta_id),
	FOREIGN KEY (wode_faci_id) REFERENCES hr.facilities(faci_id),
	FOREIGN KEY (wode_woro_id) REFERENCES hr.work_orders(woro_id)
);


CREATE TABLE hr.department (
	dept_id SERIAL PRIMARY KEY,
	dept_name VARCHAR(50),
	dept_modified_date TIMESTAMP
);

CREATE TABLE hr.shift (
	shift_id SERIAL PRIMARY KEY,
	shift_name VARCHAR(25) UNIQUE,
	shift_start_time TIMESTAMP UNIQUE,
	shift_end_time TIMESTAMP UNIQUE
);

CREATE TABLE hr.employee_pay_history (
	ephi_emp_id INTEGER,
	ephi_rate_change_date DATE,
	ephi_rate_salary MONEY,
	ephi_pay_frequence SMALLINT CHECK (ephi_pay_frequence IN (1, 2)),
	ephi_modified_date TIMESTAMP,
	CONSTRAINT ephi_rate_change_date_pk PRIMARY KEY (ephi_emp_id, ephi_rate_change_date),
	FOREIGN KEY (ephi_emp_id) REFERENCES hr.employee(emp_id)
);

CREATE TABLE hr.employee_department_history (
	edhi_id SERIAL,
	edhi_start_date TIMESTAMP,
	edhi_end_date TIMESTAMP,
	edhi_modified_date TIMESTAMP,
	edhi_dept_id INTEGER,
	edhi_shift_id INTEGER,
	edhi_emp_id INTEGER,
	CONSTRAINT edhi_emp_id_pk PRIMARY KEY (edhi_id, edhi_emp_id),
	FOREIGN KEY (edhi_dept_id) REFERENCES hr.department(dept_id),
	FOREIGN KEY(edhi_shift_id) REFERENCES hr.shift(shift_id),
	FOREIGN KEY (edhi_emp_id) REFERENCES hr.employee(emp_id)
);

-- Insert data into hr.users
INSERT INTO hr.users (user_id) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
select * from hr.users

-- Insert data into hr.work_orders
INSERT INTO hr.work_orders (woro_id, woro_start_date, woro_status, woro_user_id) VALUES
	(1, '2023-05-01', 'OPEN', 1),
	(2, '2023-05-02', 'CLOSED', 2),
	(3, '2023-05-03', 'OPEN', 3),
	(4, '2023-05-04', 'CLOSED', 1),
	(5, '2023-05-05', 'CANCELLED', 2),
	(6, '2023-05-06', 'OPEN', 3),
	(7, '2023-05-07', 'CLOSED', 1),
	(8, '2023-05-08', 'OPEN', 2),
	(9, '2023-05-09', 'CANCELLED', 3),
	(10, '2023-05-10', 'OPEN', 1);
select * from hr.work_orders

-- Insert data into hr.facilities
INSERT INTO hr.facilities (faci_id) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert data into hr.service_tasks
INSERT INTO hr.service_tasks (seta_id) VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

-- Insert data into hr.department
INSERT INTO hr.department (dept_id, dept_name, dept_modified_date) VALUES
	(1, 'IT', '2023-05-01'),
	(2, 'Sales', '2023-05-02'),
	(3, 'Human Resources', '2023-05-03'),
	(4, 'Administration', '2023-05-04'),
	(5, 'Customer Service', '2023-05-05'),
	(6, 'Operational', '2023-05-06'),
	(7, 'Research and Development', '2023-05-07'),
	(8, 'Production', '2023-05-08'),
	(9, 'Finance', '2023-05-09'),
	(10, 'Marketing', '2023-05-10');
select * from hr.department

-- Insert data into hr.job_role
INSERT INTO hr.job_role (joro_id, joro_name, joro_modified_date) VALUES
	(1, 'Project Manager', '2023-05-01'),
	(2, 'Supervisor', '2023-05-02'),
	(3, 'HR Specialist', '2023-05-03'),
	(4, 'Software Engineer', '2023-05-04'),
	(5, 'Product Manager', '2023-05-05'),
	(6, 'IT Specialist', '2023-05-06'),
	(7, 'Software Developer', '2023-05-07'),
	(8, 'Product Engineer', '2023-05-08'),
	(9, 'Marketing Analyst', '2023-05-09'),
	(10, 'Digital Marketing', '2023-05-10');
select *from hr.job_role

-- Insert data into hr.employee
INSERT INTO hr.employee (emp_id, emp_national_id, emp_birth_date, emp_marital_status, emp_gender, emp_hire_date, emp_salaried_flag, emp_vacation_hours, emp_sickleave_hours, emp_current_flag, emp_photo, emp_modified_date, emp_emp_id, emp_joro_id)
VALUES
	(1, '1234567890', '1990-01-01', 'M', 'M', '2020-01-01', '1', 40, 10, '1', NULL, '2023-05-01', NULL, 1),
	(2, '0987654321', '1995-02-02', 'S', 'F', '2020-02-02', '0', 30, 8, '1', NULL, '2023-05-02', 1, 2),
	(3, '2345678901', '1985-03-03', 'M', 'M', '2020-03-03', '1', 20, 6, '0', NULL, '2023-05-03', 2, 3),
	(4, '3456789012', '1986-09-04', 'M', 'F', '2020-09-04', '1', 30, 4, '0', NULL, '2023-05-04', 3, 4),
	(5, '4567890123', '1992-04-04', 'S', 'F', '2020-04-04', '0', 35, 9, '1', NULL, '2023-05-05', 2, 2),
	(6, '5678901234', '1991-06-06', 'S', 'F', '2020-06-06', '0', 15, 5, '0', NULL, '2023-05-06', 3, 3),
	(7, '6789012345', '1987-07-07', 'M', 'M', '2020-07-07', '1', 30, 8, '1', NULL, '2023-05-07', 1, 1),
	(8, '7890123456', '1993-08-08', 'S', 'F', '2020-08-08', '0', 40, 10, '1', NULL, '2023-05-08', 2, 2),
	(9, '8901234567', '1986-09-09', 'M', 'M', '2020-09-09', '1', 20, 6, '0', NULL, '2023-05-09', 3, 3),
	(10, '9012345678', '1994-10-10', 'S', 'F', '2020-10-10', '0', 25, 7, '1', NULL, '2023-05-10', 1, 1);
select * from hr.employee

-- Insert data into hr.work_order_detail
INSERT INTO hr.work_order_detail (wode_id, wode_task_name, wode_status, wode_start_date, wode_end_date, wode_notes, wode_emp_id, wode_seta_id, wode_faci_id, wode_woro_id)
VALUES
	(1, 'Task 1', 'INPROGRESS', '2023-05-01', '2023-05-02', 'Note 1', 1, 1, 1, 1),
	(2, 'Task 2', 'COMPLETED', '2023-05-02', '2023-05-03', 'Note 2', 2, 2, 2, 2),
	(3, 'Task 3', 'INPROGRESS', '2023-05-03', '2023-05-04', 'Note 3', 3, 3, 3, 3),
	(4, 'Task 4', 'COMPLETED', '2023-05-04', '2023-05-05', 'Note 4', 1, 1, 1, 1),
	(5, 'Task 5', 'CANCELLED', '2023-05-05', '2023-05-06', 'Note 5', 2, 2, 2, 2),
	(6, 'Task 6', 'INPROGRESS', '2023-05-06', '2023-05-07', 'Note 6', 3, 3, 3, 3),
	(7, 'Task 7', 'COMPLETED', '2023-05-07', '2023-05-08', 'Note 7', 1, 1, 1, 1),
	(8, 'Task 8', 'INPROGRESS', '2023-05-08', '2023-05-09', 'Note 8', 2, 2, 2, 2),
	(9, 'Task 9', 'CANCELLED', '2023-05-09', '2023-05-10', 'Note 9', 3, 3, 3, 3),
	(10, 'Task 10', 'INPROGRESS', '2023-05-10', '2023-05-11', 'Note 10', 1, 1, 1, 1);
select * from hr.work_order_detail

-- Insert data into hr.shift
INSERT INTO hr.shift (shift_id, shift_name, shift_start_time, shift_end_time) VALUES
	(1, 'Shift1', '2023-04-10', '2023-05-01'),
	(2, 'Shift2', '2023-04-11', '2023-05-02'),
	(3, 'Shift3', '2023-04-12', '2023-05-03'),
	(4, 'Shift4', '2023-04-13', '2023-05-04'),
	(5, 'Shift5', '2023-04-14', '2023-05-05'),
	(6, 'Shift6', '2023-04-15', '2023-05-06'),
	(7, 'Shift7', '2023-04-16', '2023-05-07'),
	(8, 'Shift8', '2023-04-17', '2023-05-08'),
	(9, 'Shift9', '2023-04-18', '2023-05-09'),
	(10, 'Shift10', '2023-04-19', '2023-05-10');
select * from hr.shift

-- Insert data into hr.employee_pay_history
INSERT INTO hr.employee_pay_history (ephi_emp_id, ephi_rate_change_date, ephi_rate_salary, ephi_pay_frequence, ephi_modified_date) VALUES
	(1, '2023-05-01', 2000.00, 1, '2023-05-01'),
	(2, '2023-05-02', 2200.00, 1, '2023-05-02'),
	(3, '2023-05-01', 1800.00, 1, '2023-05-01'),
	(4, '2023-05-02', 1900.00, 1, '2023-05-02'),
	(5, '2023-05-01', 2500.00, 1, '2023-05-01'),
	(6, '2023-05-02', 2300.00, 1, '2023-05-02'),
	(7, '2023-05-01', 2000.00, 2, '2023-05-01'),
	(8, '2023-05-02', 2200.00, 2, '2023-05-02'),
	(9, '2023-05-01', 1800.00, 2, '2023-05-01'),
	(10, '2023-05-02', 1900.00, 2, '2023-05-02');
select * from hr.employee_pay_history

-- Insert data into hr.employee_department_history
INSERT INTO hr.employee_department_history (edhi_id, edhi_start_date, edhi_end_date, edhi_modified_date, edhi_dept_id, edhi_shift_id, edhi_emp_id) VALUES
	(1, '2023-05-01', NULL, '2023-05-01', 1, 1, 1),
	(2, '2023-05-02', NULL, '2023-05-02', 2, 2, 2),
	(3, '2023-05-03', NULL, '2023-05-03', 3, 3, 3),
	(4, '2023-05-04', NULL, '2023-05-04', 4, 1, 1),
	(5, '2023-05-05', NULL, '2023-05-05', 5, 2, 2),
	(6, '2023-05-06', NULL, '2023-05-06', 6, 3, 3),
	(7, '2023-05-07', NULL, '2023-05-07', 7, 1, 1),
	(8, '2023-05-08', NULL, '2023-05-08', 8, 2, 2),
	(9, '2023-05-09', NULL, '2023-05-09', 9, 3, 3),
	(10, '2023-05-10', NULL, '2023-05-10', 10, 1, 1);
select * from hr.employee_department_history