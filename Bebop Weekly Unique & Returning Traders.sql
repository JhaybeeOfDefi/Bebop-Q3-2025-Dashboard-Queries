with user_first_trade as (
    select
        taker
        , MIN(block_time) as first_trade_time
        , MIN(DATE_TRUNC('week', block_time)) as first_trade_week
        from dex_aggregator.trades
        where project = 'bebop'
        group by
    1
)
        , q3_weekly as (
        select
        DATE_TRUNC('week', block_time) as week
        , taker
        , COUNT(*) as trades
        from dex_aggregator.trades
        where project = 'bebop'
   and block_time >= CAST('2025-08-01' as TIMESTAMP)
   and block_time < CAST('2025-11-01' as TIMESTAMP)
        group by
    1
    , 2
)
select
    qw.week
    , COUNT(distinct qw.taker) as "unique traders"
    , COUNT(
        distinct case
when uft.first_trade_week < qw.week
    then qw.taker
end
) as "returning traders"
        , COUNT(
        distinct case
when uft.first_trade_week = qw.week
    then qw.taker
end
) as "new traders"
        , ROUND(
        100.0 * COUNT(
            distinct case
when uft.first_trade_week < qw.week
    then qw.taker
end
) / COUNT(distinct qw.taker)
        , 2
) as "returning pct"
        , SUM(qw.trades) as "total trades"
from q3_weekly qw
    inner join user_first_trade uft on qw.taker = uft.taker
group by
    1
order by
    1
