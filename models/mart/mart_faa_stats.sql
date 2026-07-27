{{ config(materialized='table') }}

with departures as (

    select
        origin as airport_code,
        count(distinct dest) as departure_connections,
        count(*) as departures_total,
        sum(cancelled) as cancelled_departures,
        sum(diverted) as diverted_departures,
        sum(case when cancelled = 0 then 1 else 0 end) as actual_departures,
        count(distinct tail_number) as unique_airplanes,
        count(distinct airline) as unique_airlines

    from {{ ref('prep_flights') }}

    group by origin

),

arrivals as (

    select
        dest as airport_code,
        count(distinct origin) as arrival_connections,
        count(*) as arrivals_total,
        sum(cancelled) as cancelled_arrivals,
        sum(diverted) as diverted_arrivals,
        sum(case when cancelled = 0 then 1 else 0 end) as actual_arrivals

    from {{ ref('prep_flights') }}

    group by dest

)

select

    coalesce(d.airport_code, ar.airport_code) as airport_code,

    coalesce(departure_connections,0) as departure_connections,
    coalesce(arrival_connections,0) as arrival_connections,

    coalesce(departures_total,0)
    + coalesce(arrivals_total,0) as total_flights,

    coalesce(cancelled_departures,0)
    + coalesce(cancelled_arrivals,0) as total_cancelled,

    coalesce(diverted_departures,0)
    + coalesce(diverted_arrivals,0) as total_diverted,

    coalesce(actual_departures,0)
    + coalesce(actual_arrivals,0) as actual_flights,

    unique_airplanes,
    unique_airlines,

    a.name as airport_name,
    a.city,
    a.country

from departures d

full join arrivals ar
on d.airport_code = ar.airport_code

left join {{ ref('prep_airports') }} a
on a.faa = coalesce(d.airport_code, ar.airport_code)