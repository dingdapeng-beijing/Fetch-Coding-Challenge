-- Test: Ensure all `userId` in `receipts` exist in `users`
SELECT r.id AS receipt_id
FROM {{ ref('receipts') }} r
LEFT JOIN {{ ref('users') }} u ON r.userId = u.id
WHERE u.id IS NULL;
