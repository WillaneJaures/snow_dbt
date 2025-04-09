

SELECT
    id::INTEGER as vente_id,
    code::VARCHAR(50) as reference,
    facture_id::INTEGER as facture_id,
    book_id::INTEGER as livre_id,
    qte::INTEGER as quantite,
    pu::DECIMAL(10,2) as prix_unitaire,
    TO_DATE(date_edit, 'YYYYMMDD')::DATE as date_vente,
    created_at::TIMESTAMP as created_at
FROM BOOKSHOP.RAW.VENTES