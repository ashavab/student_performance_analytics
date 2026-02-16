# Student Performance Analytics System

## Description
Track student attendance and grades in a school environment.
Analyze performance by term, subject, and student.

## Tech Stack
- PostgreSQL
- Python (pandas, matplotlib, psycopg2)
- Jupyter Notebook

## Setup
1. Install PostgreSQL
2. Create database: `CREATE DATABASE school_analytics;`
3. Run SQL: `psql -d school_analytics -f database/init_db.sql`

## Optional Python Analysis
1. Install dependencies: `pip install -r requirements.txt`
2. Run notebook: `jupyter notebook notebooks/student_analytics.ipynb`

## Analytics Ideas
- Attendance percentage per student
- Average grades per term or subject
- Top-performing students

