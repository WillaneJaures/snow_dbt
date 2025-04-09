{{
    config(
        materialized='table',
        schema='STAGGING'
    )
}}

SELECT
    id,
    code,
    intitule,
    created_at
FROM {{ source('raw', 'CATEGORY') }}