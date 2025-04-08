{% macro show_tables(schema) %}

{% set query %}
    SHOW TABLES IN {{ schema }};
{% endset %}

{% do run_query(query) %}

{% endmacro %} 