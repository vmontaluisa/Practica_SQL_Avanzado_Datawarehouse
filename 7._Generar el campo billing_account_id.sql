 -- Añadir la columna billing_account_id si aún no existe
ALTER TABLE `keepcoding.ivr_detail`
ADD COLUMN billing_account_id_agregacion STRING;




-- Actualizar el valor de billing_account_id basado en los pasos del IVR
-- Aseguramos obtener un solo número de cuenta por llamada
UPDATE `keepcoding.ivr_detail` AS detail
SET billing_account_id_agregacion = first_steps.billing_account_id
FROM (
    -- Subconsulta para obtener el primer número de cuenta válido por llamada
    SELECT 
        steps.ivr_id,
        ARRAY_AGG(steps.billing_account_id ORDER BY steps.step_sequence ASC)[SAFE_OFFSET(0)] AS billing_account_id
    FROM `keepcoding.ivr_steps` AS steps
    WHERE steps.billing_account_id IS NOT NULL
    AND steps.billing_account_id != 'UNKNOWN'
    GROUP BY steps.ivr_id
) AS first_steps
WHERE detail.calls_ivr_id = first_steps.ivr_id;




SELECT DISTINCT calls_ivr_id, billing_account_id_agregacion, document_type_agregacion, document_identification_agregacion,
    FROM `keepcoding.ivr_detail`
    WHERE billing_account_id_agregacion IS NOT NULL AND document_identification_agregacion IS NOT NULL;
