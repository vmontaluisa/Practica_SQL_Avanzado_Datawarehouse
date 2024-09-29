

ALTER TABLE `keepcoding.ivr_detail`
ADD COLUMN info_by_phone_lg_agregado INT64;

-- Actualizar el valor de info_by_phone_lg basado en si la llamada pasó por el step CUSTOMERINFOBYPHONE.TX con resultado OK
UPDATE `keepcoding.ivr_detail` AS detail
SET info_by_phone_lg_agregado = IF(steps_has_phone_info.has_phone_info, 1, 0)
FROM (
    -- Subconsulta para verificar si la llamada pasó por el step CUSTOMERINFOBYPHONE.TX y tuvo un resultado OK
    SELECT 
        steps.ivr_id,
        COUNTIF(steps.step_name = 'CUSTOMERINFOBYPHONE.TX' AND steps.step_result = 'OK') > 0 AS has_phone_info
    FROM `keepcoding.ivr_steps` AS steps
    GROUP BY steps.ivr_id
) AS steps_has_phone_info
WHERE detail.calls_ivr_id = steps_has_phone_info.ivr_id;




SELECT DISTINCT  document_identification_agregacion ,customer_phone_agregacion, masiva_lg_agregacion
    FROM `keepcoding.ivr_detail`
    WHERE customer_phone_agregacion IS NOT NULL  AND masiva_lg_agregacion >=0
