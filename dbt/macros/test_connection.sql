{% macro test_connection() %}
    {% set query %}
        SELECT CURRENT_USER() as USER, 
               CURRENT_ROLE() as ROLE,
               CURRENT_DATABASE() as DATABASE,
               CURRENT_WAREHOUSE() as WAREHOUSE,
               CURRENT_SCHEMA() as SCHEMA;
    {% endset %}
    {% set results = run_query(query) %}
    {% do results.print_table() %}
{% endmacro %} 