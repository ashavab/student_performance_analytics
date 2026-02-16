# Student Performance Analytics System

## Project Overview
This project matches my school's student performance using a **dimensional database** and performs **analytics on attendance and grades**. It’s a copy of the original designed as a showcase for **Data Analyst / Data Engineer** skills.

- PostgreSQL database with **dimensional modeling** (Fact and Dimension tables)
- Sample data for **20 students** in Years 1 and 2, **4 teachers**, and **4 subjects**
- Attendance and grades for **Term 1 and Term 2**
- Python/Jupyter notebook for **data analysis and visualizations**

---

## Tech Stack
- PostgreSQL (database modeling and analytics)
- Python (data extraction and visualization)
- Pandas & Matplotlib (analysis and plotting)
- Jupyter Notebook (interactive analytics)


## Description
Track student attendance and grades in a school environment.
Analyze performance by term, subject, and student.

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

