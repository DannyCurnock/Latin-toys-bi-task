-- Executive Overview 


SELECT 
    YEAR(created_at) AS Year,
    COUNT(website_session_id) AS TotalSessions
FROM website_sessions
GROUP BY YEAR(created_at)
ORDER BY Year;


SELECT 
    YEAR(created_at) AS Year,
    COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY YEAR(created_at)
ORDER BY Year;


SELECT 
    YEAR(created_at) AS Year,
    SUM(CAST(price_usd AS DECIMAL(10,2))) AS TotalRevenue
FROM orders
GROUP BY YEAR(created_at)
ORDER BY Year;



SELECT 
    YEAR(created_at) AS Year,
    (SUM(CAST(price_usd AS DECIMAL(10,2))) 
     - SUM(CAST(cogs_usd AS DECIMAL(10,2))))
    /
    SUM(CAST(price_usd AS DECIMAL(10,2))) 
    AS GrossMargin
FROM order_items
GROUP BY YEAR(created_at)
ORDER BY Year;


SELECT 
    YEAR(created_at) AS Year,
    MONTH(created_at) AS Month,
    COUNT(website_session_id) AS TotalSessions
FROM website_sessions
GROUP BY 
    YEAR(created_at),
    MONTH(created_at)
ORDER BY 
    Year,
    Month;


SELECT 
    YEAR(created_at) AS Year,
    MONTH(created_at) AS Month,
    COUNT(order_id) AS TotalOrders
FROM orders
GROUP BY 
    YEAR(created_at),
    MONTH(created_at)
ORDER BY 
    Year,
    Month;


SELECT 
    website_sessions.utm_source AS MarketingChannel,
    COUNT(DISTINCT orders.order_id) * 100.0
    / COUNT(DISTINCT website_sessions.website_session_id)
    AS ConversionRatePct
FROM website_sessions
LEFT JOIN orders
    ON website_sessions.website_session_id = orders.website_session_id
GROUP BY website_sessions.utm_source
ORDER BY ConversionRatePct DESC;


SELECT 
    website_sessions.utm_source AS MarketingChannel,
    SUM(CAST(orders.price_usd AS DECIMAL(10,2))) AS TotalRevenue
FROM orders
LEFT JOIN website_sessions
    ON orders.website_session_id = website_sessions.website_session_id
GROUP BY website_sessions.utm_source
ORDER BY TotalRevenue DESC;











