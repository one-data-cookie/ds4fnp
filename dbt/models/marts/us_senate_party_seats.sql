with
rnk as (
  	select
    		*,
    		rank() over (
            partition by
                year,
          			state,
          			district
            order by
                votes_tally desc
        ) AS pos
  	from {{ ref('stg_us_senate_election_results') }}
),

final as (
  select
  	year,
  	party,
  	count(*) as seats
  from rnk
  where pos = 1
  group by
    year,
    party
)

select * from final
