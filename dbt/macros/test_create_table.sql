{% macro test_create_table() %}

{% set query %}
    USE ROLE ACCOUNTADMIN;
    USE DATABASE BOOKSHOP;
    USE SCHEMA STAGGING;
    CREATE OR REPLACE TABLE TEST_TABLE AS
    SELECT * FROM BOOKSHOP.RAW.VENTES LIMIT 1;
{% endset %}

{% do run_query(query) %}

{% endmacro %} 