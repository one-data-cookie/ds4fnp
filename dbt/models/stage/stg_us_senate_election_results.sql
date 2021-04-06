select
    to_date(year::varchar, 'YYYY') as year,
    initcap(candidate) as candidate,
    initcap(party_simplified) as party,
    initcap(state) as state,
    state_po,
    coalesce(district, '1') as district,
    candidatevotes::integer as votes_tally,
    totalvotes as votes_total,
    round(candidatevotes::numeric / totalvotes::numeric, 2) as votes_perc
from
    {{ source('ds4fnp', 'mit__senate_elections') }}
where
    writein = 'FALSE'
    and totalvotes != 0
