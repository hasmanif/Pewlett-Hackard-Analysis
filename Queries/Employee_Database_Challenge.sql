-- Create and export table on employee titles
SELECT e.emp_no,
     e.first_name,
     e.last_name,
     ti.title,
	 ti.from_date,
	 ti.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
--INTO retirement_clean
FROM retirement_titles
ORDER BY emp_no ASC, to_date DESC;

-- Number of employees about to retire
SELECT COUNT (r.emp_no), r.title
INTO retiring_titles
FROM retirement_clean AS r
GROUP BY r.title
ORDER BY count DESC;

-- Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
     e.first_name,
     e.last_name,
	 e.birth_date,
	 d.from_date,
	 d.to_date,
	 ti.title
INTO mentorship_eligible
FROM employees AS e
INNER JOIN dept_emp AS d
ON e.emp_no = d.emp_no
INNER JOIN titles AS ti
ON e.emp_no = ti.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND (d.to_date = '9999-01-01')
ORDER BY e.emp_no;

