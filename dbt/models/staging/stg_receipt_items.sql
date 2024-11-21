SELECT
    id AS receipt_item_id,
    receipt_id,
    brand_id,
    barcode,
    description,
    quantity::integer AS quantity,
    price::decimal AS price,
    total_price::decimal AS total_price
FROM {{ ref('raw_receipt_items') }}
WHERE receipt_id IS NOT NULL;
