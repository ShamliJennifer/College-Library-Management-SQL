# College Library Management System (SQL)

A MySQL project based on the College Library Management assignment. It explores library members, books, borrowing activity, late returns, fines, ranking, stored procedures, and triggers.

## Repository contents

- `library_management/library_project.sql` — SQL solutions for C2-C14.
- `library_management/ERD.md` — entity relationships and cardinalities for C1.
- `library_management/README.md` — project instructions and C15 conclusion template.

## Database

The assignment specifies the database `librarydb` and these tables:

- **members**: `member_id` (primary key), `member_name`, `member_type`, `joined_date`
- **books**: `book_id` (primary key), `title`, `author`, `category`, `price`, `copies_available`
- **issues**: `issue_id` (primary key), `member_id` (foreign key), `book_id` (foreign key), `issue_date`, `due_date`, `return_date`

Relationships:
- One member can have many issue records (members 1-to-many issues).
- One book can appear in many issue records (books 1-to-many issues).
- A `NULL` `return_date` means the book has not yet been returned.

## How to run

1. Open MySQL Workbench and connect to the MySQL server used for the assignment.
2. Run the lecturer-provided `library_setup.sql` first. This creates and populates `librarydb`.
3. Open `library_management/library_project.sql` and run it in sections, from top to bottom.
4. Confirm the results against your own database. The stored procedure test uses a real `member_id` selected from the members table.
5. The C14 trigger works only with `books_trigger_test` and `issues_trigger_test`, which are copies for testing. It does not change the original `books` or `issues` tables.

**Important:** The lecturer's original setup file and dataset are not included in this repository yet. Add that file only if your lecturer permits redistribution. Do not replace the lecturer's data with invented sample records.

## Questions covered

- C1: ERD (see `ERD.md`)
- C2-C12: SQL queries for counts, categories, borrowing, members with no borrowing history, current issues, late returns, fines, member-type comparison, ranking, popular categories, and pending issues.
- C13: `member_history` stored procedure.
- C14: Trigger tested on separate copies of the tables.
- C15: Written recommendations based on actual query results (complete the template below after running the project).

## C15 — Recommendations (complete after running the queries)

Use the actual results from C4, C6, C7, C8, and C12:

1. **Books to purchase more copies of:** Identify frequently borrowed titles from C4 and books with no available copies plus pending issues from C12. Explain which titles need additional copies using those results.
2. **Members to remind:** Review C6 for books that are currently issued and their due dates. Identify overdue items by comparing the due date with today's date before making a reminder recommendation.
3. **Reducing late returns:** Use C7 and C8 to identify late-return patterns and members with fines. Recommend practical reminders before due dates and clear communication of the return policy.

Replace this guidance with a short conclusion based on the results you actually obtained. Do not report results until you have run the queries.

## Notes

- Fine rate specified in the assignment: ₹2 per day late.
- C7 calculates fines only for books that have been returned late.
- C6 includes all not-yet-returned books; check due dates to identify which are overdue.
- C10 uses window functions and requires MySQL 8.0 or later.
- Run the procedure and trigger sections in MySQL Workbench and record the actual test outputs for your viva.
