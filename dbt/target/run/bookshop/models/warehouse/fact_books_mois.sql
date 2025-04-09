
  
    

        create or replace transient table BOOKSHOP.STAGING_WAREHOUSE.fact_books_mois
         as
        (

SELECT
    b.id as book_id,
    b.code as book_code,
    b.intitule as book_title,
    v.annees,
    v.mois,
    COUNT(*) as nombre_ventes,
    SUM(v.quantite) as quantite_totale,
    SUM(v.prix_unitaire * v.quantite) as montant_total
FROM BOOKSHOP.STAGING_WAREHOUSE.fact_ventes v
JOIN BOOKSHOP.STAGING_WAREHOUSE.dim_books b ON v.livre_id = b.id
GROUP BY b.id, b.code, b.intitule, v.annees, v.mois
        );
      
  