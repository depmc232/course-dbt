{# This function applies an aggregate operation to an event_type #}
{% macro agg_events(event_type, agg_op) %} 
  {{ agg_op }}(CASE WHEN event_type = '{{ event_type }}' THEN 1 ELSE 0 END)
{% endmacro %}