{{
    config(
        materialized='table'
    )
}}

SELECT
    ID,
    CODE,
    INTITULE,
    ISBN_10,
    ISBN_13,
    CATEGORY_ID,
    CREATED_AT
FROM {{ source('raw', 'BOOKS') }}