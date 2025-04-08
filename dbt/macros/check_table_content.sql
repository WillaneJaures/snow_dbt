{% macro check_table_content(table_name) %}
    {% set query %}
        USE ROLE ACCOUNTADMIN;
        USE DATABASE BOOKSHOP;
        USE SCHEMA RAW;
        SELECT * FROM RAW.{{ table_name }} LIMIT 1;
    {% endset %}
    {% set results = run_query(query) %}
    {% do results.print_table() %}
{% endmacro %} 