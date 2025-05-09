select 
        b.name_city as city 
        , c.name_tariff as tariff
        , count(a.id_order) as total_order
        , count(case when a.id_driver is not null then 1 end) as order_with_driver
        , (count(case when a.id_driver is not null then 1 end) * 1.0 / count(a.id_order)) as order_2_offer
        , count(case when a.assign_time is not null then 1 end) as order_with_assignment
        , (count(case when a.assign_time is not null then 1 end) * 1.0 / count(case when a.id_driver is not null then 1 end)) as order_2_assign
        , count(case when a.arrive_to_client_time is not null then 1 end) as order_with_arrival
        , (count(case when a.arrive_to_client_time is not null then 1 end) * 1.0 / count(case when a.assign_time is not null then 1 end)) as assign_2_arrival
        , count(case when a.order_finish_time is not null then 1 end) as order_with_finish
        , (count(case when a.order_finish_time is not null then 1 end) * 1.0 / count(case when a.arrive_to_client_time is not null then 1 end)) as arrival_2_ride
        , (count(case when a.order_finish_time is not null then 1 end) * 1.0 / count(a.id_order)) as order_2_ride
from skytaxi.order_list as a
    left join skytaxi.city_dict as b on a.id_city = b.id_city
    left join skytaxi.tariff_dict as c on a.id_tariff = c.id_tariff 
where b.name_city in ('Москва', 'Санкт-Петербург')
    and c.name_tariff in ('Эконом', 'Комфорт')
    and a.order_time between '2021-07-01' and '2021-07-31'
group by b.name_city, c.name_tariff
order by b.name_city, c.name_tariff
