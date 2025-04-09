
  
    

        create or replace transient table BOOKSHOP.STAGING_STAGGING.stg_customers
         as
        (

SELECT
    id,
    code,
    first_name,
    last_name,
    email,
    created_at
FROM BOOKSHOP.RAW.CUSTOMERS
        );
      
  