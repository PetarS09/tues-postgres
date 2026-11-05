-- ============================================
-- 1. CREATE SUBJECTS TABLE
-- Creates a table to store all school subjects.
-- ============================================

CREATE TABLE public.subjects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- Displays all subjects from the table.
SELECT * FROM public.subjects;


-- ============================================
-- 2. CREATE GRADES TABLE
-- Stores grades and connects them to students and subjects.
-- ============================================

CREATE TABLE public.grades (
    id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES public.students(id),
    subject_id INTEGER NOT NULL REFERENCES public.subjects(id),
    grade INTEGER NOT NULL CHECK (grade BETWEEN 2 AND 6),
    grade_date DATE NOT NULL
);


-- ============================================
-- 3. INSERT SUBJECTS
-- Adds four subjects to the subjects table.
-- ============================================

INSERT INTO public.subjects (name) VALUES
('Mathematics'),
('Bulgarian Language'),
('English'),
('Informatics');

-- Displays all subjects.
SELECT * FROM public.subjects;

-- Displays all students.
SELECT * FROM public.students;


-- ============================================
-- 4. INSERT GRADES
-- Adds 21 grades for the five students.
-- Each row contains student ID, subject ID,
-- grade and date.
-- ============================================

INSERT INTO public.grades (student_id, subject_id, grade, grade_date) VALUES
(1, 1, 5, '2026-10-01'),
(1, 1, 6, '2026-10-08'),
(1, 1, 4, '2026-10-15'),
(1, 2, 5, '2026-10-03'),
(1, 3, 4, '2026-10-10'),

(2, 1, 4, '2026-10-02'),
(2, 2, 6, '2026-10-05'),
(2, 3, 5, '2026-10-12'),
(2, 4, 6, '2026-10-18'),

(3, 1, 3, '2026-10-04'),
(3, 2, 4, '2026-10-09'),
(3, 3, 6, '2026-10-14'),
(3, 4, 5, '2026-10-20'),

(4, 1, 6, '2026-10-06'),
(4, 2, 5, '2026-10-11'),
(4, 3, 3, '2026-10-16'),
(4, 4, 4, '2026-10-22'),

(5, 1, 5, '2026-10-07'),
(5, 2, 3, '2026-10-13'),
(5, 3, 4, '2026-10-17'),
(5, 4, 6, '2026-10-24');


-- ============================================
-- 5. QUERY 1
-- Displays Ivan Petrov's grades in Mathematics,
-- sorted by date.
-- ============================================

SELECT
    s.name AS student,
    sub.name AS subject,
    g.grade,
    g.grade_date
FROM public.grades g
JOIN public.students s
    ON s.id = g.student_id
JOIN public.subjects sub
    ON sub.id = g.subject_id
WHERE g.student_id = 1
  AND g.subject_id = 1
ORDER BY g.grade_date;


-- ============================================
-- 6. QUERY 2
-- Calculates the average grade for each subject
-- and counts the number of grades.
-- The average is rounded to two decimal places.
-- ============================================

SELECT
    sub.name AS subject,
    ROUND(AVG(g.grade)::numeric, 2) AS average_grade,
    COUNT(g.id) AS number_of_grades
FROM public.subjects sub
JOIN public.grades g
    ON g.subject_id = sub.id
GROUP BY sub.id, sub.name
ORDER BY sub.name;


-- ============================================
-- 7. TEST CHECK CONSTRAINT
-- Tries to insert grade 7.
-- This should fail because grades must be between 2 and 6.
-- ============================================

INSERT INTO public.grades
(student_id, subject_id, grade, grade_date)
VALUES
(1, 1, 7, '2026-10-25');


-- ============================================
-- 8. TEST FOREIGN KEY CONSTRAINT
-- Tries to insert a grade for student ID 999.
-- This should fail because student 999 does not exist.
-- ============================================

INSERT INTO public.grades
(student_id, subject_id, grade, grade_date)
VALUES
(999, 1, 5, '2026-10-25');
