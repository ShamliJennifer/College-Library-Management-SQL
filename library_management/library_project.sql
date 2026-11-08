-- College Library Management System
-- MySQL 8.0+
-- Run the lecturer-provided library_setup.sql first, then run this file.
-- This file contains C2-C14. C1 is the ERD; C15 is the written recommendation.

USE librarydb;

-- Check the original tables and sample rows before beginning.
SELECT * FROM members LIMIT 5;
SELECT * FROM books LIMIT 5;
SELECT * FROM issues LIMIT 5;

-- C2. Count members, books, and issue records.
SELECT COUNT(*) AS total_members FROM members;
SELECT COUNT(*) AS total_books FROM books;
SELECT COUNT(*) AS total_issue_records FROM issues;

-- C3. Number of titles and total available copies in each category.
SELECT category,
       COUNT(DISTINCT book_id) AS number_of_titles,
       SUM(copies_available) AS total_copies_available
FROM books
GROUP BY category
ORDER BY category;

-- C4. Five most-borrowed books.
SELECT b.book_id, b.title, b.author, COUNT(i.issue_id) AS times_borrowed
FROM books AS b
JOIN issues AS i ON i.book_id = b.book_id
GROUP BY b.book_id, b.title, b.author
ORDER BY times_borrowed DESC, b.title
LIMIT 5;

-- C5. Members who have never borrowed a book.
SELECT m.member_id, m.member_name, m.member_type
FROM members AS m
LEFT JOIN issues AS i ON i.member_id = m.member_id
WHERE i.issue_id IS NULL
ORDER BY m.member_id;

-- C6. Books currently issued and not yet returned.
SELECT m.member_name, b.title, i.issue_date, i.due_date
FROM issues AS i
JOIN members AS m ON m.member_id = i.member_id
JOIN books AS b ON b.book_id = i.book_id
WHERE i.return_date IS NULL
ORDER BY i.due_date;

-- C7. Returned books that were late. Fine = Rs. 2 per late day.
SELECT i.issue_id, m.member_name, b.title, i.due_date, i.return_date,
       DATEDIFF(i.return_date, i.due_date) AS days_late,
       DATEDIFF(i.return_date, i.due_date) * 2 AS fine_rupees
FROM issues AS i
JOIN members AS m ON m.member_id = i.member_id
JOIN books AS b ON b.book_id = i.book_id
WHERE i.return_date IS NOT NULL
  AND i.return_date > i.due_date
ORDER BY days_late DESC;

-- C8. Total fine for each member, showing only members with a fine.
SELECT m.member_id, m.member_name,
       SUM(DATEDIFF(i.return_date, i.due_date) * 2) AS total_fine_rupees
FROM members AS m
JOIN issues AS i ON i.member_id = m.member_id
WHERE i.return_date IS NOT NULL
  AND i.return_date > i.due_date
GROUP BY m.member_id, m.member_name
HAVING SUM(DATEDIFF(i.return_date, i.due_date) * 2) > 0
ORDER BY total_fine_rupees DESC;

-- C9. Compare borrowing activity by member type.
-- LEFT JOIN includes members who have not borrowed any books.
SELECT m.member_type, COUNT(i.issue_id) AS total_books_borrowed
FROM members AS m
LEFT JOIN issues AS i ON i.member_id = m.member_id
GROUP BY m.member_type
ORDER BY m.member_type;

-- C10. Rank members by number of books borrowed (MySQL 8.0+).
WITH member_borrow_counts AS (
    SELECT m.member_id, m.member_name, m.member_type,
           COUNT(i.issue_id) AS books_borrowed
    FROM members AS m
    LEFT JOIN issues AS i ON i.member_id = m.member_id
    GROUP BY m.member_id, m.member_name, m.member_type
)
SELECT member_id, member_name, member_type, books_borrowed,
       RANK() OVER (ORDER BY books_borrowed DESC) AS borrowing_rank
FROM member_borrow_counts
ORDER BY borrowing_rank, member_name;

-- C11. Number of issue records per book category.
SELECT b.category, COUNT(i.issue_id) AS total_issues
FROM books AS b
JOIN issues AS i ON i.book_id = b.book_id
GROUP BY b.category
ORDER BY total_issues DESC, b.category;

-- C12. Books with zero available copies and at least one pending issue.
SELECT b.book_id, b.title, b.copies_available
FROM books AS b
WHERE b.copies_available = 0
  AND EXISTS (
      SELECT 1
      FROM issues AS i
      WHERE i.book_id = b.book_id
        AND i.return_date IS NULL
  )
ORDER BY b.title;

-- C13. Stored procedure: show the borrowing history for one member.
DROP PROCEDURE IF EXISTS member_history;
DELIMITER //
CREATE PROCEDURE member_history(IN p_member_id INT)
BEGIN
    SELECT m.member_id, m.member_name, b.title, b.author,
           i.issue_date, i.due_date, i.return_date
    FROM members AS m
    JOIN issues AS i ON i.member_id = m.member_id
    JOIN books AS b ON b.book_id = i.book_id
    WHERE m.member_id = p_member_id
    ORDER BY i.issue_date DESC;
END //
DELIMITER ;

-- Test C13 with a real member_id from the members table.
-- Example: CALL member_history(1);
SELECT member_id, member_name FROM members ORDER BY member_id LIMIT 5;

-- C14. Trigger demonstration on copies of the tables, not the originals.
-- Recreate the test copies each time this section is run.
DROP TRIGGER IF EXISTS trg_reduce_copies_after_issue;
DROP TABLE IF EXISTS issues_trigger_test;
DROP TABLE IF EXISTS books_trigger_test;

CREATE TABLE books_trigger_test AS
SELECT * FROM books;

CREATE TABLE issues_trigger_test AS
SELECT * FROM issues
WHERE 1 = 0;

DELIMITER //
CREATE TRIGGER trg_reduce_copies_after_issue
AFTER INSERT ON issues_trigger_test
FOR EACH ROW
BEGIN
    UPDATE books_trigger_test
    SET copies_available = copies_available - 1
    WHERE book_id = NEW.book_id
      AND copies_available > 0;
END //
DELIMITER ;

-- Record a before value, then insert one test issue using an existing
-- member and a book that has at least one available copy.
SELECT book_id, title, copies_available
FROM books_trigger_test
WHERE copies_available > 0
ORDER BY book_id
LIMIT 5;

INSERT INTO issues_trigger_test
    (issue_id, member_id, book_id, issue_date, due_date, return_date)
SELECT
    COALESCE((SELECT MAX(issue_id) FROM issues_trigger_test), 0) + 1,
    m.member_id,
    b.book_id,
    CURDATE(),
    DATE_ADD(CURDATE(), INTERVAL 14 DAY),
    NULL
FROM members AS m
CROSS JOIN books_trigger_test AS b
WHERE b.copies_available > 0
ORDER BY m.member_id, b.book_id
LIMIT 1;

-- If an eligible member/book pair existed, the trigger reduces the
-- corresponding test-copy book count by one.
SELECT book_id, title, copies_available
FROM books_trigger_test
ORDER BY book_id;

-- C15 is a written conclusion: add evidence-based recommendations to README
-- and the assignment answer sheet after running and reviewing C4, C6, C7,
-- C8, and C12. Do not invent findings or result counts.
