--Agregamos otrascolumans para no afectar las originales
ALTER TABLE `keepcoding.ivr_detail`
ADD COLUMN document_type_agregacion STRING,
ADD COLUMN document_identification_agregacion STRING;




--En el archivo ivr_steps.csv, 
--ivr_id: Es el identificador único de la llamada o interacción con el sistema IVR. Este campo permite relacionar los pasos con la llamada correspondiente en otras tablas como ivr_calls 
--step_sequence: Es el número de secuencia del paso dentro de un módulo específico.
-- Actualizar los valores de document_type_agregacion y document_identification_agregacion
-- Basados en los pasos del IVR donde esté disponible la información del cliente
-- Nos aseguramos de identificar solo un cliente por llamada

--NOTA: No se permite esta sentencia , porlo cual se uso el formato final para llenar las columnas   
--		FROM `keepcoding.ivr_steps` AS steps
--    	WHERE detail.calls_ivr_id = steps.ivr_id

UPDATE `keepcoding.ivr_detail` AS detail
SET document_type_agregacion = first_steps.document_type,
    document_identification_agregacion = first_steps.document_identification
FROM (
    -- Subconsulta para obtener el primer documento válido por llamada
    SELECT 
        steps.ivr_id,
        ARRAY_AGG(steps.document_type ORDER BY steps.step_sequence ASC)[SAFE_OFFSET(0)] AS document_type,
        ARRAY_AGG(steps.document_identification ORDER BY steps.step_sequence ASC)[SAFE_OFFSET(0)] AS document_identification
    FROM `keepcoding.ivr_steps` AS steps
    WHERE steps.document_identification != 'UNKNOWN'
    GROUP BY steps.ivr_id
) AS first_steps
WHERE detail.calls_ivr_id = first_steps.ivr_id;


-- La consulta final para obtener tener un registro por cada llamada y un sólo cliente identificado para la misma es 
SELECT DISTINCT  calls_ivr_id,document_type_agregacion, document_identification_agregacion,
 FROM `keepcoding.ivr_detail`
 WHERE document_identification_agregacion IS NOT NULL ;
