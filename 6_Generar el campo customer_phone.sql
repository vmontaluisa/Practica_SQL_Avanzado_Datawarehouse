 --Agregamos otrascolumans para no afectar las originales
ALTER TABLE `keepcoding.ivr_detail`
ADD COLUMN customer_phone_agregacion STRING;


--En el archivo ivr_steps.csv, 
--ivr_id: Es el identificador único de la llamada o interacción con el sistema IVR. Este campo permite relacionar los pasos con la llamada correspondiente en otras tablas como ivr_calls 
--step_sequence: Es el número de secuencia del paso dentro de un módulo específico.
-- Actualizar los valores de document_type_agregacion y document_identification_agregacion
-- Basados en los pasos del IVR donde esté disponible la información del cliente

UPDATE `keepcoding.ivr_detail` AS detail
SET customer_phone_agregacion = first_steps.customer_phone
FROM (
    -- Subconsulta para obtener el primer documento válido por llamada
    SELECT 
        steps.ivr_id,
       ARRAY_AGG(steps.customer_phone ORDER BY steps.step_sequence ASC)[SAFE_OFFSET(0)] AS customer_phone
     FROM `keepcoding.ivr_steps` AS steps
   	 WHERE steps.customer_phone IS NOT NULL
    	AND steps.customer_phone != 'UNKNOWN'
    GROUP BY steps.ivr_id
) AS first_steps
WHERE detail.calls_ivr_id = first_steps.ivr_id;

-- La consulta final para obtener tener un registro por cada llamada y un sólo cliente identificado para la misma es 

SELECT DISTINCT  calls_ivr_id,customer_phone_agregacion, document_type_agregacion, document_identification_agregacion,
    FROM `keepcoding.ivr_detail`
    WHERE customer_phone_agregacion IS NOT NULL  AND document_identification_agregacion IS NOT NULL