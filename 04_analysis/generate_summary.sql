with source as (
  select
    stylist_id,
    provider_name,
    country,
    city,
    area_name,
    postcode_outward,
    location_raw,
    service_name_raw,
    category_name_raw,
    price_minor,
    currency,
    booking_url,
    fallback_booking_url,
    snapshot_fetched_at,
    external_service_id,
    data_source
  from service_facts
  where
    coalesce(service_name_raw, '') ~* '(knotless|fulani|boho|bohemian|goddess|gypsy|tribal|coi leray|french curl)'
    or coalesce(category_name_raw, '') ~* '(knotless|boho|bohemian|goddess)'
),
normalised as (
  select
    stylist_id,
    provider_name,
    country,
    city,
    area_name,
    postcode_outward,
    location_raw,
    service_name_raw,
    category_name_raw,
    case
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%fulani%' then 'fulani_braids'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%twist%' then 'twists'
      else 'knotless_braids'
    end as service_family,
    case
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%refresh%'
        or lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%touch up%' then 'refresh'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%frontal%' then 'frontal'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(fulani|tribal|tribals)' then 'fulani_tribal'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(boho|bohemian)' then 'boho'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(goddess|gypsy|french curl|curly bob|with curls)' then 'goddess_curly'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%coi leray%' then 'coi_leray'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%twist%' then 'twist'
      else 'standard'
    end as style_variant,
    case
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(extra small|xtra small|xxs|extra smalll)' then 'extra_small'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(small/medium|s/medium|small medium|smedium|shmedium)' then 'small_medium'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(jumbo|extra large)' then 'jumbo'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '\msmall\M' then 'small'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '\mmedium\M' then 'medium'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '\mlarge\M' then 'large'
      else 'unknown'
    end as size_band,
    case
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%bob%' then 'bob'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%shoulder%' then 'shoulder'
      when lower(replace(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,''), 'waistlenght', 'waist length')) like '%bra length%' then 'bra_length'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%armpit%' then 'armpit'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(mid back|midback)' then 'mid_back'
      when lower(replace(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,''), 'waistlenght', 'waist length')) like '%waist%' then 'waist'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%hip%' then 'hip'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%bum%' then 'bum'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%thigh%' then 'thigh'
      when lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%short%' then 'short'
      else 'unknown'
    end as length_band,
    (lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%refresh%'
      or lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) like '%touch up%') as is_refresh_service,
    (lower(coalesce(service_name_raw,'') || ' ' || coalesce(category_name_raw,'')) ~ '(child|kids|girls age|years|10 years and younger|11 - 16|6-10|12-16)') as is_kids_service,
    round(price_minor / 100.0, 2) as price_gbp,
    currency,
    booking_url,
    snapshot_fetched_at,
    external_service_id,
    data_source,
    (upper(coalesce(provider_name,'')) = 'DELETE') as provider_is_placeholder
  from source
)
select *
from normalised
where not provider_is_placeholder
order by provider_name, service_name_raw;
