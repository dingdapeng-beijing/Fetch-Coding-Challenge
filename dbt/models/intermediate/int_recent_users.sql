-- models/recent_users.sql
-- This model filters users created within the past six months to support analyses like top-performing brands among new users.
SELECT
    user_id,
    state,
    created_date
FROM {{ ref('raw_users') }}
WHERE created_date >= CURRENT_DATE - INTERVAL '6 months'
