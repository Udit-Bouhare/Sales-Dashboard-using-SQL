# ☕ Coffee Sales-Dashboard-using-SQL
## 📌 Project Overview  
This project analyzes coffee shop sales data to uncover **trends, top-selling products, and customer behavior patterns**.  
The workflow involves:  
1. **Data Cleaning** → Python (Pandas & NumPy)  
2. **Data Analysis** → MySQL (SQL queries for KPIs & insights)  
3. **Data Visualization** → Power BI Dashboard  

The goal is to provide **actionable insights** for better business decision-making.  

---

## 🛠️ Tools & Technologies  
- **Python** → Pandas, NumPy (data cleaning & preprocessing)  
- **SQL (MySQL)** → Writing queries for sales analysis  
- **Power BI** → Building interactive dashboard  
- **GitHub** → Version control & project showcase  

---

## 🔑 Key Steps  

### 1️⃣ Data Cleaning (Python)  
- Handled missing values & duplicates  
- Renamed columns for clarity  
- Added `Total_Price` column (`Quantity × Unit Price`)  
- Standardized text formatting  
- Exported final **clean dataset**  

📄 Notebook: [`data_cleaning.ipynb`](notebooks/data_cleaning.ipynb)  

---

### 2️⃣ Data Analysis (SQL)  
- **KPIs:** Total Sales, Orders, Quantity Sold  
- **Month-over-Month growth**  
- **Top 10 Products & Categories**  
- **Weekday vs Weekend Sales**  
- **Hourly Sales Trends**  

📄 SQL Script: [`sales_queries.sql`](scripts/sales_queries.sql)  

---

### 3️⃣ Dashboard (Power BI)  
Interactive dashboard showing:  
- 📊 Sales trends (daily, monthly, hourly)  
- 🏆 Best-selling products & categories  
- 📍 Store performance by location  
- 📈 Weekday vs weekend insights  

📄 Dashboard File: [`sales_dashboard.pbix`](dashboard/sales_dashboard.pbix)  

---

## 📈 Sample Insights  
- **May had the highest sales** with strong weekend contributions  
- **Coffee drinks** were the top-selling product category ☕  
- **Morning hours (8–10 AM)** showed peak sales activity  
- **Store location X** outperformed all others  

---

## 🚀 How to Use This Project  
2. Explore the cleaned dataset → [`data/cleaned/coffee_sales_cleaned.csv`](data/cleaned/coffee_sales_cleaned.csv)  
3. Run SQL queries → [`scripts/sales_queries.sql`](scripts/sales_queries.sql)  
4. Open the Power BI dashboard → [`dashboard/sales_dashboard.pbix`](dashboard/sales_dashboard.pbix)  

---

## 📜 License  
This project is licensed under the **MIT License** – free to use and modify.  

---

## 🙌 Acknowledgments  
- Dataset inspired by coffee shop sales transactions  
- Tools: **Python, MySQL, Power BI**  
