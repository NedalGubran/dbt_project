WITH airports_regions_join AS (

    SELECT *
    FROM {{source('airports')}}

    LEFT JOIN {{source('regions')}}

    USING (country)

)

SELECT *
FROM airports_regions_join 