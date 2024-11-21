SELECT
    brand_id,
    name AS brand_name
FROM {{ ref('raw_brands') }}
WHERE brand_id IS NOT NULL;
