{{ config(materialized='view') }}

select

origin,
dest,

count(*) as total_flights,

count(distinct tail_number) as unique_airplanes,

count(distinct airline) as unique_airlines,

avg(actual_elapsed_time) as avg_elapsed,

avg(arr_delay) as avg_arrival_delay,

max(arr_delay) as max_delay,

min(arr_delay) as min_delay,

sum(cancelled) as cancelled,

sum(diverted) as diverted

from {{ ref('prep_flights') }}

group by
origin,
dest