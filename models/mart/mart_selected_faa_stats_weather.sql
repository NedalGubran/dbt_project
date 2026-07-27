with flight_stats as (

select

origin as airport,

flight_date,

count(*) total_flights,

sum(cancelled) cancelled,

sum(diverted) diverted,

count(distinct dest) departure_connections

from {{ ref('prep_flights') }}

group by
origin,
flight_date

)

select

f.*,

w.tmin,
w.tmax,
w.prcp,
w.snow,
w.wdir,
w.wspd,
w.wpgt

from flight_stats f

left join {{ ref('prep_weather_daily') }} w

on f.airport=w.station
and f.flight_date=w.date