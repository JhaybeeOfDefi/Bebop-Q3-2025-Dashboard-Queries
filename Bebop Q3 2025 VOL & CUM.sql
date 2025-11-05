select
    DATE_TRUNC('day', block_time) as day
    , SUM(amount_usd) as "daily volume"
    , SUM(SUM(amount_usd)) over (
        order by
    DATE_TRUNC('day', block_time)
) as "cumulative volume"
from dex_aggregator.trades
where project = 'bebop'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
group by
    1
order by
    1
