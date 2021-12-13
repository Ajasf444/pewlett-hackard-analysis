-- Create the retirement_titles table
select 
	e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
into
	retirement_titles
from
	employees e
join 
	titles t
	on
	e.emp_no = t.emp_no
where
	e.birth_date >= '1952-01-01'
	and
	e.birth_date <= '1955-12-31'
order by
	e.emp_no;

-- Create the unique_titles table
select distinct on (emp_no)
	emp_no,
	first_name,
	last_name,
	title
into 
	unique_titles
from 
	retirement_titles
order by 
	emp_no, 
	to_date desc;
	
-- Create the retiring_titles table	
select 
	count(title),
	title
into
	retiring_titles
from
	unique_titles
group by
	title
order by
	count(title) desc;

-- Create the mentorship_eligibility table
select distinct on (e.emp_no)
	e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
into
	mentorship_eligibility
from
	employees e
join
	dept_emp de
	on
	e.emp_no = de.emp_no
join
	titles t
	on
	e.emp_no = t.emp_no
where
	de.to_date = '9999-01-01'
	and
	e.birth_date >= '1965-01-01'
	and
	e.birth_date <= '1965-12-31'
order by 
	e.emp_no;