-- Test: Check for invalid `rewardsReceiptStatus` values in `receipts`
SELECT DISTINCT rewardsReceiptStatus
FROM {{ ref('receipts') }}
WHERE rewardsReceiptStatus NOT IN ('Accepted', 'Rejected', 'Pending');
