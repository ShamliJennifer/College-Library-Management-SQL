USE librarydb;

-- members (12 rows)
INSERT INTO members (member_name, member_type, joined_date) VALUES
('Aarav Sharma',     'Student', '2025-06-15'),
('Priya Nair',       'Student', '2025-06-15'),
('Rohan Verma',      'Student', '2025-07-01'),
('Dr. Meera Iyer',   'Faculty', '2024-01-10'),
('Kiran Rao',        'Student', '2025-07-20'),
('Prof. Suresh Kumar','Faculty','2023-08-05'),
('Sneha Patil',      'Student', '2025-08-10'),
('Arjun Reddy',      'Student', '2025-08-10'),
('Dr. Anita Desai',  'Faculty', '2024-03-18'),
('Vikram Singh',     'Student', '2025-09-01'),
('Divya Menon',      'Student', '2025-09-12'),
('Rahul Gupta',      'Student', '2025-09-12');

-- books (15 rows)
INSERT INTO books (title, author, category, price, copies_available) VALUES
('Let Us C',                          'Yashavant Kanetkar', 'Programming',  350.00, 3),
('Python Crash Course',               'Eric Matthes',       'Programming',  599.00, 0),
('Java: The Complete Reference',      'Herbert Schildt',    'Programming',  750.00, 2),
('Database System Concepts',          'Silberschatz',       'Database',     850.00, 0),
('Fundamentals of Database Systems',  'Elmasri',            'Database',     799.00, 2),
('SQL in 10 Minutes',                 'Ben Forta',          'Database',     299.00, 4),
('Computer Networks',                 'Tanenbaum',          'Networking',   699.00, 1),
('Data Communications',               'Forouzan',           'Networking',   650.00, 0),
('Wings of Fire',                     'APJ Abdul Kalam',    'Biography',    250.00, 5),
('The Alchemist',                     'Paulo Coelho',       'Fiction',      199.00, 3),
('Malgudi Days',                      'R.K. Narayan',       'Fiction',      220.00, 2),
('A Brief History of Time',           'Stephen Hawking',    'Science',      399.00, 0),
('Higher Engineering Mathematics',    'B.S. Grewal',        'Mathematics',  550.00, 3),
('Operating System Concepts',         'Galvin',             'Programming',  720.00, 1),
('Discrete Mathematics',              'Kenneth Rosen',      'Mathematics',  680.00, 2);

-- issues (32 rows)
-- students: due = issue + 14 days, faculty: due = issue + 30 days
INSERT INTO issues (member_id, book_id, issue_date, due_date, return_date) VALUES
(1, 1,  '2026-08-03', '2026-08-17', '2026-08-16'),
(1, 4,  '2026-09-01', '2026-09-15', '2026-09-20'),
(1, 2,  '2026-10-05', '2026-10-19', '2026-10-18'),
(1, 6,  '2026-11-02', '2026-11-16', NULL),

(2, 1,  '2026-08-10', '2026-08-24', '2026-08-29'),
(2, 3,  '2026-09-07', '2026-09-21', '2026-09-21'),
(2, 4,  '2026-10-12', '2026-10-26', '2026-11-02'),
(2, 2,  '2026-10-30', '2026-11-13', NULL),

(3, 1,  '2026-08-17', '2026-08-31', '2026-09-10'),
(3, 7,  '2026-09-14', '2026-09-28', '2026-09-27'),
(3, 8,  '2026-10-19', '2026-11-02', NULL),

(4, 5,  '2026-08-05', '2026-09-04', '2026-09-02'),
(4, 12, '2026-09-10', '2026-10-10', '2026-10-08'),
(4, 4,  '2026-10-15', '2026-11-14', NULL),

(5, 2,  '2026-08-24', '2026-09-07', '2026-09-12'),
(5, 6,  '2026-09-21', '2026-10-05', '2026-10-04'),
(5, 1,  '2026-10-08', '2026-10-22', '2026-10-30'),
(5, 9,  '2026-11-04', '2026-11-18', NULL),

