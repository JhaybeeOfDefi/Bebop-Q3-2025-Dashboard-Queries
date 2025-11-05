with all_projects as (
    select
        'Bebop' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'bebop'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        'KyberSwap' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'kyberswap'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        'LiFi' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'lifi'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        'Tokenlon' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'tokenlon'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        'Velora' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'paraswap'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        'SushiSwap' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'sushiswap'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        '0x Aggregator' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = '0x API'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        '1inch' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = '1inch'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        'CoWSwap' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'cow_protocol'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
        union all
    select
        'ODOS' as project_name
        , DATE_TRUNC('day', block_time) as day
        , SUM(amount_usd) as daily_volume_usd
        from dex_aggregator.trades
        where project = 'odos'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
)
        , top_aggregators as (
        select
        project_name
        , SUM(daily_volume_usd) as total_volume
        from all_projects
        group by
    1
        order by
    2 desc 
)
select
    ap.day
    , ap.project_name
    , ROUND(ap.daily_volume_usd, 0) as "daily volume usd"
from all_projects ap
where ap.project_name in (
        select
            project_name
        from top_aggregators
)
order by
    ap.day
    , ap.project_name
