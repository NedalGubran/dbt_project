{{ config(materialized='table') }}

select

    airport_code,

    station_id,

    date_trunc('week', date)::date as week,

    avg(avg_temp_c) as avg_temp,

    min(min_temp_c) as min_temp,

    max(max_temp_c) as max_temp,

    sum(precipitation_mm) as total_precipitation,

    sum(max_snow_mm) as total_snow,

    avg(avg_wind_direction) as avg_wind_direction,

    avg(avg_wind_speed_kmh) as avg_wind_speed,

    max(wind_peakgust_kmh) as peak_gust,

    max(season) as season

from {{ ref('prep_weather_daily') }}

group by

    airport_code,

    station_id,

    date_trunc('week', date)