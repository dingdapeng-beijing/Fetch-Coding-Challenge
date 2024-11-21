--Q3: Compare Average Spend for Receipts with 'Accepted' vs. 'Rejected' Status
SELECT
    rewards_receipt_status,
    AVG(total_spent) AS avg_spend
FROM Receipts
WHERE rewards_receipt_status IN ('Accepted', 'Rejected')
GROUP BY rewards_receipt_status;

-- Explanation:
-- This query filters receipts with a rewards_receipt_status of 'Accepted' or 'Rejected'.
-- It calculates the average spend (total_spent) for each status and groups results by rewards_receipt_status.