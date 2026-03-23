-- Service Summary Analysis
-- This query generates basic counts from the normalised knotless dataset

-- 1. Count total services
select count(*) as total_services
from normalised_knotless_services;

-- 2. Count distinct providers
select count(distinct stylist_id) as total_providers
from normalised_knotless_services;

-- 3. Count by style variant
select
  style_variant,
  count(*) as service_count
from normalised_knotless_services
group by style_variant
order by service_count desc;

-- 4. Count by size band
select
  size_band,
  count(*) as service_count
from normalised_knotless_services
group by size_band
order by service_count desc;

-- 5. Count by length band
select
  length_band,
  count(*) as service_count
from normalised_knotless_services
group by length_band
order by service_count desc;

-- 6. Refresh vs non-refresh
select
  is_refresh_service,
  count(*) as service_count
from normalised_knotless_services
group by is_refresh_service;

-- 7. Kids vs non-kids
select
  is_kids_service,
  count(*) as service_count
from normalised_knotless_services
group by is_kids_service;
