-- =========================================================
-- COLLEGE LIBRARY MANAGEMENT SYSTEM
-- ER RELATIONSHIP DIAGRAM - DATABASE STRUCTURE
-- Course: BCA Data Science
-- Database: librarydb
-- Compatible with MySQL 8.0+
--
-- This file documents the three entities shown in the ER diagram:
-- MEMBERS, BOOKS, and ISSUES.
--
-- Relationships:
-- 1. One MEMBER can have many ISSUE records (1:N).
-- 2. One BOOK can appear in many ISSUE records (1:N).
-- 3. ISSUES connects MEMBERS and BOOKS through foreign keys.
-- =========================================================

USE librarydb;

-- MEMBERS entity
CREATE TABLE IF NOT EXISTS members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    member_type ENUM('Student', 'Faculty') NOT NULL,
    joined_date DATE
);

-- BOOKS entity
CREATE TABLE IF NOT EXISTS books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(100),
    price DECIMAL(10,2),
    copies_available INT DEFAULT 0
);

-- ISSUES entity: connects MEMBERS and BOOKS
CREATE TABLE IF NOT EXISTS issues (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    CONSTRAINT fk_issues_member
        FOREIGN KEY (member_id) REFERENCES members(member_id),
    CONSTRAINT fk_issues_book
        FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Relationship summary:
-- MEMBERS (1) -------- (N) ISSUES
-- BOOKS   (1) -------- (N) ISSUES
--
-- One member can have many issue records.
-- One book can appear in many issue records.
-- =========================================================
-- END OF ER RELATIONSHIP DIAGRAM SQL FILE
-- =========================================================
