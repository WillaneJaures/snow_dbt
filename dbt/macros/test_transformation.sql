{% macro test_date_transformation(date_string) %}
    {% set query %}
        SELECT 
            TO_DATE({{ date_string }}, 'YYYYMMDD') as converted_date
    {% endset %}
    {% set results = run_query(query) %}
    {% do results.print_table() %}
{% endmacro %} 