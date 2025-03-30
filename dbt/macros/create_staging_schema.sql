{% macro create_staging_schema() %}
    {% set query %}
        USE ROLE ACCOUNTADMIN;
        CREATE SCHEMA IF NOT EXISTS BOOKSHOP.STAGING;
        GRANT ALL PRIVILEGES ON SCHEMA BOOKSHOP.STAGING TO ROLE ACCOUNTADMIN;
    {% endset %}
    {% do run_query(query) %}
    {% do log("Schéma STAGING créé avec succès", info=True) %}
{% endmacro %} 