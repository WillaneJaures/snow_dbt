
  
    

        create or replace transient table BOOKSHOP.STAGING_STAGGING.stg_category
         as
        (

SELECT
    id,
    code,
    intitule,
    created_at
FROM BOOKSHOP.RAW.CATEGORY
        );
      
  