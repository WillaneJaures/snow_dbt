{{
    config(
        materialized='table',
        schema='WAREHOUSE'
    )
}}

SELECT
    id,
    intitule,
    created_at
FROM {{ ref('stg_category') }}