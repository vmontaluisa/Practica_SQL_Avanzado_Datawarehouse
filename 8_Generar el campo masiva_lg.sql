

ALTER TABLE `keepcoding.ivr_detail`
	ADD COLUMN masiva_lg_agregacion INT64;

-- Actualizar el valor de masiva_lg basado en si la llamada pasó por el módulo AVERIA_MASIVA
UPDATE `keepcoding.ivr_detail` AS detail
SET masiva_lg_agregacion = IF(steps_has_averia_masiva.has_averia, 1, 0)
FROM (
    -- Subconsulta para verificar si la llamada pasó por el módulo AVERIA_MASIVA
    SELECT 
        modules.ivr_id,
        COUNTIF(modules.module_name = 'AVERIA_MASIVA') > 0 AS has_averia
    FROM `keepcoding.ivr_modules` AS modules
    GROUP BY modules.ivr_id
) AS steps_has_averia_masiva
WHERE detail.calls_ivr_id = steps_has_averia_masiva.ivr_id;



SELECT DISTINCT  calls_ivr_id,customer_phone_agregacion, masiva_lg_agregacion
    FROM `keepcoding.ivr_detail`
    WHERE customer_phone_agregacion IS NOT NULL  AND masiva_lg_agregacion >=0
