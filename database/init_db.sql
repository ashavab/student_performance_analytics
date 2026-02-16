-- ================================
-- 1. Dimensional Tables Cleanup
-- ================================
TRUNCATE TABLE fact_attendance, fact_grades, dim_date, dim_student, dim_teacher, dim_subject RESTART IDENTITY CASCADE;

-- ================================
-- 2. Students (dim_student)
-- ================================
INSERT INTO dim_student (first_name, last_name, gender, year_group, enrollment_date, nationality, SEN_flag, EAL_flag) VALUES
('Napat','Srisuk','M','1','2016-05-12','Thai',FALSE,TRUE),
('Kanya','Chaiyawan','F','1','2016-07-20','Thai',FALSE,TRUE),
('Anucha','Rattanaporn','M','1','2016-08-15','Thai',FALSE,TRUE),
('Phichaya','Somsri','F','1','2016-09-02','Thai',FALSE,TRUE),
('Thanawat','Prasert','M','1','2016-11-10','Thai',FALSE,TRUE),
('Sirin','Jantawong','F','1','2016-12-01','Thai',FALSE,TRUE),
('Chaiwat','Kittipong','M','1','2017-01-05','Thai',FALSE,TRUE),
('Pimchanok','Chareon','F','1','2017-02-18','Thai',FALSE,TRUE),
('Natthaphon','Sukhum','M','1','2017-03-20','Thai',FALSE,TRUE),
('Chutima','Thongchai','F','1','2017-04-12','Thai',FALSE,TRUE),
('Supachai','Niran','M','2','2017-05-09','Thai',FALSE,TRUE),
('Pornsawan','Uthai','F','2','2017-06-11','Thai',FALSE,TRUE),
('Worawit','Kongka','M','2','2017-07-22','Thai',FALSE,TRUE),
('Chanikan','Boonmee','F','2','2017-08-14','Thai',FALSE,TRUE),
('Tawatchai','Rung','M','2','2017-09-30','Thai',FALSE,TRUE),
('Sasima','Inthanon','F','2','2017-10-18','Thai',FALSE,TRUE),
('Kritsada','Phromma','M','2','2017-11-05','Thai',FALSE,TRUE),
('Natthamon','Rojanakul','F','2','2017-11-25','Thai',FALSE,TRUE),
('Chinnapat','Suwannarat','M','2','2017-12-12','Thai',FALSE,TRUE),
('Pimlada','Sricharoen','F','2','2017-12-28','Thai',FALSE,TRUE);

-- ================================
-- 3. Teachers (dim_teacher)
-- ================================
INSERT INTO dim_teacher (first_name, last_name, hire_date) VALUES
('Ashleigh','Boudier','2023-06-01'),
('James','van der Merwe','2015-01-15'),
('Samantha','Botha','2016-03-22'),
('Michael','Pretorius','2017-09-10');

-- ================================
-- 4. Subjects (dim_subject)
-- ================================
INSERT INTO dim_subject (subject_name) VALUES
('Math'),
('English'),
('Science'),
('Thai');

-- ================================
-- 5. Dates (dim_date) - Term 1 & Term 2
-- ================================
-- Term 1: 2024-09-01 → 2024-12-20
INSERT INTO dim_date (full_date, day, month, month_name, term, academic_year, week_number, is_weekend)
SELECT date_trunc('day', d)::date,
       EXTRACT(DAY FROM d),
       EXTRACT(MONTH FROM d),
       TO_CHAR(d,'Month'),
       1,
       '2024-2025',
       EXTRACT(WEEK FROM d),
       CASE WHEN EXTRACT(DOW FROM d) IN (0,6) THEN TRUE ELSE FALSE END
FROM generate_series('2024-09-01'::date, '2024-12-20'::date, interval '1 day') AS d
WHERE EXTRACT(DOW FROM d) NOT IN (0,6);

-- Term 2: 2025-01-06 → 2025-04-10
INSERT INTO dim_date (full_date, day, month, month_name, term, academic_year, week_number, is_weekend)
SELECT date_trunc('day', d)::date,
       EXTRACT(DAY FROM d),
       EXTRACT(MONTH FROM d),
       TO_CHAR(d,'Month'),
       2,
       '2024-2025',
       EXTRACT(WEEK FROM d),
       CASE WHEN EXTRACT(DOW FROM d) IN (0,6) THEN TRUE ELSE FALSE END
FROM generate_series('2025-01-06'::date, '2025-04-10'::date, interval '1 day') AS d
WHERE EXTRACT(DOW FROM d) NOT IN (0,6);

-- ================================
-- 6. Fact Attendance
-- ================================
INSERT INTO fact_attendance (student_id, date_id, attendance_status, minutes_late)
SELECT s.student_id,
       d.date_id,
       CASE
           WHEN random() < 0.05 THEN 'Absent'
           WHEN random() < 0.15 THEN 'Late'
           ELSE 'Present'
       END AS attendance_status,
       CASE
           WHEN random() < 0.15 THEN (random()*15)::int
           ELSE 0
       END AS minutes_late
FROM dim_student s
CROSS JOIN dim_date d;

-- ================================
-- 7. Fact Grades
-- ================================
INSERT INTO fact_grades (student_id, subject_id, date_id, grade)
SELECT s.student_id,
       sub.subject_id,
       d.date_id,
       (50 + random()*50)::int AS grade   -- grades 50-100
FROM dim_student s
CROSS JOIN dim_subject sub
CROSS JOIN dim_date d;


