-- Выведите все заказы, которые являются первыми
-- или в рамках всех заказов, или в рамках своего города,
-- или в рамках своего города+тарифа.
-- Из этих трех множеств будут ли те, что включены друг в друга?
select *
    from (select id_order
        , id_driver
        , order_time
        , name_city
        , name_tariff
        , row_number() over (order by order_time asc) as rn_order_time
        , row_number() over (partition by name_city order by order_time asc) as rn_city
        , row_number() over (partition by name_city, name_tariff order by order_time asc) as rn_city_tariff
from skytaxi.order_list as order_list
    left join skytaxi.city_dict as city_dict on order_list.id_city = city_dict.id_city
    left join skytaxi.tariff_dict as tariff_dict on order_list.id_tariff = tariff_dict.id_tariff) as subquery
where rn_order_time = 1 
    or rn_city = 1 
    or rn_city_tariff = 1
limit 100
