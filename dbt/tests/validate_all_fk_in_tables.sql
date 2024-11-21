-- Test: Ensure all `brandId` in `receipt_items` exist in `brands`
SELECT ri.id AS receipt_item_id
FROM {{ ref('receipt_items') }} ri
LEFT JOIN {{ ref('brands') }} b ON ri.brandId = b.id
WHERE b.id IS NULL;
