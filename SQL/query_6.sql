--Q6: Brand with Most Transactions Among Users Created Within the Past 6 Months
-- Step 1: Filter users created in the last 6 months.
WITH RecentUsers AS (
    SELECT user_id
    FROM Users
    WHERE created_date >= CURRENT_DATE - INTERVAL '6 months'
)

-- Step 2: CTE to capture transactions info for brands for these users.
, UserReceipts AS (
    SELECT
        r.receipt_id,
        r.user_id,
        ri.brand_id,
        b.brand_name
    FROM Receipts r
    JOIN ReceiptItems ri ON r.receipt_id = ri.receipt_id
    JOIN Brands b ON ri.brand_id = b.brand_id
    WHERE r.user_id IN (SELECT user_id FROM RecentUsers)
)

-- Step 3: Find the brand with the most transactions.
SELECT
    brand_name,
    COUNT(DISTINCT receipt_id) AS transaction_count
FROM UserReceipts
GROUP BY brand_name
ORDER BY transaction_count DESC
LIMIT 1;

-- Explanation:

-- The RecentUsers CTE filters users created in the past 6 months.
-- The UserReceipts CTE filters receipts for these users.
-- The main query counts distinct transactions for each brand and selects the one with the most transactions.