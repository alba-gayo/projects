-- Exercises Topic 2.2
-- 1
--- a
SELECT Level, AVG(Age) 
FROM student 
GROUP BY Level;
--- b
SELECT Level, AVG(Age) 
FROM student 
WHERE Level NOT 'JR' 
GROUP BY Level;
--- c
SELECT s.Sname 
FROM students AS s, enrolled AS e
WHERE s.Snum NOT IN e.Snum;

-- 2
--- a
SELECT r.codeCriminal, r.number 
FROM records AS r 
INNER JOIN criminals AS c ON r.codeCriminal = c.Code
WHERE r.status = 'open' AND c.type = 'noncommon';
--- b
SELECT b.district, SUM(b.CodePoliceOfficer)
FROM belongs AS b
ORDER BY b.district DES;
--- c
SELECT c.code, c.name, c.alias, c.type, SUM(r.codeCriminal)
FROM criminals AS c , records AS r
WHERE c.code = r.codeCriminal
GROUP BY c.code;

-- 3
--- a 
SELECT e.last_name, e.first_name, j.job_id, j.job_title
FROM employees AS e
INNER JOIN job AS j ON e.job_id = j.job_id
HAVING department_id < 80;
--- b
SELECT e.last_name, e.first_name, d.department_id, d.dept_name
FROM employees AS e
INNER JOIN departments AS d ON e.dept_id = d.department_id;
--- c
SELECT e.last_name, e.first_name, d.department_id, d.dept_name
FROM employees AS e
INNER JOIN departments AS d ON e.dept_id = d.department_id
WHERE e.last_name = 'Higgins';
--- d 
SELECT e.last_name, j.job_title
FROM employees AS e
INNER JOIN job AS j ON e.job_id = j.job_id;
--- e
SELECT e.last_name, j.job_title
FROM employees AS e
INNER JOIN job AS j ON e.job_id = j.job_id
WHERE e.last_name LIKE 'H%';
--- f
SELECT e.last_name, d.department_id, d.dept_name 
FROM employees AS e
RIGHT JOIN department AS d ON e.dept_id = d.department_id;
--- g
SELECT e.last_name, d.department_id, d.dept_name
FROM employees AS e
LEFT JOIN department AS d ON e.dept_id = d.department_id;
--- h
SELECT e.last_name, d.department_id, d.dept_name
FROM employees AS e, department AS d
