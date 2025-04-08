{% macro list_tables() %}
    {% set query %}
        SHOW TABLES IN BOOKSHOP.RAW;
    {% endset %}
    {% do run_query(query) %}
{% endmacro %} 