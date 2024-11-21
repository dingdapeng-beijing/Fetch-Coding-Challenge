-- models/monthly_receipts.sql
WITH receipts_with_months AS (
    SELECT
        receipt_id,
        DATE_TRUNC('month', purchase_date) AS receipt_month,
        user_id
    FROM {{ ref('raw_receipts') }}
    WHERE purchase_date IS NOT NULL
)
SELECT
    receipt_month,
    COUNT(DISTINCT receipt_id) AS total_receipts,
    user_id
FROM receipts_with_months
GROUP BY receipt_month, user_id
