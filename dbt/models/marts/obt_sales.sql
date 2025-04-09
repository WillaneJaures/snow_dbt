{{
    config(
        materialized='table',
        schema='marts'
    )
}}

WITH sales_enriched AS (
    SELECT
        v.vente_id,
        v.facture_id,
        v.livre_id,
        v.client_id,
        v.category_id,
        v.date_vente,
        EXTRACT(YEAR FROM v.date_vente) as annee,
        CASE EXTRACT(MONTH FROM v.date_vente)
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
        CASE EXTRACT(DOW FROM v.date_vente)
            WHEN 0 THEN 'dimanche'
            WHEN 1 THEN 'lundi'
            WHEN 2 THEN 'mardi'
            WHEN 3 THEN 'mercredi'
            WHEN 4 THEN 'jeudi'
            WHEN 5 THEN 'vendredi'
            WHEN 6 THEN 'samedi'
        END as jour,
        v.quantite,
        v.prix_unitaire,
        v.montant_ht,
        v.montant_ttc,
        v.livre_titre,
        v.livre_prix_catalogue,
        v.categorie_nom,
        v.customer_name,
        v.quantite * v.prix_unitaire as montant_vente
    FROM {{ ref('fact_ventes') }} v
)

SELECT
    vente_id,
    facture_id,
    livre_id,
    client_id,
    category_id,
    date_vente,
    annee,
    mois,
    jour,
    quantite,
    prix_unitaire,
    montant_ht,
    montant_ttc,
    livre_titre,
    livre_prix_catalogue,
    categorie_nom,
    customer_name,
    montant_vente
FROM sales_enriched