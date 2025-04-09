{{
    config(
        materialized='table',
        schema='warehouse'
    )
}}

WITH ventes_enrichies AS (
    SELECT
        v.vente_id,
        v.reference as vente_reference,
        v.facture_id,
        v.livre_id,
        v.quantite,
        v.prix_unitaire,
        v.date_vente,
        EXTRACT(YEAR FROM v.date_vente) as annee,
        EXTRACT(MONTH FROM v.date_vente) as mois,
        EXTRACT(DOW FROM v.date_vente) as jour_semaine,
        f.client_id,
        f.reference as facture_reference,
        f.montant_ht,
        f.montant_ttc,
        b.category_id,
        b.titre as livre_titre,
        b.prix as livre_prix_catalogue,
        c.customer_name,
        cat.intitule as categorie_nom
    FROM {{ ref('stg_ventes') }} v
    LEFT JOIN {{ ref('stg_factures') }} f ON v.facture_id = f.facture_id
    LEFT JOIN {{ ref('stg_books') }} b ON v.livre_id = b.book_id
    LEFT JOIN {{ ref('dim_customers') }} c ON f.client_id = c.customer_id
    LEFT JOIN {{ ref('stg_category') }} cat ON b.category_id = cat.id
)

SELECT 
    vente_id,
    vente_reference,
    facture_id,
    facture_reference,
    livre_id,
    livre_titre,
    livre_prix_catalogue,
    category_id,
    categorie_nom,
    client_id,
    customer_name,
    quantite,
    prix_unitaire,
    montant_ht,
    montant_ttc,
    date_vente,
    annee,
    mois,
    jour_semaine
FROM ventes_enrichies