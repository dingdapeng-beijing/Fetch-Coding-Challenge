-- Test: Ensure `purchaseDate` is before or equal to `dateScanned`
SELECT id AS receipt_id, purchaseDate, dateScanned
FROM {{ ref('receipts') }}
WHERE purchaseDate > dateScanned;