(6, 3,  '2026-08-12', '2026-09-11', '2026-09-09'),
(6, 7,  '2026-09-18', '2026-10-18', '2026-10-16'),
(6, 14, '2026-10-20', '2026-11-19', NULL),

(7, 10, '2026-08-31', '2026-09-14', '2026-09-13'),
(7, 4,  '2026-09-28', '2026-10-12', '2026-10-22'),
(7, 11, '2026-10-14', '2026-10-28', '2026-10-27'),
(7, 8,  '2026-10-26', '2026-11-09', NULL),

(8, 2,  '2026-09-02', '2026-09-16', '2026-09-14'),
(8, 1,  '2026-09-23', '2026-10-07', '2026-10-07'),
(8, 6,  '2026-10-13', '2026-10-27', '2026-11-05'),
(8, 13, '2026-11-05', '2026-11-19', NULL),

(10, 10, '2026-09-09', '2026-09-23', '2026-09-30'),
(10, 4,  '2026-10-22', '2026-11-05', NULL),

(5, 7,  '2026-11-03', '2026-11-17', NULL);



-- C2: counts
select count(*) from members;
select count(*) from books;
select count(*) from issues;


-- C3: titles and copies per category
select category, count(*) as titles, sum(copies_available) as copies
from books
group by category;


-- C4: top 5 most borrowed books
select b.title, count(*) as times_borrowed
from books b
join issues i on b.book_id = i.book_id
group by b.title
order by times_borrowed desc
limit 5;


-- C5: members who never borrowed
select m.member_name
from members m
left join issues i on m.member_id = i.member_id
where i.issue_id is null;


-- C6: books currently issued
select m.member_name, b.title, i.due_date
from issues i
join members m on i.member_id = m.member_id
join books b on i.book_id = b.book_id
where i.return_date is null;


-- C7: late returns with fine (rs 2 per day)
select m.member_name, b.title, i.due_date, i.return_date,
       datediff(i.return_date, i.due_date) as days_late,
       datediff(i.return_date, i.due_date) * 2 as fine
from issues i
join members m on i.member_id = m.member_id
join books b on i.book_id = b.book_id
where i.return_date > i.due_date;


-- C8: total fine per member
select m.member_name,
       sum(datediff(i.return_date, i.due_date) * 2) as total_fine
from issues i
join members m on i.member_id = m.member_id
where i.return_date > i.due_date
group by m.member_name
having total_fine > 0;


-- C9: student vs faculty
select m.member_type, count(*) as books_borrowed
from issues i
join members m on i.member_id = m.member_id
group by m.member_type;


-- C10: rank members by books borrowed
select m.member_name, count(*) as books_borrowed,
       rank() over (order by count(*) desc) as rank_no
from issues i
join members m on i.member_id = m.member_id
group by m.member_name;


-- C11: issues per category
select b.category, count(*) as total_issues
from issues i
join books b on i.book_id = b.book_id
group by b.category
order by total_issues desc;


-- C12: zero copies and still pending issues
select title, copies_available
from books
where copies_available = 0
  and book_id in (select book_id from issues where return_date is null);


-- C13: stored procedure
delimiter //
create procedure member_history(in p_member_id int)
begin
    select b.title, i.issue_date, i.due_date, i.return_date
    from issues i
    join books b on i.book_id = b.book_id
    where i.member_id = p_member_id;
end //
delimiter ;

call member_history(1);


-- C14: trigger (on copies of the tables)
create table books_copy like books;
insert into books_copy select * from books;

create table issues_copy like issues;
insert into issues_copy select * from issues;

delimiter //
create trigger reduce_copies
after insert on issues_copy
for each row
begin
    update books_copy
    set copies_available = copies_available - 1
    where book_id = new.book_id;
end //
delimiter ;

-- test
select title, copies_available from books_copy where book_id = 1;

insert into issues_copy (member_id, book_id, issue_date, due_date)
values (9, 1, '2026-11-10', '2026-11-24');

select title, copies_available from books_copy where book_id = 1;
