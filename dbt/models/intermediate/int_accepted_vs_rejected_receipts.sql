-- models/accepted_vs_rejected_receipts.sql
-- This model groups receipts based on their rewardsReceiptStatus (e.g., Accepted, Rejected) to analyze spend and item counts.
SELECT
    rewards_receipt_status,
    COUNT(DISTINCT receipt_id) AS receipt_count,
    SUM(total_spent) AS total_spend,
    SUM(quantity_purchased) AS total_items
FROM (
    SELECT
        r.receipt_id,
        r.rewards_receipt_status,
        r.total_spent,
        SUM(ri.quantity) AS quantity_purchased
    FROM {{ ref('raw_receipts') }} r
    LEFT JOIN {{ ref('raw_receipt_items') }} ri
    ON r.receipt_id = ri.receipt_id
    WHERE r.rewards_receipt_status IN ('Accepted', 'Rejected')
    GROUP BY r.receipt_id, r.rewards_receipt_status, r.total_spent
) aggregated
GROUP BY rewards_receipt_status
