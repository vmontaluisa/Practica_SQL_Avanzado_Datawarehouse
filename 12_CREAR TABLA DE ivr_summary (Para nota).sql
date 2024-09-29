

CREATE OR REPLACE TABLE `keepcoding.ivr_summary` AS
SELECT DISTINCT
    calls_ivr_id AS ivr_id,                         -- Identificador de la llamada
    customer_phone_agregacion AS phone_number,             -- Número llamante
    calls_ivr_result AS ivr_result,                 -- Resultado de la llamada
    vdn_aggregation,                                -- Calculado anteriormente (vdn_label)
    calls_start_date AS start_date,                 -- Fecha inicio de la llamada
    calls_end_date AS end_date,                     -- Fecha fin de la llamada
    calls_total_duration AS total_duration,         -- Duración de la llamada
    calls_customer_segment AS customer_segment,     -- Segmento del cliente
    calls_ivr_language AS ivr_language,             -- Idioma de la IVR
    calls_steps_module AS steps_module,             -- Número de módulos por los que pasa la llamada
    vdn_aggregation AS module_aggregation, -- Lista de módulos por los que pasa la llamada
    document_type_agregacion AS document_type,      -- Calculado anteriormente (tipo de documento)
    document_identification_agregacion AS document_identification, -- Calculado anteriormente (identificación del documento)
    customer_phone_agregacion AS customer_phone,                                 -- Calculado anteriormente (número de teléfono del cliente)
    billing_account_id_agregacion AS billing_account_id,                             -- Calculado anteriormente (número de cuenta de facturación)
    masiva_lg_agregacion AS masiva_lg,                                      -- Calculado anteriormente (flag de avería masiva)
    info_by_phone_lg_agregado AS info_by_phone_lg,                               -- Calculado anteriormente (flag de identificación por teléfono)
    info_by_dni_lg_agregado AS info_by_dni_lg,                                 -- Calculado anteriormente (flag de identificación por DNI)
    repeated_phone_24H_agregado AS repeated_phone_24H, -- Calculado anteriormente (flag de llamada repetida en 24H)
    cause_recall_phone_24H_agregado   AS cause_recall_phone_24H                       -- Calculado anteriormente (flag de llamada siguiente en 24H)
FROM `keepcoding.ivr_detail`


