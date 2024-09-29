ALTER TABLE `keepcoding.ivr_detail` ADD COLUMN vdn_aggregation STRING;

UPDATE `keepcoding.ivr_detail`
SET vdn_aggregation = CASE
    WHEN calls_vdn_label LIKE 'ATC%' THEN 'FRONT'
    WHEN calls_vdn_label LIKE 'TECH%' THEN 'TECH'
    WHEN calls_vdn_label = 'ABSORPTION' THEN 'ABSORPTION'
    ELSE 'RESTO'
END
WHERE 1=1
;
