{{ config(materialized='table') }}

WITH weather_hourly AS (

    SELECT *
    FROM {{ source('weather_data', 'weather_hourly') }}

),

cleaned_weather AS (

    SELECT

        timestamp

        , city

        , latitude

        , longitude

        , temperature::NUMERIC

        , ROUND(temperature)::INTEGER AS temperature_int

        , ROUND(relative_humidity)::INTEGER AS relative_humidity

        , ROUND(pressure)::INTEGER AS pressure

        , ROUND(wind_speed)::NUMERIC AS wind_speed

        , ROUND(wind_direction)::INTEGER AS wind_direction

        , ROUND(precipitation)::NUMERIC AS precipitation

        , ROUND(cloud_cover)::INTEGER AS cloud_cover

    FROM weather_hourly

)

SELECT *
FROM cleaned_weather