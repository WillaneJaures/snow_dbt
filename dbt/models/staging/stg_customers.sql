{{
    config(
        materialized='table',
        schema='STAGGING'
    )
}}

SELECT
    id,
    code,
    first_name,
    last_name,
    email,
    created_at
FROM {{ source('raw', 'CUSTOMERS') }}