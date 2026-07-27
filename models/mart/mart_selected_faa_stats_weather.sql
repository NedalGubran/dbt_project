{{ config(materialized='table') }}

with flight_stats as (

    select

        origin as airport_code,

        flight_date,

        count(distinct dest) as departure_connections,

        count(*) as total_flights,

        sum(cancelled) as total_cancelled,

        sum(diverted) as total_diverted,

        sum(case when cancelled = 0 then 1 else 0 end) as actual_flights,

        count(distinct tail_number) as unique_airplanes,

        count(distinct airline) as unique_airlines

    from {{ ref('prep_flights') }}

    group by
        origin,
        flight_date

),

weather_stats as (

    select

        airport_code,

        date,

        min_temp_c,

        max_temp_c,

        precipitation_mm,

        max_snow_mm,

        avg_wind_direction,

        avg_wind_speed_kmh,

        wind_peakgust_kmh

    from {{ ref('prep_weather_daily') }}

)

select

    f.airport_code,

    f.flight_date,

    f.departure_connections,

    f.total_flights,

    f.total_cancelled,

    f.total_diverted,

    f.actual_flights,

    f.unique_airplanes,

    f.unique_airlines,


    a.name as airport_name,

    a.city,

    a.country,


    w.min_temp_c,

    w.max_temp_c,

    w.precipitin_mm,

    w.max_snow_mm,

    w.avg_wind_direction,

    w.avg_wind_speed_kmh,

    w.wind_peakgust_kmh


from flight_stats f


left join {{ ref('prep_airports') }} a

on a.faa = f.airport_code


left join weather_stats w

on f.airport_code = w.airport_code

and f.flight_date = w.date