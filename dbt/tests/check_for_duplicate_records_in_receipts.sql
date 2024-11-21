-- Test: Ensure there are no duplicate `id` values in `receipts`
SELECT id, COUNT(*) 
FROM {{ ref('receipts') }}
GROUP BY id
HAVING COUNT(*) > 1;
