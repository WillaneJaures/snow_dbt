-- Test des relations entre les tables
SELECT 
    v.id as vente_id,
    v.factures_id,
    v.books_id,
    f.id as facture_id,
    b.id as book_id
FROM {{ source('raw', 'VENTES') }} v
LEFT JOIN {{ source('raw', 'FACTURES') }} f ON v.factures_id = f.id
LEFT JOIN {{ source('raw', 'BOOKS') }} b ON v.books_id = b.id
WHERE f.id IS NULL OR b.id IS NULL 