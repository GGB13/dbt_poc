{% macro days_between(date1, date2) %}
  date_diff('day', {{ date1 }}, {{ date2 }})
{% endmacro %}
