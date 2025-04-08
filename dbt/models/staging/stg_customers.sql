{{
    config(
        materialized='table',
        schema='STAGGING'
    )
}}

SELECT
    ID,
    CODE,
    FIRST_NAME,
    LAST_NAME,
    CREATED_AT
FROM {{ source('raw', 'CUSTOMERS') }}
