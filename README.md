#### ✅ What is PostgreSQL?

PostgreSQL is a powerful open-source relational database system. It uses SQL to manage data, and I like it because it's reliable, supports data integrity, and can handle complex queries very efficiently.

#### ✅ What is the purpose of a database schema in PostgreSQL?

I understand a schema as a logical structure within a database. It can contain tables, views, and functions. Using schemas helps keep different parts of a project organized, especially when there are multiple users or modules.

```
CREATE SCHEMA library;

CREATE TABLE library.books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(60),
    published_year INT,
    genre VARCHAR(30)
);
```

#### ✅ Explain the Primary Key and Foreign Key concepts in PostgreSQL.

##### Primary Key:

A Primary Key is a column (or a set of columns) that uniquely identifies each row in a table.

- Cannot have NULL values.
- Must be unique for each row.
- Each table should ideally have one primary key.

```
CREATE TABLE students (
  student_id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  class INT
);
```

Here, student_id is the primary key — each student gets a unique ID.

##### Foreign Key:

A Foreign Key is a column (or a set of columns) in one table that refers to the Primary Key of another table.

```
CREATE TABLE enrollments (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT REFERENCES students(student_id),
  course_name VARCHAR(100),
  enrollment_date DATE
);
```

- student_id in enrollments is a foreign key.
- It refers to student_id in the students table.

This means: a student must exist in the students table before you can enroll them in the enrollments table.

#### ✅ What is the difference between VARCHAR and CHAR data types?

I’ve learned that VARCHAR is a variable-length string, which means it only uses as much space as needed. CHAR, however, is fixed-length. So if define CHAR(10) and store 'abc', it will still take up 10 characters by adding spaces. That’s why I prefer using VARCHAR — it’s more flexible.

```
CREATE TABLE example_table (
  name_char CHAR(10),
  name_varchar VARCHAR(10)
);

INSERT INTO example_table (name_char, name_varchar)
VALUES ('Imam', 'Imam');
```

name_char will store 'Imam      ' (with 6 trailing spaces). name_varchar will store 'Imam'.

#### ✅ Explain the GROUP BY clause and its role in aggregation:

GROUP BY is used to group rows that have the same values in certain columns. It’s useful when used with aggregate functions. For example, I can group by course_id and use COUNT() to find out how many students are enrolled in each course.

```
SELECT course_id, COUNT(*) AS total_students
  FROM enrollments
  GROUP BY course_id;
```

This query groups the rows by course_id, then counts how many students are in each course.
