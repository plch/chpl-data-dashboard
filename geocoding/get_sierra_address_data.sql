select
r.record_num,
r.id,
date(r.creation_date_gmt) as creation_date,
date(r.record_last_updated_gmt) as record_last_updated_date,
p.ptype_code,
p.home_library_code,
p.expiration_date_gmt,
p.birth_date_gmt,
p.checkout_total,
p.renewal_total,
p.activity_gmt,
(
	SELECT
	a.addr1
	from
	sierra_view.patron_record_address as a
	where
	a.patron_record_id = r.id

	order by
	display_order,
	patron_record_address_type_id

	limit 1
) as addr1,
(
	SELECT
	a.addr2
	from
	sierra_view.patron_record_address as a
	where
	a.patron_record_id = r.id

	order by
	display_order,
	patron_record_address_type_id

	limit 1
) as addr2,

(
	SELECT
	a.city
	from
	sierra_view.patron_record_address as a
	where
	a.patron_record_id = r.id

	order by
	display_order,
	patron_record_address_type_id

	limit 1
) as city,
(
	SELECT
	a.region
	from
	sierra_view.patron_record_address as a
	where
	a.patron_record_id = r.id

	order by
	display_order,
	patron_record_address_type_id

	limit 1
) as state,
(
	SELECT
	a.postal_code
	from
	sierra_view.patron_record_address as a
	where
	a.patron_record_id = r.id

	order by
	display_order,
	patron_record_address_type_id

	limit 1
) as postal_code

from
sierra_view.record_metadata as r

JOIN
sierra_view.patron_record as p
ON
  p.record_id = r.id

where
r.record_type_code = 'p'
and r.campus_code = ''
and r.deletion_date_gmt is null