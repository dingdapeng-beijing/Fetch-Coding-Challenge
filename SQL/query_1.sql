-- Q1: Top 5 Brands by Receipts Scanned for the Most Recent Month
-- Step 1: Filter receipts scanned in the most recent month.
WITH RecentReceipts AS (
    SELECT
        r.receipt_id,
        ri.brand_id,
        b.brand_name,
        r.purchase_date
    FROM Receipts r
    JOIN ReceiptItems ri ON r.receipt_id = ri.receipt_id
    JOIN Brands b ON ri.brand_id = b.brand_id
    WHERE r.purchase_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month' 
      AND r.purchase_date < DATE_TRUNC('month', CURRENT_DATE)
)

-- Step 2: Count distinct receipts by brand and rank them.
SELECT
    brand_name,
    COUNT(DISTINCT receipt_id) AS receipt_count
FROM RecentReceipts
GROUP BY brand_name
ORDER BY receipt_count DESC
LIMIT 5;

-- Explanation:
-- The RecentReceipts CTE filters data for receipts scanned in the most recent month.
-- The main query counts the number of distinct receipts for each brand, groups by brand, and selects the top 5 by count.