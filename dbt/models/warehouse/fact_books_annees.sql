{{
    config(
        materialized='table',
        schema='WAREHOUSE'
    )
}}

SELECT
    b.id as book_id,
    b.code as book_code,
    b.intitule as book_title,
    v.annees,
    COUNT(*) as nombre_ventes,
    SUM(v.qte) as quantite_totale,
    SUM(v.pu * v.qte) as montant_total
FROM {{ ref('fact_ventes') }} v
JOIN {{ ref('dim_books') }} b ON v.books_id = b.id
GROUP BY b.id, b.code, b.intitule, v.annees