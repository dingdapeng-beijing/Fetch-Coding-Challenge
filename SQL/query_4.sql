--Q4: Compare Total Number of Items Purchased for 'Accepted' vs. 'Rejected' Status
SELECT
    r.rewards_receipt_status,
    SUM(ri.quantity) AS total_items
FROM Receipts r
JOIN ReceiptItems ri ON r.receipt_id = ri.receipt_id
WHERE r.rewards_receipt_status IN ('Accepted', 'Rejected')
GROUP BY r.rewards_receipt_status;

-- Explanation:

-- This query joins Receipts with ReceiptItems and filters for 'Accepted' or 'Rejected' statuses.
-- It calculates the total number of items purchased (SUM(ri.quantity)) for each status.