-- models/recent_users.sql
SELECT
    user_id,
    state,
    created_date
FROM {{ ref('raw_users') }}
WHERE created_date >= CURRENT_DATE - INTERVAL '6 months'
