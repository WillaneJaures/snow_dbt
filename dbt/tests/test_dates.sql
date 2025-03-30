-- Test du format des dates
SELECT 
    id,
    date_edit
FROM {{ source('raw', 'VENTES') }}
WHERE date_edit NOT REGEXP '^[0-9]{8}$'
   OR date_edit IS NULL;

SELECT 
    id,
    date_edit
FROM {{ source('raw', 'FACTURES') }}
WHERE date_edit NOT REGEXP '^[0-9]{8}$'
   OR date_edit IS NULL; 