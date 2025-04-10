{{
    config(
        materialized='table',
    )
}}

SELECT
    ID,
    INTITULE,
    CREATED_AT
FROM {{ source('raw', 'CATEGORY') }}
