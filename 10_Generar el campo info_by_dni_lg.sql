

ALTER TABLE `keepcoding.ivr_detail`
ADD COLUMN info_by_dni_lg_agregado INT64;

-- Actualizar el valor de info_by_dni_lg basado en si la llamada pasó por el step CUSTOMERINFOBYDNI.TX con resultado OK

UPDATE `keepcoding.ivr_detail` AS detail
SET info_by_dni_lg_agregado = IF(steps_has_dni_info.has_dni_info, 1, 0)
FROM (
    -- Subconsulta para verificar si la llamada pasó por el step CUSTOMERINFOBYDNI.TX y tuvo un resultado OK
    SELECT 
        steps.ivr_id,
        COUNTIF(steps.step_name = 'CUSTOMERINFOBYDNI.TX' AND steps.step_result = 'OK') > 0 AS has_dni_info
    FROM `keepcoding.ivr_steps` AS steps
    GROUP BY steps.ivr_id
) AS steps_has_dni_info
WHERE detail.calls_ivr_id = steps_has_dni_info.ivr_id;



SELECT DISTINCT calls_ivr_id, document_identification_agregacion ,info_by_dni_lg_agregado
    FROM `keepcoding.ivr_detail`
    WHERE customer_phone_agregacion IS NOT NULL  AND info_by_dni_lg_agregado >=0
