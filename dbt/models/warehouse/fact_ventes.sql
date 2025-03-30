{{
    config(
        materialized='table',
        schema='WAREHOUSE'
    )
}}

WITH source AS (
    SELECT * FROM {{ ref('stg_ventes') }}
)

SELECT
    id,
    code,
    date_edit,
    EXTRACT(YEAR FROM date_edit) as annees,
    CASE EXTRACT(MONTH FROM date_edit)
        WHEN 1 THEN 'janvier'
        WHEN 2 THEN 'fevrier'
        WHEN 3 THEN 'mars'
        WHEN 4 THEN 'avril'
        WHEN 5 THEN 'mai'
        WHEN 6 THEN 'juin'
        WHEN 7 THEN 'juillet'
        WHEN 8 THEN 'aout'
        WHEN 9 THEN 'septembre'
        WHEN 10 THEN 'octobre'
        WHEN 11 THEN 'novembre'
        WHEN 12 THEN 'decembre'
    END as mois,
    CASE EXTRACT(DOW FROM date_edit)
        WHEN 0 THEN 'dimanche'
        WHEN 1 THEN 'lundi'
        WHEN 2 THEN 'mardi'
        WHEN 3 THEN 'mercredi'
        WHEN 4 THEN 'jeudi'
        WHEN 5 THEN 'vendredi'
        WHEN 6 THEN 'samedi'
    END as jour,
    factures_id,
    books_id,
    pu,
    qte,
    created_at
FROM source