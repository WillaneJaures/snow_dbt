{% macro generate_schema_name(custom_schema_name, node) %}
    {% if custom_schema_name %}
        {{ custom_schema_name | trim }}
    {% else %}
        {{ node.schema }}
    {% endif %}
{% endmacro %}
