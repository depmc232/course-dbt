{# This function applies an aggregate operation to an event_type #}
{% macro agg_events(event_type, agg) %} 

{{agg}}(case when event_type='{{event_type}}' then 1 else 0 end) 

{% endmacro %} 