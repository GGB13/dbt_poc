{% macro null_check(model) %}
  {% set columns = adapter.get_columns_in_relation(ref(model)) %}

  {% set null_counts = [] %}
  {% for col in columns %}
    {% set col_name = col.name %}
    {% set null_count_expr = "COUNT(CASE WHEN " ~ col_name ~ " IS NULL THEN 1 END) AS " ~ col_name ~ "_nulls" %}
    {% do null_counts.append(null_count_expr) %}
  {% endfor %}

  {% set sql %}
    SELECT
      {{ null_counts | join(",\n      ") }}
    FROM {{ ref(model) }}
  {% endset %}

  {{ return(sql) }}

{% endmacro %}
