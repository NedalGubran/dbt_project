{{ config(materialized='view') }}

select

station,

date_trunc('week',date)::date as week,

avg(tavg) as avg_temp,

min(tmin) as min_temp,

max(tmax) as max_temp,

sum(prcp) as total_precipitation,

sum(snow) as total_snow,

avg(wdir) as avg_wind_direction,

avg(wspd) as avg_wind_speed,

max(wpgt) as peak_gust

from {{ ref('prep_weather_daily') }}

group by
station,
date_trunc('week',date)