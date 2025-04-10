{{
    config(
        materialized='table',
    )
}}

SELECT
    id,
    category_id,
    code,
    intitule,
    isbn_10,
    isbn_13,
    created_at
FROM {{ ref('stg_books') }}
