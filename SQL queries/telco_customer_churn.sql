CREATE DATABASE telco_customer_churn;

DROP TABLE IF EXISTS tcc;
 
CREATE TABLE tcc(
	Customer_ID VARCHAR(20),
	Gender VARCHAR(10),
	Senior_Citizen INT,
	Partner VARCHAR(5),
	Dependents VARCHAR(5),
	tenure INT,
	Phone_Service VARCHAR(5),
	MultipleLines VARCHAR(25),
	Internet_Service VARCHAR(30),
	Online_Security VARCHAR(30),
	Online_Backup VARCHAR(30),
	Device_Protection VARCHAR(30),
	Tech_Support VARCHAR(30),
	Streaming_TV VARCHAR(30),
	Streaming_Movies VARCHAR(30),
	Contract VARCHAR(30),
	Paperless_Billing VARCHAR(30),
	Payment_Method VARCHAR(30),
	Monthly_Charges NUMERIC(10,2),
	Total_Charges NUMERIC(10,2),
	Churn VARCHAR(5)
);

SELECT * FROM TCC;

COPY tcc(Customer_ID, Gender, Senior_Citizen, Partner, Dependents, tenure, Phone_Service, MultipleLines, Internet_Service, Online_Security, Online_Backup, Device_Protection, Tech_Support, Streaming_TV, Streaming_Movies, Contract, Paperless_Billing, Payment_Method, Monthly_Charges, Total_Charges, Churn)
FROM 'C:\MyFolder\CSV\Telco-Customer-Churn.csv'
CSV HEADER;

SELECT * FROM TCC;

-- Executive Overview
--1. Total Customers
SELECT count(*) AS Total_Customer 
FROM tcc;

--2. Active Customers 
SELECT COUNT(*) AS Active_Customers
FROM tcc
WHERE Churn='No';

--3. Churned Customers
SELECT COUNT(*) AS Churned_Customers
FROM tcc
WHERE Churn='Yes';

--4. Churn Rate
SELECT
ROUND(
COUNT(*) FILTER (WHERE Churn='Yes')*100.0/COUNT(*),
2
) AS churn_rate
From tcc;

--5. Total Revenue
SELECT
ROUND(SUM(total_charges),2) AS total_revenue
FROM tcc;

--6. Average Monthly Charges
SELECT
ROUND(AVG(monthly_charges),2)
AS avg_monthly_charges
FROM tcc;

--7. Average Tenure
SELECT
ROUND(AVG(tenure),2)
AS avg_tenure
FROM tcc;

--8. Customers by Gender
SELECT gender,
COUNT(*) AS total_customers
FROM tcc
GROUP BY gender;

--9. Customers by Contract
SELECT contract,
COUNT(*) AS total_customers
FROM tcc
GROUP BY contract;

--10. Customers by Internet Service
SELECT internet_service,
COUNT(*) AS customers
FROM tcc 
GROUP BY internet_service;

--11. Revenue by Contract
SELECT
contract,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY contract
ORDER BY revenue DESC;

--12. Customers by Payment Method
SELECT
payment_method,
COUNT(*) AS customers
FROM tcc 
GROUP BY payment_method
ORDER BY customers DESC;

-- Customer Churn Analysis
--1. Churn by Contract
SELECT contract,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY contract
ORDER BY churned_customers DESC;

--2.Churn by Internet Service
SELECT internet_service,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY internet_service
ORDER BY churned_customers DESC;

--3. Churn by Payment Method
SELECT Payment_Method,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY Payment_Method
ORDER BY churned_customers DESC;

--4. Churn by Gender
SELECT gender,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY gender
ORDER BY churned_customers DESC;

--5. Churn by Senior Citizen
SELECT
	 CASE
		WHEN senior_citizen=1 THEN 'Senior Citizen'
		ELSE 'Non Senior Citizen'
	 END AS customer_type,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn='Yes'
GROUP BY senior_citizen;

--6. Churn by Partner
SELECT Partner,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY Partner
ORDER BY churned_customers DESC;

--7. Churn by Dependents
SELECT Dependents,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY Dependents
ORDER BY churned_customers DESC;

--8. Churn by Paperless Billing
SELECT Paperless_Billing,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY Paperless_Billing
ORDER BY churned_customers DESC;

--9. Churn by Tech Support
SELECT Tech_Support,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY Tech_Support
ORDER BY churned_customers DESC;

--10. Churn by Online Security
SELECT online_security,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn='Yes'
GROUP BY online_security;

--11. Churn by Streaming TV
SELECT streaming_tv,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn='Yes'
GROUP BY streaming_tv;

--12. Churn by Streaming Movies
SELECT Streaming_Movies,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn = 'Yes'
GROUP BY Streaming_Movies
ORDER BY churned_customers DESC;

--13. Churn by Tenure Group
SELECT
	CASE
		WHEN tenure<=12 THEN '0-12 Months'
		WHEN tenure<=24 THEN '13-24 Months'
		WHEN tenure<=48 THEN '25-48 Months'
	ELSE '49-72 Months'
	END AS tenure_group,
COUNT(*) AS churned_customers
FROM tcc
WHERE churn='Yes'
GROUP BY tenure_group
ORDER BY tenure_group;

--Revenue & Customer Insights
--1. Average Revenue per Customer
SELECT
ROUND(AVG(total_charges),2)
AS avg_revenue_per_customer
FROM tcc;

--2. Highest Revenue Contract
SELECT contract,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY contract
ORDER BY revenue DESC
LIMIT 1;

--3. Highest Revenue Payment Method
SELECT payment_method,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY payment_method
ORDER BY revenue DESC
LIMIT 1;

--4. Revenue by Contract
SELECT contract,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY contract
ORDER BY revenue DESC;

--5. Revenue by Internet Service
SELECT Internet_Service,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY Internet_Service
ORDER BY revenue DESC;

--6. Revenue by Payment Method
SELECT Payment_Method,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY Payment_Method
ORDER BY revenue DESC;

--7. Average Monthly Charges by Contract
SELECT contract,
ROUND(AVG(monthly_charges),2) AS avg_monthly_charge
FROM tcc
GROUP BY contract;

--8. Average Tenure by Contract
SELECT contract,
ROUND(AVG(tenure),2) AS avg_tenure
FROM tcc
GROUP BY contract;

--9. Monthly Charges Distribution
SELECT
CASE
WHEN monthly_charges<30 THEN 'Low'
WHEN monthly_charges<70 THEN 'Medium'
ELSE 'High'
END AS charge_category,
COUNT(*) AS customers
FROM tcc
GROUP BY charge_category;

--10. Top 10 Highest Paying Customers
SELECT
customer_id,
gender,
contract,
monthly_charges,
total_charges
FROM tcc
ORDER BY total_charges DESC
LIMIT 10;

--11. Revenue by Gender
SELECT gender,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY gender;

--12. Revenue by Senior Citizen
SELECT
CASE
WHEN senior_citizen=1 THEN 'Senior Citizen'
ELSE 'Non Senior Citizen'
END AS customer_type,
ROUND(SUM(total_charges),2) AS revenue
FROM tcc
GROUP BY senior_citizen;