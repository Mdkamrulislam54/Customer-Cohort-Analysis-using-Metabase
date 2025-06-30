# Customer-Cohort-Analysis-using-Metabase

## 🎯 Project Purpose

The primary goal of this project is to demonstrate how **cohort analysis** can be used to evaluate customer retention behavior over time. By grouping customers based on their first purchase month and tracking their repeat activity, businesses can:

- Identify **retention trends** across cohorts
- Measure **customer loyalty** and **churn rate**
- Estimate **Customer Lifetime Value (CLTV)**
- Make data-driven decisions for **marketing** and **customer engagement strategies**

Check the **Output** Below:
![Alt text](https://github.com/Mdkamrulislam54/Customer-Cohort-Analysis-using-Metabase/blob/d23de3fb5f16cdd6eaca28a850d1af50d9c26e79/Customer%20Retention%20Analysiis.png)
![Alt text](https://github.com/Mdkamrulislam54/Customer-Cohort-Analysis-using-Metabase/blob/d23de3fb5f16cdd6eaca28a850d1af50d9c26e79/Customer%20Retention%20Rate%20%25.png)
![Alt text](https://github.com/Mdkamrulislam54/Customer-Cohort-Analysis-using-Metabase/blob/d23de3fb5f16cdd6eaca28a850d1af50d9c26e79/Customer%20Life%20time%20Value.png)

# Dataset Source 
[Dataset Link](https://github.com/Mdkamrulislam54/Customer-Cohort-Analysis-using-Metabase/blob/d23de3fb5f16cdd6eaca28a850d1af50d9c26e79/Super%20Store%20Sales.csv)
# Code
[Customer Retention Analysis](https://github.com/Mdkamrulislam54/Customer-Cohort-Analysis-using-Metabase/blob/911e3dff6459b6a5b81cd4f1ddf58a590b66e30e/Monthly%20Customer%20Cohort%20Analysis.sql)
[Customer Lifetime Value](https://github.com/Mdkamrulislam54/Customer-Cohort-Analysis-using-Metabase/blob/911e3dff6459b6a5b81cd4f1ddf58a590b66e30e/Monthly%20Customer%20Lifetime%20Value.sql)

## 📊 Project Highlights

- ✅ Identified **Customer First Purchase Dates**
- 🔁 Calculated **Customer Retention** per monthly cohort
- 📉 Analyzed **Retention Rates** across time
- 💸 Estimated **Customer Lifetime Value (CLTV)**
- 📈 Visualized results using **Metabase dashboards**

## 📌 Steps of Analysis

This project follows a structured cohort analysis process using SQL and Metabase. Below are the key steps:

### 1. 🧹 Data Preparation

- Imported the **Super Store dataset** (CSV) into a **MySQL** database.
- Converted `order_date` strings to `DATE` using `STR_TO_DATE(order_date, '%m/%d/%Y')`.
- Filtered out rows with **NULL customer_id** values.

---

### 2. 🗓️ Identify First Order Date

- Created a CTE (`first_orders`) to determine each customer’s **first purchase date**:
  ```sql
  SELECT customer_id, MIN(STR_TO_DATE(order_date, '%m/%d/%Y')) AS first_order_date
  FROM super_store
  GROUP BY customer_id
### 3. 🔁 Build the Cohort Table

- Joined each order with the customer's first purchase date.
- Calculated:
  - `cohort_month`: The month of the customer's first order (using `DATE_FORMAT`).
  - `cohort_index`: The number of months since the first order, for each transaction.

```sql
SELECT
  s.customer_id,
  DATE_FORMAT(f.first_order_date, '%Y-%m') AS cohort_month,
  STR_TO_DATE(s.order_date, '%m/%d/%Y') AS order_date,
  TIMESTAMPDIFF(MONTH, f.first_order_date, STR_TO_DATE(s.order_date, '%m/%d/%Y')) AS cohort_index
FROM super_store AS s
LEFT JOIN first_orders AS f
  ON s.customer_id = f.customer_id;

###  📊 Create the Retention Matrix
Grouped customers by cohort_month and counted how many were active in each following month (cohort_index = 0, 1, 2, etc.).

Used COUNT(DISTINCT CASE WHEN ...) to pivot the matrix horizontally.
SELECT 
  cohort_month,
  COUNT(DISTINCT CASE WHEN cohort_index = 0 THEN customer_id END) AS Month_0,
  COUNT(DISTINCT CASE WHEN cohort_index = 1 THEN customer_id END) AS Month_1,
  COUNT(DISTINCT CASE WHEN cohort_index = 2 THEN customer_id END) AS Month_2,
  COUNT(DISTINCT CASE WHEN cohort_index = 3 THEN customer_id END) AS Month_3,
  ...
FROM cohort_orders
GROUP BY cohort_month;


 ## 🛠️ Tools & Technologies

- **Database**: MySQL 8+
- **BI Tool**: Metabase
- **Language**: SQL
- **Dataset**: Super Store (CSV)





