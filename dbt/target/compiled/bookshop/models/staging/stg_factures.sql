

SELECT
    id::INTEGER as facture_id,
    code::VARCHAR(50) as reference,
    customer_id::INTEGER as client_id,
    qte_totale::DECIMAL(10,2) as quantite_totale,
    total_amount::DECIMAL(12,2) as montant_ht,
    total_paid::DECIMAL(12,2) as montant_ttc,
    TO_DATE(date_edit, 'YYYYMMDD')::DATE as date_facturation,
    created_at::TIMESTAMP as created_at
FROM BOOKSHOP.RAW.FACTURES