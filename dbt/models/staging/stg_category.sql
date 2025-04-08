{{
    config(
        materialized='table',
        schema='STAGGING'
    )
}}

SELECT
    ID,
    INTITULE,
    CREATED_AT
FROM {{ source('raw', 'CATEGORY') }}
