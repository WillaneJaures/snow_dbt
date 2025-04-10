{{
    config(
        materialized='table',
    )
}}

SELECT
    vente_id,
    reference,
    date_vente,
    EXTRACT(YEAR FROM date_vente) as annees,
    CASE EXTRACT(MONTH FROM date_vente)
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
    CASE EXTRACT(DOW FROM date_vente)
        WHEN 0 THEN 'dimanche'
        WHEN 1 THEN 'lundi'
        WHEN 2 THEN 'mardi'
        WHEN 3 THEN 'mercredi'
        WHEN 4 THEN 'jeudi'
        WHEN 5 THEN 'vendredi'
        WHEN 6 THEN 'samedi'
    END as jour,
    facture_id,
    livre_id,
    prix_unitaire,
    quantite,
    created_at
FROM {{ ref('stg_ventes') }}
