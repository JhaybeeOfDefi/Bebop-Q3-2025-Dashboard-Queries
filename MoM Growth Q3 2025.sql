with monthly_volumes as (
    select
        DATE_TRUNC('month', block_time) as month
        , SUM(amount_usd) as monthly_volume_usd
        from dex_aggregator.trades
        where project = 'bebop'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
)
        , growth_calc as (
        select
        month
        , monthly_volume_usd
        , LAG(monthly_volume_usd) over (
                order by
    month
) as prev_month_volume
        , ROUND(
                100.0 * (
                    monthly_volume_usd - LAG(monthly_volume_usd) over (
                        order by
    month
)
) / NULLIF(
                    LAG(monthly_volume_usd) over (
                        order by
    month
)
        , 0
)
        , 2
) as mom_growth_pct
        from monthly_volumes
)
select
    case
when month = CAST('2025-08-01' as TIMESTAMP)
    then 'August'
when month = CAST('2025-09-01' as TIMESTAMP)
    then 'September'
when month = CAST('2025-10-01' as TIMESTAMP)
    then 'October'
end as "month"
        , ROUND(monthly_volume_usd, 0) as "volume usd"
        , ROUND(COALESCE(prev_month_volume, 0), 0) as "prev month volume"
        , COALESCE(mom_growth_pct, 0) as "growth pct"
from growth_calc
order by
    3 desc
