-- models/brand_performance_recent_users.sql
-- This model calculates the top-performing brands by spend or transactions for users created in the past six months.
WITH recent_user_receipts AS (
    SELECT
        ru.user_id,
        r.receipt_id,
        rib.brand_id,
        rib.brand_name,
        SUM(rib.total_price) AS total_spend,
        COUNT(DISTINCT r.receipt_id) AS transaction_count
    FROM {{ ref('recent_users') }} ru
    INNER JOIN {{ ref('raw_receipts') }} r
    ON ru.user_id = r.user_id
    INNER JOIN {{ ref('receipt_items_with_brands') }} rib
    ON r.receipt_id = rib.receipt_id
    GROUP BY ru.user_id, r.receipt_id, rib.brand_id, rib.brand_name
)
SELECT
    brand_name,
    SUM(total_spend) AS total_spend,
    SUM(transaction_count) AS transaction_count
FROM recent_user_receipts
GROUP BY brand_name
ORDER BY total_spend DESC, transaction_count DESC
LIMIT 1
