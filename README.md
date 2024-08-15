**Walmart Sales Data Analysis Project**
 **Project Overview**
This project involves analyzing Walmart sales data to extract valuable insights regarding product performance, sales trends, customer behavior, and other critical business metrics. The dataset used was obtained from the Kaggle Walmart Sales Forecasting Competition, and the analysis was conducted using SQL queries.

**Database and Table Setup**
- **Database:** WalmartData
- **Table:** sales
    - **Columns:**
      - `invoice_id`: Unique identifier for each transaction
      - `branch`: Store branch
      - `city`: City where the store is located
      - `customer_type`: Type of customer (e.g., Member, Non-member)
      - `gender`: Gender of the customer
      - `product_line`: Category of the product sold
      - `unit_price`: Price per unit of the product
      - `quantity`: Number of units sold
      - `total`: Total transaction amount
      - `date`: Date of the transaction
      - `time`: Time of the transaction
      - `payment_method`: Method of payment (e.g., Cash, Credit Card)
      - `cost_goods_sold`: Cost of Goods Sold (COGS)
      - `gross_margin_per`: Gross margin percentage
      - `gross_income`: Gross income from the transaction
      - `rating`: Customer rating of the product
      - `VAT`: Value Added Tax applied to the transaction
      - `time_of_day`: Derived column indicating the time of day (Morning, Afternoon, Evening)
      - `day_name`: Derived column indicating the day of the week
      - `month_name`: Derived column indicating the month

## SQL Queries and Analysis

### Product Analysis
- **Unique Product Lines:** `COUNT(DISTINCT product_line)`
- **Most Common Payment Method:** `GROUP BY payment_method ORDER BY count DESC`
- **Most Selling Product Line:** `GROUP BY product_line ORDER BY count DESC`
- **Total Revenue by Month:** `GROUP BY month_name ORDER BY total_revenue DESC`
- **Product Line with Largest Revenue:** `GROUP BY product_line ORDER BY total_revenue DESC`
- **Branch with Above-Average Sales:** `HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales)`
- **Most Common Product Line by Gender:** `GROUP BY gender, product_line ORDER BY total_cnt DESC`

### Sales Analysis
- **Sales by Time of Day and Weekday:** `GROUP BY time_of_day`
- **Customer Type Bringing Most Revenue:** `GROUP BY customer_type ORDER BY total_revenue DESC`
- **City with Largest VAT:** `GROUP BY city ORDER BY VAT DESC`
- **Gender Distribution per Branch:** `GROUP BY branch, gender ORDER BY branch`

## How to Run the Project
1. **Database Setup:** Ensure you have a MySQL or compatible database installed. Create the database and table using the provided SQL code.
2. **Data Import:** Import your dataset into the `sales` table.
3. **Run Queries:** Execute the SQL queries provided in the project to perform the analysis.
4. **Analyze Results:** Review the outputs from the queries to derive insights on product performance, sales trends, and customer behavior.

## Conclusion
This project provides a comprehensive analysis of Walmart's sales data, offering valuable insights into product performance, customer preferences, and sales trends. The SQL queries used in the analysis can be adapted for similar datasets to conduct various types of business analysis.
