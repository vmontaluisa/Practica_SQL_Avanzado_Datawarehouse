-- Añadir las columnas repeated_phone_24H y cause_recall_phone_24H 
ALTER TABLE `keepcoding.ivr_detail`
ADD COLUMN repeated_phone_24H_agregado INT64,
ADD COLUMN cause_recall_phone_24H_agregado INT64;







UPDATE `keepcoding.ivr_detail` AS detail 
SET repeated_phone_24H_agregado =NULL
WHERE 1=1;

UPDATE `keepcoding.ivr_detail` AS detail 
SET cause_recall_phone_24H_agregado =NULL
WHERE 1=1;



UPDATE `keepcoding.ivr_detail`
SET repeated_phone_24H_agregado = IF(
    EXISTS (
        SELECT 1
        FROM `keepcoding.ivr_detail` AS previous
        WHERE previous.customer_phone_agregacion = `keepcoding.ivr_detail`.customer_phone_agregacion
        AND TIMESTAMP_DIFF(`keepcoding.ivr_detail`.calls_start_date, previous.calls_start_date, HOUR) <= 24
        AND TIMESTAMP_DIFF(`keepcoding.ivr_detail`.calls_start_date, previous.calls_start_date, HOUR) >= 0
        AND previous.calls_ivr_id != `keepcoding.ivr_detail`.calls_ivr_id
    ), 1, 0
)
WHERE  customer_phone_agregacion IS NOT NULL;


UPDATE `keepcoding.ivr_detail`
SET cause_recall_phone_24H_agregado = IF(
    EXISTS (
        SELECT 1
        FROM `keepcoding.ivr_detail` AS previous
        WHERE previous.customer_phone_agregacion = `keepcoding.ivr_detail`.customer_phone_agregacion
        AND TIMESTAMP_DIFF(`keepcoding.ivr_detail`.calls_end_date, previous.calls_end_date, HOUR) >= 24
        AND previous.calls_ivr_id != `keepcoding.ivr_detail`.calls_ivr_id
    ), 1, 0
)
WHERE  customer_phone_agregacion IS NOT NULL;






