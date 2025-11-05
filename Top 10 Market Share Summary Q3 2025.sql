with all_projects as (
    select
        'Bebop' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'bebop'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        'KyberSwap' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'kyberswap'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        'LiFi' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'lifi'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        'Tokenlon' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'tokenlon'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        'Velora' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'paraswap'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        'SushiSwap' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'sushiswap'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        '0x Aggregator' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = '0x API'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        '1inch' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = '1inch'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        'CoWSwap' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'cow_protocol'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
        union all
    select
        'ODOS' as project_name
        , SUM(amount_usd) as total_volume_usd
        , COUNT(*) as total_trades
        , COUNT(distinct taker) as unique_traders
        from dex_aggregator.trades
        where project = 'odos'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
)
        , top_aggregators as (
        select
        project_name
        , total_volume_usd
        , total_trades
        , unique_traders
        from all_projects
        order by
    total_volume_usd desc
)
select
    project_name
    , ROUND(total_volume_usd, 0) as volume_usd
    , total_trades
    , unique_traders
    , ROUND(100.0 * total_volume_usd / SUM(total_volume_usd) over ()
    , 2) as market_share_pct
    , ROUND(total_volume_usd / total_trades, 0) as avg_trade_size_usd
from top_aggregators
order by
    volume_usd desc
