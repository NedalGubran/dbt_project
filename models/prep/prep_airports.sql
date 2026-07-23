WITH airports_reorder AS (

    SELECT faa
        ,name
        ,city
        ,country
        ,region
        ,lat
        ,lon
        ,alt
        ,tz
        ,dstgi

    FROM {{ref('staging_airports')}}

)

SELECT *
FROM airports_reorder