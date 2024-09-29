CREATE TABLE `keepcoding.ivr_detail` AS
SELECT 
    ivr_calls.ivr_id AS calls_ivr_id,
    ivr_calls.phone_number AS calls_phone_number,
    ivr_calls.ivr_result AS calls_ivr_result,
    ivr_calls.vdn_label AS calls_vdn_label,
    ivr_calls.start_date AS calls_start_date,
    CAST(FORMAT_TIMESTAMP('%Y%m%d', ivr_calls.start_date) AS INT64) AS calls_start_date_id,
    ivr_calls.end_date AS calls_end_date,
    CAST(FORMAT_TIMESTAMP('%Y%m%d', ivr_calls.end_date) AS INT64) AS calls_end_date_id,
    ivr_calls.total_duration AS calls_total_duration,
    ivr_calls.customer_segment AS calls_customer_segment,
    ivr_calls.ivr_language AS calls_ivr_language,
    ivr_calls.steps_module AS calls_steps_module,
    ivr_calls.module_aggregation AS calls_module_aggregation,
    ivr_modules.module_sequece AS module_sequece,
    ivr_modules.module_name AS module_name,
    ivr_modules.module_duration AS module_duration,
    ivr_modules.module_result AS module_result,
    ivr_steps.step_sequence AS step_sequence,
    ivr_steps.step_name AS step_name,
    ivr_steps.step_result AS step_result,
    ivr_steps.step_description_error AS step_description_error,
    ivr_steps.document_type AS document_type,
    ivr_steps.document_identification AS document_identification,
    ivr_steps.customer_phone AS customer_phone,
    ivr_steps.billing_account_id AS billing_account_id
FROM `keepcoding.ivr_calls` AS ivr_calls
JOIN `keepcoding.ivr_modules` AS ivr_modules
ON ivr_calls.ivr_id = ivr_modules.ivr_id
JOIN `keepcoding.ivr_steps` AS ivr_steps
ON ivr_modules.ivr_id = ivr_steps.ivr_id
AND ivr_modules.module_sequece = ivr_steps.module_sequece;