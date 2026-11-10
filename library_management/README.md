# Library Management System

**Project Type:** DBMS Mini Project  
**Course:** Bachelor of Computer Applications (BCA)  
**Database:** MySQL  
**Database Name:** `librarydb`  
**Software:** MySQL Workbench

## 1. Introduction

The **Library Management System** is a mini project developed using MySQL. It is designed to maintain records of library members, available books, and book-borrowing activities.

The main objective of this project is to understand how databases work and how SQL queries can be used to retrieve and manage information.

Using this database, I can identify popular books, check books that have not been returned, calculate late-return fines, and analyse borrowing activities. This project also gives me practical experience with relational database concepts and SQL operations.

## 2. Database Tables

The database consists of three tables: `members`, `books`, and `issues`.

### Members

Stores information about students and faculty members.

| Column | Description |
|---|---|
| `member_id` | Primary key |
| `member_name` | Name of the member |
| `member_type` | Student or Faculty |
| `joined_date` | Date of joining |

### Books

Stores information about the books available in the library.

| Column | Description |
|---|---|
| `book_id` | Primary key |
| `title` | Book name |
| `author` | Author name |
| `category` | Book category |
| `price` | Price of the book |
| `copies_available` | Number of available copies |

### Issues

Stores information about books borrowed by members.

| Column | Description |
|---|---|
| `issue_id` | Primary key |
| `member_id` | Foreign key referencing `members` |
| `book_id` | Foreign key referencing `books` |
| `issue_date` | Date when the book was issued |
| `due_date` | Expected return date |
| `return_date` | Actual return date |

## 3. Database Relationships

The database contains two one-to-many relationships:

- One member can have multiple issue records.
- One book can have multiple issue records.
- The `issues` table connects members and books.
- The `issues` table contains foreign keys to maintain these relationships.

The Entity Relationship Diagram (ERD) reference is available in [ERD.md](ERD.md).

## 4. Sample Data

The sample dataset for this project contains the following records:

| Table | Total Records |
|---|---:|
| Members | 12 |
| Books | 15 |
| Issues | 32 |

The database includes both Student and Faculty members, along with books from different categories such as Programming, Database, Networking, Fiction, Science, and Mathematics.

## 5. Fine Calculation

The library follows a fine rule of **₹2 for every day a book is returned late**.

**Fine = Late Days × ₹2**

The borrowing periods are:

- **Student borrowing period:** 14 days.
- **Faculty borrowing period:** 30 days.
- Books returned after the due date are considered late.
- Books returned on the due date have no fine.
- Books with a `NULL` return date are considered currently issued.

The `DATEDIFF()` function is used to calculate the number of days between the due date and the actual return date.

## 6. SQL Concepts Used

The following SQL concepts are used in this project:

- Database and table creation
- Primary keys and foreign keys
- `SELECT` and `WHERE` statements
- Aggregate functions such as `COUNT()` and `SUM()`
- `GROUP BY` and `HAVING`
- `ORDER BY` and `LIMIT`
- `INNER JOIN` and `LEFT JOIN`
- Subqueries
- NULL value handling
- `DATEDIFF()` function
- Window functions using `RANK()`
- Stored procedures
- Triggers

## 7. Project Questions

The project consists of 15 questions divided into four phases.

### Phase 1 — Database Basics

- **C1:** Draw the Entity Relationship Diagram.
- **C2:** Find the total number of members, books, and issue records.

### Phase 2 — SQL Queries

- **C3:** Find the number of titles and available copies in each category.
- **C4:** Find the top 5 most borrowed books.
- **C5:** Identify members who have never borrowed a book.
- **C6:** Display currently issued books with member names and due dates.
- **C7:** Find late returns and calculate their fines.
- **C8:** Calculate the total fine for each member.
- **C9:** Compare borrowing activities between students and faculty.
- **C10:** Rank members according to the number of books borrowed.
- **C11:** Identify the most popular book category.
- **C12:** Find books with zero available copies and pending issues.

### Phase 3 — Database Automation

- **C13:** Create a stored procedure to display a member's borrowing history.
- **C14:** Create a trigger to automatically reduce available copies when a new issue is inserted.

### Phase 4 — Conclusion

- **C15:** Suggest improvements to library management based on the query results.

## 8. Files Included

The repository contains the following project files:

| File | Description |
|---|---|
| `library_project.sql` | Contains the SQL queries and database automation tasks for C2 to C14. |
| `ERD.md` | Contains the Entity Relationship Diagram reference and relationship details for C1. |
| `README.md` | Contains the project introduction, database details, concepts, questions, and instructions. |

**Database setup:** Run the `library_setup.sql` file provided by the lecturer before executing the project queries. The lecturer's setup file is not included in this repository.

## 9. How to Run the Project

1. Open **MySQL Workbench**.
2. Connect to the MySQL server used for the assignment.
3. Execute the lecturer-provided `library_setup.sql` file to create and populate the `librarydb` database.
4. Select the `librarydb` database.
5. Open `library_project.sql` from this repository.
6. Execute the SQL statements in sections, following the question numbers.
7. Check the output of each query and compare it with the expected task.
8. For C13, call the stored procedure using a valid `member_id` from the `members` table.
9. For C14, run the trigger demonstration on the separate test tables created by the script.

To verify the number of records in each table, run:

```sql
USE librarydb;

SELECT COUNT(*) AS total_members FROM members;
SELECT COUNT(*) AS total_books FROM books;
SELECT COUNT(*) AS total_issues FROM issues;
```

The sample dataset summary recorded for this project is 12 members, 15 books, and 32 issue records. The counts returned in MySQL Workbench should be checked against the database loaded on your system.

**Note:** The C14 trigger demonstration uses separate test copies of the `books` and `issues` tables so that the original assignment tables are not changed.

## 10. Learning Outcomes

Through this project, I learned how to create and work with relational databases using MySQL.

I gained practical knowledge of SQL queries, joins, aggregate functions, subqueries, and window functions. I also learned how stored procedures and triggers can be used to automate database operations.

Working on this project helped me understand how database concepts can be applied to a real-world library management system and improved my confidence in writing and understanding SQL queries.

## 11. Conclusion

The Library Management System demonstrates how MySQL can be used to maintain and analyse library records. The queries help identify popular books, members with pending returns, and late-return fines.

Based on the query results, the library can plan purchases of additional book copies, remind members about books that are due, and take steps to reduce late returns.

Overall, this mini project helped me improve my practical understanding of database management and SQL.
