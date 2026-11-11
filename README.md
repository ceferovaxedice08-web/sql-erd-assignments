# SQL & ERD Assignments

This repository contains my solutions for relational database design and SQL practice assignments.

## Contents

- **SQL queries**: table creation, sample data, 10 basic tasks, and 28 business scenario tasks (SalesDB)
- **ERD diagrams**: two entity relationship diagrams designed in QuickDBD

## Projects

### 1. SalesDB
A sales database with four tables: `Customers`, `Products`, `Employees`, and `Orders`.

- One customer can place many orders (1:N)
- One product can appear in many orders (1:N)
- One employee can process many orders (1:N)
- An employee can report to another employee (self-reference via `ManagerID`)

### 2. University Course Registration
A registration system with four tables: `Students`, `Instructors`, `Courses`, and `Enrollments`.

- One instructor teaches many courses (1:N)
- Students and courses have a many-to-many relationship, resolved by the `Enrollments` table
- A student cannot register twice for the same course, because the pair (`StudentID`, `CourseID`) is unique

## Folder structure

- `sql/` : SQL files
- `erd/` : ERD diagrams (PNG)

## Tools

- MySQL
- QuickDBD
- GitHub

## Author

Your Name
