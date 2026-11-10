-- College Library Management System
-- Sample data for the librarydb database
-- Tables: members, books, issues
--
-- IMPORTANT:
-- 1. Run the lecturer-provided library_setup.sql first ONLY if it creates
--    the database and tables without inserting records.
-- 2. This file is intended for empty members, books, and issues tables.
--    Do not run it on top of an already populated database, or duplicate
--    records / primary-key conflicts may occur.
-- 3. All names and borrowing records below are fictional practice data.
--
-- Expected rows inserted: 12 members, 15 books, 32 issue records.

USE librarydb;

START TRANSACTION;

-- ------------------------------------------------------------
-- 1. MEMBERS (12 records)
-- ------------------------------------------------------------

INSERT INTO members (member_name, member_type, joined_date) VALUES
('Aarav Menon',       'Student', '2025-06-12'),
('Diya Sharma',       'Student', '2025-06-18'),
('Kabir Nair',        'Student', '2025-07-03'),
('Dr. Ananya Rao',    'Faculty', '2024-01-15'),
('Ishaan Gupta',      'Student', '2025-07-22'),
('Prof. Rahul Das',   'Faculty', '2023-08-09'),
('Meera Krishnan',    'Student', '2025-08-11'),
('Aditya Joseph',     'Student', '2025-08-19'),
('Dr. Neha Kapoor',   'Faculty', '2024-03-21'),
('Sana Thomas',       'Student', '2025-09-04'),
('Rohan Pillai',      'Student', '2025-09-14'),
('Kavya Reddy',       'Student', '2025-10-02');

-- ------------------------------------------------------------
-- 2. BOOKS (15 records)
-- ------------------------------------------------------------

INSERT INTO books (title, author, category, price, copies_available) VALUES
('C Programming Absolute Beginner Guide', 'Greg Perry', 'Programming', 450.00, 4),
('Python for Everybody',                 'Charles Severance', 'Programming', 520.00, 3),
('Java: A Beginner Guide',                'Herbert Schildt', 'Programming', 680.00, 2),
('Learning SQL',                          'Alan Beaulieu', 'Database', 599.00, 2),
('Database System Concepts',              'Abraham Silberschatz', 'Database', 850.00, 1),
('SQL Queries for Mere Mortals',          'John Viescas', 'Database', 720.00, 3),
('Computer Networks',                     'Andrew Tanenbaum', 'Networking', 699.00, 2),
('Data Communications and Networking',    'Behrouz Forouzan', 'Networking', 640.00, 2),
('Wings of Fire',                         'A. P. J. Abdul Kalam', 'Biography', 250.00, 5),
('The Guide',                             'R. K. Narayan', 'Fiction', 230.00, 3),
('The Blue Umbrella',                     'Ruskin Bond', 'Fiction', 180.00, 4),
('A Brief History of Time',               'Stephen Hawking', 'Science', 420.00, 2),
('The Theory of Everything',              'Stephen Hawking', 'Science', 390.00, 2),
('Discrete Mathematics',                  'Kenneth Rosen', 'Mathematics', 680.00, 2),
('Operating System Concepts',             'Abraham Silberschatz', 'Operating Systems', 790.00, 1);

-- ------------------------------------------------------------
-- 3. ISSUES (32 records)
-- Student borrowing period: 14 days
-- Faculty borrowing period: 30 days
-- NULL return_date means the book is still issued.
-- ------------------------------------------------------------

INSERT INTO issues (member_id, book_id, issue_date, due_date, return_date) VALUES
(1,  1,  '2026-08-03', '2026-08-17', '2026-08-16'),
(1,  4,  '2026-09-02', '2026-09-16', '2026-09-20'),
(1,  2,  '2026-10-06', '2026-10-20', '2026-10-18'),
(1,  6,  '2026-11-02', '2026-11-16', NULL),

(2,  1,  '2026-08-11', '2026-08-25', '2026-08-29'),
(2,  3,  '2026-09-08', '2026-09-22', '2026-09-22'),
(2,  5,  '2026-10-12', '2026-10-26', '2026-11-01'),
(2,  2,  '2026-10-30', '2026-11-13', NULL),

(3,  1,  '2026-08-18', '2026-09-01', '2026-08-31'),
(3,  7,  '2026-09-15', '2026-09-29', '2026-10-03'),
(3,  8,  '2026-10-19', '2026-11-02', NULL),

(4,  5,  '2026-08-05', '2026-09-04', '2026-09-02'),
(4, 12,  '2026-09-10', '2026-10-10', '2026-10-08'),
(4,  4,  '2026-10-15', '2026-11-14', NULL),

(5,  2,  '2026-08-24', '2026-09-07', '2026-09-12'),
(5,  6,  '2026-09-21', '2026-10-05', '2026-10-04'),
(5,  9,  '2026-10-08', '2026-10-22', '2026-10-30'),
(5, 10,  '2026-11-04', '2026-11-18', NULL),

(6,  3,  '2026-08-12', '2026-09-11', '2026-09-09'),
(6,  7,  '2026-09-18', '2026-10-18', '2026-10-16'),
(6, 15,  '2026-10-20', '2026-11-19', NULL),

(7, 11,  '2026-08-31', '2026-09-14', '2026-09-13'),
(7,  5,  '2026-09-28', '2026-10-12', '2026-10-22'),
(7, 10,  '2026-10-14', '2026-10-28', '2026-10-27'),
(7,  8,  '2026-10-26', '2026-11-09', '2026-11-08'),

(8,  2,  '2026-09-02', '2026-09-16', '2026-09-14'),
(8,  1,  '2026-09-23', '2026-10-07', '2026-10-07'),
(8,  6,  '2026-10-13', '2026-10-27', '2026-11-05'),
(8, 14,  '2026-11-05', '2026-11-19', NULL),

(9, 13,  '2026-08-14', '2026-09-13', '2026-09-10'),
(9,  4,  '2026-09-25', '2026-10-25', '2026-10-27'),

(10, 10, '2026-09-09', '2026-09-23', '2026-09-30'),
(10,  5, '2026-10-22', '2026-11-05', NULL);

COMMIT;

-- ------------------------------------------------------------
-- 4. VERIFY THE INSERTED SAMPLE DATA
-- ------------------------------------------------------------

SELECT COUNT(*) AS total_members FROM members;
SELECT COUNT(*) AS total_books FROM books;
SELECT COUNT(*) AS total_issue_records FROM issues;

-- Preview member records
SELECT * FROM members ORDER BY member_id;

-- Preview book records
SELECT * FROM books ORDER BY book_id;

-- Preview issue records with member and book names
SELECT i.issue_id, m.member_name, b.title,
       i.issue_date, i.due_date, i.return_date
FROM issues AS i
JOIN members AS m ON m.member_id = i.member_id
JOIN books AS b ON b.book_id = i.book_id
ORDER BY i.issue_id;
