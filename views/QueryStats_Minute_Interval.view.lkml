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

    # #html: {{ rendered_value }} || {{ percent_of_total_gm._rendered_value }} of total>> ;;  ## here we use || to concatenate the values

    # link: {
    #   label: "See as custom viz (heatmap)"
    #   url: "
    #   {% assign vis_config = '{
    #   \"minColor\" : \"#d6d6d6\",
    #   \"maxColor\" : \"#9a33e3\",
    #   \"dataLabels\" : false,
    #   \"custom_color_enabled\" : false,
    #   \"custom_color\" : \"forestgreen\",
    #   \"show_single_value_title\": true,
    #   \"show_comparison\" : false,
    #   \"comparison_type\" : \"value\",
    #   \"comparison_reverse_colors\": false,
    #   \"show_comparison_label\" : true,
    #   \"show_view_names\" : true,
    #   \"show_row_numbers\" : true,
    #   \"truncate_column_names\" : false,
    #   \"hide_totals\" : false,
    #   \"hide_row_totals\" : false,
    #   \"table_theme\" : \"editable\",
    #   \"limit_displayed_rows\" : false,
    #   \"enable_conditional_formatting\": false,
    #   \"conditional_formatting_include_totals\": false,
    #   \"conditional_formatting_include_nulls\": false,
    #   \"type\" : \"highcharts_heatmap\",
    #   \"stacking\" : \"\",
    #   \"show_value_labels\" : false,
    #   \"label_density\" : 25,
    #   \"legend_position\" : \"center\",
    #   \"x_axis_gridlines\" : false,
    #   \"y_axis_gridlines\" : true,
    #   \"y_axis_combined\" : true,
    #   \"show_y_axis_labels\" : true,
    #   \"show_y_axis_ticks\" : true,
    #   \"y_axis_tick_density\" : \"default\",
    #   \"y_axis_tick_density_custom\": 5,
    #   \"show_x_axis_label\" : true,
    #   \"show_x_axis_ticks\" : true,
    #   \"x_axis_scale\" : \"auto\",
    #   \"y_axis_scale_mode\" : \"linear\",
    #   \"ordering\" : \"none\",
    #   \"show_null_labels\" : false,
    #   \"show_totals_labels\" : false,
    #   \"show_silhouette\" : false,
    #   \"totals_color\" : \"#808080\",
    #   \"series_types\" : {},
    #   \"hidden_fields\" : [
    #   \"order_items.count\",
    #   \"order_items.total_sale_price\"
    #   ]
    #   }' %}
    #   {{ link }}&vis_config={{ vis_config | encode_uri }}&sorts=interval_end_time+asc,avg_latency_seconds+asc&toggle=dat,pik,vis&limit=5000"
    # }
  }

  measure: avg_all_failed_average_latency_seconds {
    type: average
    label: "Average All failed Average Latency Seconds"
    sql: ${TABLE}.all_failed_avg_latency_seconds ;;
    value_format: "0.00"
  }

  measure: avg_rows {
    type: average
    label: "Average Rows Returned"
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
    # action: {
    #   label: "Fetch Query Plan"
    #   url: "https://example.com/ping/{{ value }}"
    #   form_url: "https://example.com/ping/{{ value }}/form.json"
    # }
    link: {
      label: "Analyze This Query"
      url: "https://dream11poc.cloud.looker.com/dashboards-next/7?Text={{ value | url_encode }}"
      icon_url: "http://google.com/favicon.ico"}
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
    drill_fields: [interval_end_time,text,avg_bytes,avg_cpu_seconds,avg_latency_seconds,avg_rows,avg_rows_scanned,count]
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
