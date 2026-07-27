SELECT

origin,

COUNT(*) AS total_flights,

SUM(
CASE
WHEN cancelled = TRUE THEN 1
ELSE 0
END
) AS cancelled

FROM {{ ref('prep_flights') }}

GROUP BY origin