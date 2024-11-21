-- Test: Check for negative or null `price` in `receipt_items`
SELECT id AS receipt_item_id, price
FROM {{ ref('receipt_items') }}
WHERE price < 0 OR price IS NULL;
