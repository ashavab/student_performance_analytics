import psycopg2
import pandas as pd
import matplotlib.pyplot as plt

# -------------------------------
# Database connection
# -------------------------------
conn = psycopg2.connect(
    dbname="school_analytics",
    user="ashleighboudier",
    password="", 
    host="localhost"
)

# -------------------------------
# Attendance Analysis
# -------------------------------
attendance_query = """
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    s.year_group,
    COUNT(*) FILTER (WHERE fa.attendance_status = 'Present')::decimal / COUNT(*) * 100 AS attendance_percentage
FROM fact_attendance fa
JOIN dim_student s ON fa.student_id = s.student_id
GROUP BY s.student_id, s.first_name, s.last_name, s.year_group
ORDER BY attendance_percentage DESC;
"""

attendance_df = pd.read_sql(attendance_query, conn)
print("\n=== Attendance Percentage ===")
print(attendance_df)

# Plot attendance %
plt.figure(figsize=(10,6))
plt.bar(attendance_df['student_name'], attendance_df['attendance_percentage'])
plt.xticks(rotation=90)
plt.ylabel('Attendance %')
plt.title('Student Attendance Percentage')
plt.tight_layout()
plt.show()

# -------------------------------
# Average Grades Analysis
# -------------------------------
grades_query = """
SELECT 
    s.student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    fg.term,
    AVG(fg.grade) AS avg_grade
FROM fact_grades fg
JOIN dim_student s ON fg.student_id = s.student_id
GROUP BY s.student_id, s.first_name, s.last_name, fg.term
ORDER BY fg.term, avg_grade DESC;
"""

grades_df = pd.read_sql(grades_query, conn)
print("\n=== Average Grades per Term ===")
print(grades_df)

# Plot average grades per term
for term in grades_df['term'].unique():
    term_df = grades_df[grades_df['term'] == term]
    plt.figure(figsize=(10,6))
    plt.bar(term_df['student_name'], term_df['avg_grade'])
    plt.xticks(rotation=90)
    plt.ylabel('Average Grade')
    plt.title(f'Average Grades - Term {term}')
    plt.tight_layout()
    plt.show()

# Close connection
conn.close()

