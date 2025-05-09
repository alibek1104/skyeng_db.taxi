with subquery as 
    (select *
        , row_number() over (order by date_purchase) as rn_dp
        , row_number() over (partition by user_id order by date_purchase) as rn_user_purchase
from skycinema.client_sign_up as cg
    left join skycinema.partner_dict as dict on cg.partner = dict.id_partner)

select name_partner
        , count(distinct user_id) as total_purchases
        , sum(case when rn_user_purchase = 1 then 1 else 0 end) as first_clients
        , sum(case when rn_user_purchase = 2 then 1 else 0 end) * 100.0 / nullif(sum(case when rn_user_purchase = 1 then 1 else 0 end), 0) as percent_second
        , sum(case when rn_user_purchase = 3 then 1 else 0 end) * 100.0 / nullif(sum(case when rn_user_purchase = 1 then 1 else 0 end), 0) as percent_third
        , sum(case when rn_user_purchase = 4 then 1 else 0 end) * 100.0 / nullif(sum(case when rn_user_purchase = 1 then 1 else 0 end), 0) as percent_fourth
        , sum(case when rn_user_purchase = 5 then 1 else 0 end) * 100.0 / nullif(sum(case when rn_user_purchase = 1 then 1 else 0 end), 0) as percent_fifth
        , sum(case when rn_user_purchase = 6 then 1 else 0 end) * 100.0 / nullif(sum(case when rn_user_purchase = 1 then 1 else 0 end), 0) as percent_sixth
from subquery
group by name_partner
