--Creating a new database for my project
CREATE Database DSA_PROJECT;

--Exploring my imported dataset
SELECT * from KMS_Sql_Case_Study;

--1. Which product category had the highest sales? ANS => TECHNOLOGY

SELECT Product_Category, SUM(Sales) as Total_Sales
FROM KMS_Sql_Case_Study
GROUP BY Product_Category
ORDER BY Total_Sales DESC;

--2. What are the Top 3 and Bottom 3 regions in terms of sales? 

--For Top 3 Regions. ANS => WEST, ONTARIO, PRARIE
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


--3. What were the total sales of appliances in Ontario? ANS => 3,063,212.60
SELECT Region, SUM(Sales) as Ontario_total_sales
FROM KMS_Sql_Case_Study
WHERE Region = 'Ontario'
GROUP BY Region;


--4. Advise the management of KMS on what to do to increase the revenue from the bottom 10 customers
SELECT Customer_Name, SUM(Sales) as Customer_bottom_sales
FROM KMS_Sql_Case_Study
GROUP BY Customer_Name
ORDER BY Customer_bottom_sales ASC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

--KMS management should offer first-time bundle deals or limited-time discounts to encourage higher spend.


--5. KMS incurred the most shipping cost using which shipping method? Ans. DELIVERY TRUCK
SELECT Ship_Mode, SUM(Shipping_Cost) as High_shipping_cost
FROM KMS_Sql_Case_Study
GROUP BY Ship_Mode
ORDER BY High_shipping_cost DESC;


--6. Who are the most valuable customers, and what products or services do they typically purchase? 

--To find top 3 customers. ANS => EMILY PHAN, DEBORAH BRUMFIELD, ROY SKARIA
SELECT Customer_Name, SUM(Sales) AS Total_Sales
FROM KMS_Sql_Case_Study
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

--To find the products or services they typically purchase

SELECT Customer_Name, Product_Category, Product_Sub_Category,  SUM(Sales) AS Customer_Total_Spent
FROM KMS_Sql_Case_Study
WHERE 
    Customer_Name IN (
        SELECT TOP 3 Customer_Name
        FROM KMS_Sql_Case_Study
        GROUP BY Customer_Name
        ORDER BY SUM(Sales) DESC
    )
GROUP BY 
    Customer_Name, Product_Category, Product_Sub_Category
ORDER BY 
    Customer_Name, Customer_Total_Spent DESC;


--7. Which small business customer had the highest sales? Ans => Dennis Kane 
SELECT Customer_Name, Customer_Segment, SUM(Sales) as Highest_Small_business
FROM KMS_Sql_Case_Study
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name, Customer_Segment
ORDER BY Highest_Small_business DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;


--8. Which Corporate Customer placed the most number of orders in 2009 – 2012? Ans => Adam Hart
SELECT Customer_Name, Customer_Segment, COUNT(Order_Quantity) as Highest_Orderby_corporate
FROM KMS_Sql_Case_Study
WHERE Customer_Segment = 'Corporate'
GROUP BY Customer_Name, Customer_Segment
ORDER BY Highest_Orderby_corporate DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

--9. Which consumer customer was the most profitable one? Ans => Emily Phan
SELECT Customer_Name, Customer_Segment, SUM(Profit) as Most_Profitable_custumer
FROM KMS_Sql_Case_Study
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name, Customer_Segment
ORDER BY Most_Profitable_custumer DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;

--10. Which customer returned items, and what segment do they belong to? 
SELECT k.Customer_Name, k.Customer_Segment, o.Status
From KMS_Sql_Case_Study k
JOIN Order_Status o on k.Order_ID = o.Order_ID
GROUP BY k.Customer_Name, k.Customer_Segment, o.Status;


/*11.  If the delivery truck is the most economical but the slowest shipping method and 
Express Air is the fastest but the most expensive one, do you think the company 
appropriately spent shipping costs based on the Order Priority? Explain your answer*/

SELECT 
    Order_Priority,
    Ship_Mode,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales * Profit),2) AS Total_Shipping_Cost,
    AVG(datediff(day,[order_date],[ship_date])) AS Avg_Shipping_day
FROM 
    KMS_Sql_Case_Study
GROUP BY 
    Order_Priority, Ship_Mode
ORDER BY 
    Order_Priority, Avg_Shipping_day DESC;


SELECT 
    Order_Priority,
    Ship_Mode,
    COUNT(distinct Order_ID) AS Total_Orders,
    ROUND(SUM(Sales * Profit),2) AS Estimated_Shipping_Cost,
    AVG(datediff(day,[order_date],[ship_date])) AS Avg_Shipping_day
FROM 
    KMS_Sql_Case_Study
GROUP BY 
    Order_Priority, Ship_Mode
ORDER BY 
    Order_Priority, Ship_Mode DESC;




SELECT * FROM KMS_Sql_Case_Study;
SELECT * FROM Order_Status;


SELECT DISTINCT Product_Category FROM KMS_Sql_Case_Study;
SELECT DISTINCT Ship_Mode FROM KMS_Sql_Case_Study;
