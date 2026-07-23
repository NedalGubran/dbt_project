{{ config(materialized='table') }}

WITH raw_weather AS (

    SELECT
        extracted_at,
        airport_code,
        station_id,
        extracted_data

    FROM {{ source('weather_data', 'weather_hourly_raw') }}

),

weather_extracted AS (

    SELECT

        airport_code,
        station_id,

        (data->>'time')::TIMESTAMP AS timestamp,

        (data->>'temp')::NUMERIC AS temperature,

        (data->>'rhum')::NUMERIC AS relative_humidity,

        (data->>'pres')::NUMERIC AS pressure,

        (data->>'wspd')::NUMERIC AS wind_speed,

        (data->>'wdir')::NUMERIC AS wind_direction,

        (data->>'prcp')::NUMERIC AS precipitation,

        (data->>'coco')::INTEGER AS weather_condition

    FROM raw_weather,

    LATERAL jsonb_array_elements(extracted_data->'data') AS data

)

SELECT *
FROM weather_extracted