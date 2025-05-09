-- select count (distinct date_purchase) as unique_date_purchase
-- from skycinema.client_sign_up

-- with subquery as (select date_purchase
--         , row_number() over (order by date_purchase) as rn_date_purchase
-- from skycinema.client_sign_up)

-- select count (distinct date_purchase) as unique_date_purchase
-- from subquery

with subquery as (select date_purchase
        , rank() over (order by date_purchase) as rn_date_purchase
from skycinema.client_sign_up)

select count (distinct date_purchase) as unique_date_purchase
from subquery
