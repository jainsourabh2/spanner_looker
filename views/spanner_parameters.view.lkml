view: spanner_parameters {
  sql_table_name: `dr-poc-305406.spanner_sys.spanner_parameters`
    ;;

  dimension: metric_name {
    type: string
    sql: ${TABLE}.metricName ;;
  }

  dimension: keyvalue {
    type: number
    sql: ${TABLE}.keyvalue ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      minute,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_time ;;
  }

  measure: node_count {
    type:  number
    sql:  MAX(${keyvalue}) OVER (ORDER BY ${end_time} DESC) ;;
    drill_fields: [end_time,total_attribute]
    # link: {
    #   label: "Drill as scatter plot"
    #   url: "
    #   {% assign vis_config = '{\"type\": \"looker_scatter\"}' %}
    #   {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    # }
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{
      \"stacking\" : \"\",
      \"show_value_labels\" : false,
      \"label_density\" : 25,
      \"legend_position\" : \"center\",
      \"x_axis_gridlines\" : true,
      \"y_axis_gridlines\" : true,
      \"show_view_names\" : false,
      \"limit_displayed_rows\" : false,
      \"y_axis_combined\" : true,
      \"show_y_axis_labels\" : true,
      \"show_y_axis_ticks\" : true,
      \"y_axis_tick_density\" : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\" : false,
      \"show_x_axis_ticks\" : true,
      \"x_axis_scale\" : \"auto\",
      \"y_axis_scale_mode\" : \"linear\",
      \"show_null_points\" : true,
      \"point_style\" : \"circle\",
      \"ordering\" : \"none\",
      \"show_null_labels\" : false,
      \"show_totals_labels\" : false,
      \"show_silhouette\" : false,
      \"totals_color\" : \"#808080\",
      \"type\" : \"looker_line\",
      \"interpolation\" : \"linear\",
      \"series_types\" : {},
      \"colors\": [
      \"palette: Santa Cruz\"
      ],
      \"series_colors\" : {},
      \"x_axis_datetime_tick_count\": null,
      \"trend_lines\": [
      {
      \"color\" : \"#000000\",
      \"label_position\" : \"left\",
      \"regression_type\" : \"average\",
      \"series_index\" : 1,
      \"show_label\" : true,
      \"label_type\" : \"string\",
      \"label\" : \"30 day moving average\"
      }
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: spanner_node {
    type: number
    sql: ${TABLE}.keyvalue ;;
  }

  measure: instance_cpu_utilization {
    type: average
    sql: ${TABLE}.keyvalue ;;
    drill_fields: [end_time,total_attribute]
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{\"type\": \"looker_line\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: instance_cpu_utilization_priority {
    type: average
    sql: ${TABLE}.keyvalue ;;
    drill_fields: [end_time,total_attribute]
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{\"type\": \"looker_line\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: avg_bytes_used {
    type: average
    sql: ${TABLE}.keyvalue/1024/1024/1024 ;;
    drill_fields: [end_time,total_attribute]
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{\"type\": \"looker_line\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_api_read_errors {
    type: sum
    sql: ${TABLE}.keyvalue ;;
    drill_fields: [end_time,total_attribute]
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{\"type\": \"looker_line\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_api_write_errors {
    type: sum
    sql: ${TABLE}.keyvalue ;;
    drill_fields: [end_time,total_attribute]
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{\"type\": \"looker_line\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: total_attribute {
    type: sum
    sql: ${TABLE}.keyvalue ;;
  }

  measure: request_read_latencies {
    type: average
    sql: ${TABLE}.keyvalue * 1000 ;;
    drill_fields: [end_time,total_attribute]
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{\"type\": \"looker_line\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: request_write_latencies {
    type: average
    sql: ${TABLE}.keyvalue * 1000 ;;
    drill_fields: [end_time,total_attribute]
    link: {
      label: "Analyze Trend"
      url: "
      {% assign vis_config = '{\"type\": \"looker_line\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }
  }

  measure: count {
    type: count
    drill_fields: [metric_name]
  }
}
