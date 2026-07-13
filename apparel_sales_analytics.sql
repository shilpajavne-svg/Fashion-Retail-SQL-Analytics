-- ====================================================================
-- PROJECT NAME: Fashion Retail Sales & Inventory SQL Analytics
-- DATASET: Apparel Sales logs (Levis, Puma, Zara, Allen Solly, etc.)
-- ====================================================================

-- 1. DATABASE & TABLE SETUP
-- Creates the base table structure to hold the transaction logs
CREATE TABLE fashion_sales (
    Invoice_No VARCHAR(20) PRIMARY KEY,
    Order_No VARCHAR(20),
    Order_Date DATE,
    Customer VARCHAR(50),
    Brand VARCHAR(50),
    Category VARCHAR(50),
    Color VARCHAR(30),
    Size VARCHAR(10),
    Quantity INT,
    Unit_Price DECIMAL(10, 2),
    Total_Amount DECIMAL(10, 2),
    Payment_Mode VARCHAR(30),
    Warehouse VARCHAR(10),
    Stock_Status VARCHAR(20)
);

-- ====================================================================
-- 2. CORE ANALYTICAL QUERIES (Ready for Insights)
-- ====================================================================

-- QUERY 1: High-Level Business Metrics
-- Calculates total revenue, total clothing items sold, and transaction count
SELECT 
    SUM(Total_Amount) AS Total_Revenue,
    SUM(Quantity) AS Total_Items_Sold,
    COUNT(Invoice_No) AS Total_Transactions
FROM fashion_sales;


-- QUERY 2: Brand Performance Leaderboard
-- Ranks brands by total revenue generated to see who dominates sales
SELECT 
    Brand,
    SUM(Quantity) AS Total_Quantity_Sold,
    SUM(Total_Amount) AS Total_Revenue
FROM fashion_sales
GROUP BY Brand
ORDER BY Total_Revenue DESC;


-- QUERY 3: Most Popular Clothing Categories & Sizes
-- Finds out which item type and size combination is bought the most
SELECT 
    Category,
    Size,
    SUM(Quantity) AS Units_Sold,
    SUM(Total_Amount) AS Revenue
FROM fashion_sales
GROUP BY Category, Size
ORDER BY Units_Sold DESC;


-- QUERY 4: Inventory Restocking Alert
-- Filters items that are 'Out of Stock' or 'Low Stock' sorted by warehouse
SELECT 
    Warehouse,
    Brand,
    Category,
    Stock_Status,
    COUNT(*) AS Alert_Count
FROM fashion_sales
WHERE Stock_Status IN ('Out of Stock', 'Low Stock')
GROUP BY Warehouse, Brand, Category, Stock_Status
ORDER BY Warehouse ASC, Alert_Count DESC;


-- QUERY 5: Preferred Payment Methods
-- Tracks consumer preference for checkout (Cash, Card, UPI, etc.)
SELECT 
    Payment_Mode,
    COUNT(*) AS Transaction_Count,
    SUM(Total_Amount) AS Total_Processed_Amount
FROM fashion_sales
GROUP BY Payment_Mode
ORDER BY Transaction_Count DESC;


-- QUERY 6: Top Spending Customers
-- Identifies premium buyers who spend the most cash/credit at the store
SELECT 
    Customer,
    COUNT(Order_No) AS Total_Orders,
    SUM(Total_Amount) AS Total_Spent
FROM fashion_sales
GROUP BY Customer
ORDER BY Total_Spent DESC
LIMIT 5;
