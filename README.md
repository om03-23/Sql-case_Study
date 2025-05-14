# 🚗 Hotwheels SQL Database Project

Welcome to the **Hotwheels SQL Project** — a fun and educational database system inspired by the famous Hotwheels toy cars!  
This project demonstrates how to model and query data using **SQL**, complete with relationships, subqueries, views, and joins.

---

## 📘 Project Overview

This database contains:
- 🏁 **Car Series** — Different themed collections of Hotwheels
- 🚙 **Cars** — Each car model linked to a series
- 🏭 **Manufacturers** — Companies that produce the cars
- 🔄 **Car_Manufacturers** — Many-to-many relationship between cars and manufacturers

---

## 🧱 Database Schema

The schema includes the following tables:

| Table Name         | Description                                   |
|--------------------|-----------------------------------------------|
| `Series`           | Series info (name, release year)              |
| `Cars`             | Car details (name, model, year, series)       |
| `Manufacturers`    | Manufacturer names and countries              |
| `Car_Manufacturers`| Mapping between cars and manufacturers        |

---

## ✨ Key Features

- ✅ **Relational Schema** with primary and foreign keys
- ✅ **Many-to-Many Relationship** (Cars ↔ Manufacturers)
- ✅ **Data Insertion** with realistic examples
- ✅ **Subqueries & Joins** to extract insights
- ✅ **Views** for simplified querying
- ✅ Built for **MySQL / SQL-compatible environments**

---

## 🔍 Sample SQL Queries

### 🔸 Cars released after 2010 with their series:
```sql
SELECT Name, Model, Year, 
       (SELECT Name FROM Series WHERE Series.SeriesID = Cars.SeriesID) AS SeriesName
FROM Cars
WHERE Year > 2010;
