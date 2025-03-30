{% macro test_query() %}

{% set query %}
    USE DATABASE BOOKSHOP;
    USE SCHEMA RAW;
    SELECT * FROM VENTES LIMIT 1;
{% endset %}

{% set results = run_query(query) %}
{% do results.print_table() %}

{% endmacro %} 