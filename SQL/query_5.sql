--Q5: Brand with Most Spend Among Users Created Within the Past 6 Months
-- Step 1: Filter users created in the last 6 months.
WITH RecentUsers AS (
    SELECT user_id
    FROM Users
    WHERE created_date >= CURRENT_DATE - INTERVAL '6 months'
)

-- Step 2: CTE to capture user total spend for all brands for these users.
, UserReceipts AS (
    SELECT
        r.receipt_id,
        r.user_id,
        ri.brand_id,
        b.brand_name,
        ri.total_price
    FROM Receipts r
    JOIN ReceiptItems ri ON r.receipt_id = ri.receipt_id
    JOIN Brands b ON ri.brand_id = b.brand_id
    WHERE r.user_id IN (SELECT user_id FROM RecentUsers)
)

-- Step 3: Find the brand with the highest spend.
SELECT
    brand_name,
    SUM(total_price) AS total_spend
FROM UserReceipts
GROUP BY brand_name
ORDER BY total_spend DESC
LIMIT 1;

-- Explanation:

-- The RecentUsers CTE identifies users created in the last 6 months.
-- The UserReceipts CTE filters receipts for these users and calculates spend by brand.
-- The main query selects the brand with the highest total spend.