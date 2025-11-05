select
    DATE_TRUNC('day', block_time) as day
    , blockchain
    , SUM(amount_usd) as "daily volume usd"
from dex_aggregator.trades
where project = 'bebop'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
group by
    1
    , 2
order by
    1
    , 2
