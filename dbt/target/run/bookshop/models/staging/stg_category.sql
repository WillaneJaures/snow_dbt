
  
    

        create or replace transient table BOOKSHOP.STAGING_STAGGING.stg_category
         as
        (

SELECT
    ID,
    INTITULE,
    CREATED_AT
FROM BOOKSHOP.RAW.CATEGORY
        );
      
  