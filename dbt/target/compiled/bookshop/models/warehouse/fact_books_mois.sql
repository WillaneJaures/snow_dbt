

SELECT
    b.id as book_id,
    b.code as book_code,
    b.intitule as book_title,
    v.annees,
    v.mois,
    COUNT(*) as nombre_ventes,
    SUM(v.quantite) as quantite_totale,
    SUM(v.prix_unitaire * v.quantite) as montant_total
FROM BOOKSHOP.WAREHOUSE.fact_ventes v
JOIN BOOKSHOP.WAREHOUSE.dim_books b ON v.livre_id = b.id
GROUP BY b.id, b.code, b.intitule, v.annees, v.mois