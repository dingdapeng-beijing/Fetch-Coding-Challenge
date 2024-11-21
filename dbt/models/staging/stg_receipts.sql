SELECT
    receipt_id,
    user_id,
    DATE_TRUNC('day', TIMESTAMP 'epoch' + purchase_date / 1000 * INTERVAL '1 second') AS purchase_date,
    DATE_TRUNC('day', TIMESTAMP 'epoch' + date_scanned / 1000 * INTERVAL '1 second') AS date_scanned,
    total_spent::decimal AS total_spent,
    rewards_receipt_status
FROM {{ ref('raw_receipts') }}
WHERE receipt_id IS NOT NULL;
