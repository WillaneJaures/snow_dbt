{{
    config(
        materialized='table',
        schema='MARTS'
    )
}}

WITH ventes AS (
    SELECT * FROM {{ ref('fact_ventes') }}
),
factures AS (
    SELECT * FROM {{ ref('fact_factures') }}
),
category AS (
    SELECT * FROM {{ ref('dim_category') }}
),
books AS (
    SELECT * FROM {{ ref('dim_books') }}
),
customers AS (
    SELECT * FROM {{ ref('dim_customers') }}
)

SELECT
    v.vente_id,
    v.annees,
    v.mois,
    v.jour,
    v.prix_unitaire,
    v.quantite,
    f.facture_id,
    f.reference,
    f.quantite_totale,
    f.montant_ht,
    f.montant_ttc,
    c.intitule as category_intitule,
    b.code as book_code,
    b.intitule as book_intitule,
    b.isbn_10,
    b.isbn_13,
    cu.code as customer_code,
    cu.nom as customer_nom
FROM ventes v
JOIN factures f ON v.facture_id = f.facture_id
JOIN books b ON v.livre_id = b.id
JOIN category c ON b.category_id = c.id
JOIN customers cu ON f.client_id = cu.id
