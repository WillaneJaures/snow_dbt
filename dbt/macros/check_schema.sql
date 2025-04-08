{% macro check_schema(schema_name) %}
    {% set query %}
        SHOW TABLES IN SCHEMA BOOKSHOP.{{ schema_name }}
    {% endset %}
    {% set results = run_query(query) %}
    {% do results.print_table() %}
{% endmacro %} 