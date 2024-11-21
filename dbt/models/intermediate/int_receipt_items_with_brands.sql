-- models/receipt_items_with_brands.sql
-- This model joins ReceiptItems with Brands to provide enriched item-level data.
SELECT
    ri.receipt_id,
    ri.barcode,
    ri.quantity AS quantity_purchased,
    ri.price,
    ri.total_price,
    b.brand_id,
    b.name AS brand_name
FROM {{ ref('raw_receipt_items') }} ri
LEFT JOIN {{ ref('raw_brands') }} b
ON ri.brand_id = b.brand_id
