-- Для каждого города найти среднее время, которое проходит между заказами

-- select name_city
--         , avg(delta_time) as avg_delta_time
-- from (select id_order
--         , order_time
--         , name_city
--         , order_time
--         , order_time - lag(order_time) over (partition by name_city order by order_time asc) as delta_time
-- from skytaxi.order_list as order_list
--     left join skytaxi.city_dict as city_dict on order_list.id_city = city_dict.id_city) as subquery
-- group by name_city

with subquery as (
select id_order
        , order_time
        , name_city
        , order_time
        , order_time - lag(order_time) over (partition by name_city order by order_time asc) as delta_time
from skytaxi.order_list as order_list
    left join skytaxi.city_dict as city_dict on order_list.id_city = city_dict.id_city)
    
select name_city
        , avg(delta_time) as avg_delta_time
from subquery
group by name_city
