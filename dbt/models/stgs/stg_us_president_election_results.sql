{% if target.name == 'postgres' -%}

select
    to_date(year::varchar, 'YYYY') as year,
    initcap(candidate) as candidate,
    initcap(party_simplified) as party,
    initcap(state) as state,
    state_po,
    '1' as district,
    candidatevotes::integer as votes_tally,
    totalvotes as votes_total,
    round(candidatevotes::numeric / totalvotes::numeric, 2) as votes_perc
from
    {{ source('ds4fnp', 'mit__president_elections') }}
where
    writein = 'FALSE'
    and totalvotes != 0

{% elif target.name == 'bigquery' -%}

select
    parse_date('%Y', cast(year as string)) as year,
    initcap(candidate) as candidate,
    initcap(party_simplified) as party,
    initcap(state) as state,
    state_po,
    '1' as district,
    cast(candidatevotes as integer) as votes_tally,
    totalvotes as votes_total,
    round(cast(candidatevotes as numeric) / cast(totalvotes as numeric), 2) as votes_perc
from
    {{ source('ds4fnp', 'mit__president_elections') }}
where
    writein = 'FALSE'
    and totalvotes != 0

{% endif -%}
