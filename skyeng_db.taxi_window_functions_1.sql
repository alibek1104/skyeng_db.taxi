-- Подтянуть следующее и предыдущее время заказа для каждой строки
-- в рамках всей таблицы (skytaxi.order_list)
select   id_order
       , order_time
       , name_tariff
       , name_city
       , lag(order_time) over (order by order_time asc)   
       , lead(order_time) over (order by order_time asc)   
from skytaxi.order_list o
    left join skytaxi.tariff_dict t
        on o.id_tariff = t.id_tariff
    left join skytaxi.city_dict c
        on o.id_city = c.id_city
