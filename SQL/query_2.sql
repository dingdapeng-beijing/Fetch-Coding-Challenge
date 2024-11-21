--Compare Top 5 Brands for Recent Month and Previous Month
-- Step 1: Extract receipt data in CTE.
WITH MonthlyReceipts AS (
    SELECT
        r.receipt_id,
        ri.brand_id,
        b.brand_name,
        DATE_TRUNC('month', r.purchase_date) AS receipt_month
    FROM Receipts r
    JOIN ReceiptItems ri ON r.receipt_id = ri.receipt_id
    JOIN Brands b ON ri.brand_id = b.brand_id
    WHERE r.purchase_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '2 months'
      AND r.purchase_date < DATE_TRUNC('month', CURRENT_DATE)
)

-- Step 2: Rank brands within each month by receipt count.
, BrandRankings AS (
    SELECT
        receipt_month,
        brand_name,
        COUNT(DISTINCT receipt_id) AS receipt_count,
        RANK() OVER (PARTITION BY receipt_month ORDER BY COUNT(DISTINCT receipt_id) DESC) AS brand_rank
    FROM MonthlyReceipts
    GROUP BY receipt_month, brand_name
)

-- Step 3: Compare ranks for recent month and previous month.
SELECT
    a.receipt_month AS current_month,
    a.brand_name AS current_month_brand,
    a.brand_rank AS current_month_rank,
    b.receipt_month AS previous_month,
    b.brand_name AS previous_month_brand,
    b.brand_rank AS previous_month_rank
FROM BrandRankings a
LEFT JOIN BrandRankings b
  ON a.brand_name = b.brand_name AND b.receipt_month = a.receipt_month - INTERVAL '1 month'
WHERE a.receipt_month = DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
  AND a.brand_rank <= 5;

-- Explanation:

-- The MonthlyReceipts CTE filters data for the last two months and groups it by brand and month.
-- The BrandRankings CTE calculates rankings for brands within each month using RANK().
-- The final query compares the rankings of top 5 brands between the recent and previous months.
