SELECT
    user_id,
    state,
    DATE_TRUNC('day', TIMESTAMP 'epoch' + created_date / 1000 * INTERVAL '1 second') AS created_date
FROM {{ ref('raw_users') }}
WHERE user_id IS NOT NULL;
