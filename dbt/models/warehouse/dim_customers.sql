{{
    config(
        materialized='table',
        schema='warehouse'
    )
}}

SELECT
    id as customer_id,
    code as customer_code,
    first_name || ' ' || last_name as customer_name,
    email as customer_email,
    created_at
FROM {{ ref('stg_customers') }}