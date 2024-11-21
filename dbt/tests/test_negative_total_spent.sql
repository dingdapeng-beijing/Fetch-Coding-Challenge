-- Test: Check for negative or null `totalSpent` in `receipts`
SELECT id AS receipt_id, totalSpent
FROM {{ ref('receipts') }}
WHERE totalSpent < 0 OR totalSpent IS NULL;
