-- Подтянуть следующее и предыдущее время заказа для каждой строки в рамках города
select    id_order
        , order_time
        , name_city
        , lag(order_time) over (partition by name_city order by order_time asc) as order_time_prev
        , lead(order_time) over (partition by name_city order by order_time asc) as order_time_next
from skytaxi.order_list a
    left join skytaxi.city_dict b
        on a.id_city = b.id_city
