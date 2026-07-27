select
airport_code,
station_id,
date_trunc('week', date)::date as week,

avg(tavg) as avg_temp,
min(tmin) as min_temp,
max(tmax) as max_temp,

sum(prcp) as total_precipitation,
sum(snow) as total_snow,

avg(wspd) as avg_wind_speed

from {{ ref('prep_weather_daily') }}

group by
airport_code,
station_id,
date_trunc('week', date)