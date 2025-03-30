{% macro check_table() %}

{% set query %}
    USE ROLE ACCOUNTADMIN;
    USE DATABASE BOOKSHOP;
    USE SCHEMA STAGGING;
    SELECT * FROM TEST_TABLE;
{% endset %}

{% set results = run_query(query) %}
{% do results.print_table() %}

{% endmacro %} 