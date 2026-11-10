-- =========================================================
-- COLLEGE LIBRARY MANAGEMENT SYSTEM
-- BCA Data Science - SQL Section C Project
-- Database: librarydb
--
-- Complete MySQL 8.0 script containing:
-- database and table creation, sample records, queries C2-C12,
-- stored procedure C13, and trigger C14.
--
-- Reference: https://github.com/Theertharajesh25bca174/library_managementt/blob/main/library_project%5B1%5D.sql
-- This version is added to ShamliJennifer's repository for study,
-- adaptation, testing, and project development. Credit is retained
-- for the original reference rather than presenting copied work as
-- independently authored.
-- =========================================================

CREATE DATABASE librarydb;
USE librarydb;

CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    member_type ENUM('Student','Faculty') NOT NULL,
    joined_date DATE
);

CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2),
    copies_available INT DEFAULT 0
);

-- Issues table links members and books.
CREATE TABLE issues (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Verify table creation.
SHOW TABLES;
DESC members;
DESC books;
DESC issues;

-- =========================================================
-- SAMPLE DATA
-- =========================================================

-- Members (12 rows)
INSERT INTO members (member_name, member_type, joined_date) VALUES
('Aarav Sharma', 'Student', '2025-06-15'),
('Priya Nair', 'Student', '2025-06-15'),
('Rohan Verma', 'Student', '2025-07-01'),
('Dr. Meera Iyer', 'Faculty', '2024-01-10'),
('Kiran Rao', 'Student', '2025-07-20'),
('Prof. Suresh Kumar', 'Faculty', '2023-08-05'),
('Sneha Patil', 'Student', '2025-08-10'),
('Arjun Reddy', 'Student', '2025-08-10'),
('Dr. Anita Desai', 'Faculty', '2024-03-18'),
('Vikram Singh', 'Student', '2025-09-01'),
('Divya Menon', 'Student', '2025-09-12'),
('Rahul Gupta', 'Student', '2025-09-12');

-- Books (15 rows)
INSERT INTO books (title, author, category, price, copies_available) VALUES
('Let Us C', 'Yashavant Kanetkar', 'Programming', 350.00, 3),
('Python Crash Course', 'Eric Matthes', 'Programming', 599.00, 0),
('Java: The Complete Reference', 'Herbert Schildt', 'Programming', 750.00, 2),
('Database System Concepts', 'Silberschatz', 'Database', 850.00, 0),
('Fundamentals of Database Systems', 'Elmasri', 'Database', 799.00, 2),
('SQL in 10 Minutes', 'Ben Forta', 'Database', 299.00, 4),
('Computer Networks', 'Tanenbaum', 'Networking', 699.00, 1),
('Data Communications', 'Forouzan', 'Networking', 650.00, 0),
('Wings of Fire', 'APJ Abdul Kalam', 'Biography', 250.00, 5),
('The Alchemist', 'Paulo Coelho', 'Fiction', 199.00, 3),
('Malgudi Days', 'R.K. Narayan', 'Fiction', 220.00, 2),
('A Brief History of Time', 'Stephen Hawking', 'Science', 399.00, 0),
('Higher Engineering Mathematics', 'B.S. Grewal', 'Mathematics', 550.00, 3),
('Operating System Concepts', 'Galvin', 'Programming', 720.00, 1),
('Discrete Mathematics', 'Kenneth Rosen', 'Mathematics', 680.00, 2);

-- Issues (32 rows)
-- Students: due date = issue date + 14 days.
-- Faculty: due date = issue date + 30 days.
INSERT INTO issues (member_id, book_id, issue_date, due_date, return_date) VALUES
(1, 1, '2026-08-03', '2026-08-17', '2026-08-16'),
(1, 4, '2026-09-01', '2026-09-15', '2026-09-20'),
(1, 2, '2026-10-05', '2026-10-19', '2026-10-18'),
(1, 6, '2026-11-02', '2026-11-16', NULL),
(2, 1, '2026-08-10', '2026-08-24', '2026-08-29'),
(2, 3, '2026-09-07', '2026-09-21', '2026-09-21'),
(2, 4, '2026-10-12', '2026-10-26', '2026-11-02'),
(2, 2, '2026-10-30', '2026-11-13', NULL),
(3, 1, '2026-08-17', '2026-08-31', '2026-09-10'),
(3, 7, '2026-09-14', '2026-09-28', '2026-09-27'),
(3, 8, '2026-10-19', '2026-11-02', NULL),
(4, 5, '2026-08-05', '2026-09-04', '2026-09-02'),
(4, 12, '2026-09-10', '2026-10-10', '2026-10-08'),
(4, 4, '2026-10-15', '2026-11-14', NULL),
(5, 2, '2026-08-24', '2026-09-07', '2026-09-12'),
(5, 6, '2026-09-21', '2026-10-05', '2026-10-04'),
(5, 1, '2026-10-08', '2026-10-22', '2026-10-30'),
(5, 9, '2026-11-04', '2026-11-18', NULL),
(6, 3, '2026-08-12', '2026-09-11', '2026-09-09'),
(6, 7, '2026-09-18', '2026-10-18', '2026-10-16'),
(6, 14, '2026-10-20', '2026-11-19', NULL),
(7, 10, '2026-08-31', '2026-09-14', '2026-09-13'),
(7, 4, '2026-09-28', '2026-10-12', '2026-10-22'),
(7, 11, '2026-10-14', '2026-10-28', '2026-10-27'),
(7, 8, '2026-10-26', '2026-11-09', NULL),
(8, 2, '2026-09-02', '2026-09-16', '2026-09-14'),
(8, 1, '2026-09-23', '2026-10-07', '2026-10-07'),
(8, 6, '2026-10-13', '2026-10-27', '2026-11-05'),
(8, 13, '2026-11-05', '2026-11-19', NULL),
(10, 10, '2026-09-09', '2026-09-23', '2026-09-30'),
(10, 4, '2026-10-22', '2026-11-05', NULL),
(5, 7, '2026-11-03', '2026-11-17', NULL);

-- =========================================================
-- PROJECT QUERIES C2-C12
-- =========================================================

-- C2: Counts of members, books, and issues.
SELECT COUNT(*) FROM members;
SELECT COUNT(*) FROM books;
SELECT COUNT(*) FROM issues;

-- C3: Titles and available copies per category.
SELECT category, COUNT(*) AS titles, SUM(copies_available) AS copies
FROM books
GROUP BY category;

-- C4: Top 5 most borrowed books.
SELECT b.title, COUNT(*) AS times_borrowed
FROM books b
JOIN issues i ON b.book_id = i.book_id
GROUP BY b.title
ORDER BY times_borrowed DESC
LIMIT 5;

-- C5: Members who have never borrowed a book.
SELECT m.member_name
FROM members m
LEFT JOIN issues i ON m.member_id = i.member_id
WHERE i.issue_id IS NULL;

-- C6: Books currently issued.
SELECT m.member_name, b.title, i.due_date
FROM issues i
JOIN members m ON i.member_id = m.member_id
JOIN books b ON i.book_id = b.book_id
WHERE i.return_date IS NULL;

-- C7: Late returns with a fine of Rs. 2 per day.
SELECT m.member_name, b.title, i.due_date, i.return_date,
       DATEDIFF(i.return_date, i.due_date) AS days_late,
       DATEDIFF(i.return_date, i.due_date) * 2 AS fine
FROM issues i
JOIN members m ON i.member_id = m.member_id
JOIN books b ON i.book_id = b.book_id
WHERE i.return_date > i.due_date;

-- C8: Total fine per member.
SELECT m.member_name,
       SUM(DATEDIFF(i.return_date, i.due_date) * 2) AS total_fine
FROM issues i
JOIN members m ON i.member_id = m.member_id
WHERE i.return_date > i.due_date
GROUP BY m.member_name
HAVING total_fine > 0;

-- C9: Student versus faculty borrowing count.
SELECT m.member_type, COUNT(*) AS books_borrowed
FROM issues i
JOIN members m ON i.member_id = m.member_id
GROUP BY m.member_type;

-- C10: Rank members by number of books borrowed.
SELECT m.member_name, COUNT(*) AS books_borrowed,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS rank_no
FROM issues i
JOIN members m ON i.member_id = m.member_id
GROUP BY m.member_name;

-- C11: Number of issues per category.
SELECT b.category, COUNT(*) AS total_issues
FROM issues i
JOIN books b ON i.book_id = b.book_id
GROUP BY b.category
ORDER BY total_issues DESC;

-- C12: Books with zero copies and pending issues.
SELECT title, copies_available
FROM books
WHERE copies_available = 0
  AND book_id IN (SELECT book_id FROM issues WHERE return_date IS NULL);

-- =========================================================
-- C13: STORED PROCEDURE
-- =========================================================

DELIMITER //
CREATE PROCEDURE member_history(IN p_member_id INT)
BEGIN
    SELECT b.title, i.issue_date, i.due_date, i.return_date
    FROM issues i
    JOIN books b ON i.book_id = b.book_id
    WHERE i.member_id = p_member_id;
END //
DELIMITER ;

CALL member_history(1);

-- =========================================================
-- C14: TRIGGER (TESTED USING COPIES OF THE TABLES)
-- =========================================================

CREATE TABLE books_copy LIKE books;
INSERT INTO books_copy SELECT * FROM books;

CREATE TABLE issues_copy LIKE issues;
INSERT INTO issues_copy SELECT * FROM issues;

DELIMITER //
CREATE TRIGGER reduce_copies
AFTER INSERT ON issues_copy
FOR EACH ROW
BEGIN
    UPDATE books_copy
    SET copies_available = copies_available - 1
    WHERE book_id = NEW.book_id;
END //
DELIMITER ;

-- Test the trigger.
SELECT title, copies_available FROM books_copy WHERE book_id = 1;

INSERT INTO issues_copy (member_id, book_id, issue_date, due_date)
VALUES (9, 1, '2026-11-10', '2026-11-24');

SELECT title, copies_available FROM books_copy WHERE book_id = 1;

-- =========================================================
-- END OF PROJECT
-- =========================================================
