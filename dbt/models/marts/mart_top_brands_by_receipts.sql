-- models/top_brands_by_receipts.sql
-- This model identifies the top 5 brands by receipts scanned for the most recent month.
WITH recent_month AS (
    SELECT
        MAX(receipt_month) AS latest_month
    FROM {{ ref('monthly_receipts') }}
),
top_brands AS (
    SELECT
        rib.brand_name,
        COUNT(DISTINCT rib.receipt_id) AS receipt_count
    FROM {{ ref('receipt_items_with_brands') }} rib
    INNER JOIN {{ ref('raw_receipts') }} r
    ON rib.receipt_id = r.receipt_id
    INNER JOIN recent_month rm
    ON DATE_TRUNC('month', r.purchase_date) = rm.latest_month
    GROUP BY rib.brand_name
    ORDER BY receipt_count DESC
    LIMIT 5
)
SELECT *
FROM top_brands
