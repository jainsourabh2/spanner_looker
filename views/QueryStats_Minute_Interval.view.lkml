view: QueryStats_Minute_Interval {
  sql_table_name: `spanner_sys.query_stats_top_minute`
    ;;

  # dimension: all_failed_execution_count {
  #   type: number
  #   sql: ${TABLE}.all_failed_execution_count ;;
  # }

  measure: avg_bytes {
    type: number
    label: "Average Bytes"
    sql: SUM(${TABLE}.avg_bytes)/SUM(${TABLE}.execution_count) ;;
    value_format: "0.00"
  }

  dimension: average_cpu_seconds {
    type: number
    label: "Average CPU Seconds"
    sql: ${TABLE}.avg_cpu_seconds ;;
    value_format: "0.00"
  }

  dimension: average_cpu_seconds_tier {
    type: tier
    tiers: [0.1,0.2,0.3,0.45,0.6,0.75,1]
    style: relational
    label: "Average CPU Seconds Tier"
    sql: ${TABLE}.avg_cpu_seconds ;;
    value_format: "0.00"
  }

  dimension: average_latency_seconds {
    type: number
    label: "Average Latency Seconds"
    sql: ${TABLE}.avg_latency_seconds ;;
    value_format: "0.00"

  }

  dimension: average_latency_seconds_tier {
    type: tier
    tiers: [0.1,0.2,0.3,0.45,0.6,0.75,1]
    style: relational
    label: "Average Latency Seconds Tier"
    sql: ${TABLE}.avg_latency_seconds ;;
    value_format: "0.00"
  }

  measure: avg_cpu_seconds {
    type: average
    label: "Average CPU Seconds"
    sql: ${TABLE}.avg_cpu_seconds ;;
    value_format: "0.00"
  }

  measure: avg_latency_seconds {
    type: average
    label: "Average Latency Seconds"
    sql: ${TABLE}.avg_latency_seconds ;;
    value_format: "0.00"
    drill_fields: [interval_end_time,text,avg_bytes,avg_cpu_seconds,avg_latency_seconds,avg_rows,avg_rows_scanned]

    # drill_fields: [avg_latency_seconds, interval_end_time, all_failed_avg_latency_seconds]

    # #html: {{ rendered_value }} || {{ percent_of_total_gm._rendered_value }} of total>> ;;  ## here we use || to concatenate the values

    # link: {
    #   label: "Drill into {{ text }} "
    #   #% assign vis_config = '@vis_config_for_avg_latency' %}
    #   #/explore/d11-spanner-monitoring/query_stats_top_minute?fields=query_stats_top_minute.avg_latency_seconds,query_stats_top_minute.interval_end_time,query_stats_top_minute.all_failed_avg_latency_seconds&f[query_stats_top_minute.text]={{ text | url_encode}}&vis_config={{ vis_config | encode_uri }}&sorts=query_stats_top_minute.interval_end_time desc&limit=500&query_timezone=UTC"}
    #   url: "
    #   {% assign vis_config = '{

    #   \"x_axis_gridlines\":true,
    #   \"y_axis_gridlines\":true,
    #   \"show_view_names\":false,
    #   \"show_y_axis_labels\":true,
    #   \"show_y_axis_ticks\":true,
    #   \"y_axis_tick_density\":\"default\",
    #   \"y_axis_tick_density_custom\":5,
    #   \"show_x_axis_label\":false,
    #   \"show_x_axis_ticks\":true,
    #   \"y_axis_scale_mode\":\"linear\",
    #   \"x_axis_reversed\":false,
    #   \"y_axis_reversed\":false,
    #   \"plot_size_by_field\":false,
    #   \"trellis\":\"\",
    #   \"stacking\":\"\",
    #   \"limit_displayed_rows\":false,
    #   \"legend_position\":\"center\",
    #   \"point_style\":\"circle\",
    #   \"show_value_labels\":false,
    #   \"label_density\":25,
    #   \"x_axis_scale\":\"auto\",
    #   \"y_axis_combined\":true,
    #   \"show_null_points\":true,
    #   \"size_by_field\":\"query_stats_top_minute.all_failed_avg_latency_seconds\",
    #   \"ordering\":\"none\",
    #   \"show_sql_query_menu_options\":false,
    #   \"show_totals\":true,\"show_row_totals\":true,
    #   \"show_null_labels\":false,
    #   \"show_totals_labels\":false,
    #   \"show_silhouette\":false,
    #   \"totals_color\":\"#808080\",
    #   \"type\":\"looker_scatter\",
    #   \"interpolation\":\"linear\",
    #   \"series_types\":{},\"colors\":[\"palette: Santa Cruz\"],
    #   \"series_colors\":{},
    #   \"x_axis_datetime_tick_count\":null,
    #   \"trend_lines\":[{\"color\":\"#000000\",
    #   \"label_position\":\"left\",\"period\":30,
    #   \"regression_type\":\"average\",
    #   \"series_index\":1,
    #   \"show_label\":true,
    #   \"label_type\":\"string\",
    #   \"label\":\" \",\"defaults_version\":1}],
    #   \"defaults_version\":1
    #   }' %}
    # {{ link }}&vis_config={{ vis_config | encode_uri }}"}
  }

  measure: avg_all_failed_average_latency_seconds {
    type: number
    label: "Average All failed Average Latency Seconds"
    sql: ${TABLE}.all_failed_avg_latency_seconds ;;
    value_format: "0.00"
  }

  measure: avg_rows {
    type: average
    label: "Average Rows"
    sql: ${TABLE}.avg_rows ;;
    value_format: "0.00"
  }

  measure: avg_rows_scanned {
    type: average
    label: "Average Rows Scanned"
    sql: ${TABLE}.avg_rows_scanned ;;
    value_format: "0.00"
  }

  measure: cancelled_or_disconnected_execution_count {
    type: sum
    sql: ${TABLE}.cancelled_or_disconnected_execution_count ;;
  }

  # dimension: execution_count {
  #   type: number
  #   sql: ${TABLE}.execution_count ;;
  # }

  dimension_group: interval_end {
    type: time
    timeframes: [
      raw,
      time,
      minute3,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.interval_end ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.text ;;
    action: {
      label: "Fetch Query Plan"
      url: "https://example.com/ping/{{ value }}"
      form_url: "https://example.com/ping/{{ value }}/form.json"
    }

  }

  dimension: all_failed_avg_latency_seconds {
    type: number
    sql: ${TABLE}.all_failed_avg_latency_seconds ;;
  }

  dimension: text_fingerprint {
    type: number
    sql: ${TABLE}.text_fingerprint ;;
  }

  dimension: text_truncated {
    type: yesno
    sql: ${TABLE}.text_truncated ;;
  }

  measure: timed_out_execution_count {
    type: sum
    sql: ${TABLE}.timed_out_execution_count ;;
  }

  measure: failed_execution_count {
    type: sum
    label: "Failed Execution Count"
    sql: ${TABLE}.all_failed_execution_count ;;
    drill_fields: [interval_end_time,text,avg_bytes,avg_cpu_seconds,avg_latency_seconds,avg_rows,avg_rows_scanned]
  }

  measure: count {
    type: sum
    label: "Total Execution Count"
    sql: ${TABLE}.execution_count ;;
    drill_fields: [interval_end_time,text,avg_bytes,avg_cpu_seconds,avg_latency_seconds,avg_rows,avg_rows_scanned]
  }

  measure: percentaage_failed_execution_count {
    type: number
    label: "Failed Execution Percentage"
    sql: SUM(${TABLE}.all_failed_execution_count)/SUM(${TABLE}.execution_count)*100 ;;
    drill_fields: []
    value_format: "0.00%"
  }

  measure: total_records {
    type: count
    label: "Total Records"
  }


}
