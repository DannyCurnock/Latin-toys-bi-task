USE OperationsDb
GO


SELECT 
  SUM(CAST(price_usd AS DECIMAL(10,2))) * 1.0 / COUNT(order_id) AS RevenuePerOrder
FROM orders;


SELECT 
  SUM(CAST(price_usd AS DECIMAL(10,2))) * 1.0 / COUNT(DISTINCT website_session_id) AS RevenuePerSession
FROM orders;


SELECT 
  SUM(CAST(price_usd AS DECIMAL(10,2))) - SUM(CAST(cogs_usd AS DECIMAL(10,2))) AS GrossProfit
FROM order_items;


SELECT 
  SUM(items_purchased) AS TotalUnitsSold
FROM orders;


SELECT
  YEAR(created_at) AS Year,
  MONTH(created_at) AS Month,
  SUM(CAST(price_usd AS DECIMAL(10,2))) * 1.0 / COUNT(order_id) AS RevenuePerOrder
FROM orders
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY Year, Month;


SELECT
  YEAR(created_at) AS Year,
  MONTH(created_at) AS Month,
  SUM(CAST(price_usd AS DECIMAL(10,2))) * 1.0 / COUNT(DISTINCT website_session_id) AS RevenuePerSession
FROM orders
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY Year, Month;


SELECT
  products.product_name AS Product,
  SUM(CAST(order_items.price_usd AS DECIMAL(10,2))) * 1.0 / COUNT(DISTINCT order_items.order_id) AS RevenuePerOrder,
  COUNT(order_items.order_item_id) AS TotalUnitsSold,
  SUM(CAST(order_items.price_usd AS DECIMAL(10,2))) - SUM(CAST(order_items.cogs_usd AS DECIMAL(10,2))) AS GrossProfit,
  SUM(CAST(order_items.price_usd AS DECIMAL(10,2))) AS TotalRevenue
FROM order_items
LEFT JOIN products
  ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY TotalRevenue DESC;


SELECT
  products.product_name AS Product,
  COUNT(order_item_refunds.order_item_refund_id) AS TotalUnitsReturned
FROM order_item_refunds
LEFT JOIN order_items
  ON order_item_refunds.order_item_id = order_items.order_item_id
LEFT JOIN products
  ON order_items.product_id = products.product_id
GROUP BY products.product_name
ORDER BY TotalUnitsReturned DESC;







