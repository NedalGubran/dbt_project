{{ config(materialized='table') }}

with routes as (

    select

        origin,

        dest,

        count(*) as total_flights,

        count(distinct tail_number) as unique_airplanes,

        count(distinct airline) as unique_airlines,

        avg(actual_elapsed_time) as avg_actual_elapsed_time,

        avg(arr_delay) as avg_arrival_delay,

        max(arr_delay) as max_delay,

        min(arr_delay) as min_delay,

        sum(cancelled) as total_cancelled,

        sum(diverted) as total_diverted

    from {{ ref('prep_flights') }}

    group by
        origin,
        dest

)

select

    r.origin,

    r.dest,

    r.total_flights,

    r.unique_airplanes,

    r.unique_airlines,

    r.avg_actual_elapsed_time,

    r.avg_arrival_delay,

    r.max_delay,

    r.min_delay,

    r.total_cancelled,

    r.total_diverted,


    origin_airport.name as origin_name,

    origin_airport.city as origin_city,

    origin_airport.country as origin_country,


    destination_airport.name as destination_name,

    destination_airport.city as destination_city,

    destination_airport.country as destination_country


from routes r


left join {{ ref('prep_airports') }} origin_airport

on origin_airport.faa = r.origin


left join {{ ref('prep_airports') }} destination_airport

on destination_airport.faa = r.dest