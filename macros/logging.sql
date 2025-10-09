{% macro log_info(message) %}
  {{ log(message, info=True) }}
{% endmacro %}
