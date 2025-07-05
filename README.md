# 📊 KMS Sales Intelligence (2009–2012)

## ✨ Project Overview

This project was completed as part of the **Digital SkillUp Africa (DSA)** Data Analytics training. The analysis focuses on historical sales data from **Kultra Mega Stores (KMS)** — a retail and corporate office supply chain based in Lagos, Nigeria — with operations across various regions from **2009 to 2012**.

KMS management tasked us with deriving **actionable insights** to improve business performance using **structured data analysis** and **SQL queries**. The goal was to understand:

- How different regions, customer segments, and products performed
- Where the company is losing money through shipping or underperforming customers
- What decisions can improve profitability and customer retention

As the **Data Analyst**, I led the end-to-end process:
- Data ingestion using SQL Server Management Studio
- Data cleaning, transformation, and type optimization
- Formulation of real business questions
- Writing SQL queries to extract insights
- Summarizing recommendations to support strategic decision-making

🛠 **Tools Used:**
- SQL Server Management Studio (SSMS)
- Flat File Import Wizard
- Microsoft Excel (for initial data prep)
- GitHub (for version control and documentation)

📈 **Business Outcomes:**
- Identified top- and bottom-performing customer segments and products
- Diagnosed costly shipping patterns and misaligned logistics
- Proposed recommendations for marketing, logistics, and operations teams

---
## 📥 Data Importation Process

- **Source:** CSV file containing order data from 2009–2012.
- **Tool:** SQL Server Management Studio (SSMS) Flat File Import Wizard.
- **Steps:**
  1. Imported the dataset using the SSMS Flat File Import Wizard.
  2. Changed column data types to optimize performance and ensure data consistency:
     - `Sales`, `Profit`, `Discount`, `Shipping_Cost` → `DECIMAL(10,2)`
     - `Quantity`, `Order_ID`, `Product Count` → `INT`
  3. Cleaned column names and removed blank rows.
  4. Verified the import success through sampling and quick queries.

📸 *Screenshots of the import process and outputs are available in the `/images` folder.*

---

## 🔍 Business Questions & SQL Solutions

### 1️⃣ Which product category had the highest number of entries?

```sql
SELECT Product_Category, SUM(Sales) as Total_Sales
FROM KMS_Sql_Case_Study
GROUP BY Product_Category
ORDER BY Total_Sales DESC;
```

SELECT Region, SUM(Sales) as Top_sales
FROM KMS_Sql_Case_Study
GROUP BY Region
ORDER BY Top_sales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;


--For Bottom 3 Regions. ANS => NUNAVUT, NORTHWEST TERRITORIES, YUKON
SELECT REGION, SUM(Sales) as Bottom_sales
FROM KMS_Sql_Case_Study
GROUP BY Region
ORDER BY Bottom_sales 
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;
