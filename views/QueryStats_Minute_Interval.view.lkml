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

  dimension: average_latency_seconds {
    type: number
    label: "Average Latency Seconds"
    sql: ${TABLE}.avg_latency_seconds ;;
    value_format: "0.00"
  }

  measure: avg_cpu_seconds {
    type: number
    label: "Average CPU Seconds"
    sql: SUM(${TABLE}.avg_cpu_seconds)/SUM(${TABLE}.execution_count) ;;
    value_format: "0.00"
  }

  measure: avg_latency_seconds {
    type: number
    label: "Average Latency Seconds"
    sql: SUM(${TABLE}.avg_latency_seconds)/SUM(${TABLE}.execution_count) ;;
    value_format: "0.00"
    drill_fields: [interval_end_time,text,avg_bytes,avg_cpu_seconds,avg_latency_seconds,avg_rows,avg_rows_scanned]
  }

  measure: avg_rows {
    type: number
    label: "Average Rows"
    sql: SUM(${TABLE}.avg_rows)/SUM(${TABLE}.execution_count) ;;
    value_format: "0.00"
  }

  measure: avg_rows_scanned {
    type: number
    label: "Average Rows Scanned"
    sql: SUM(${TABLE}.avg_rows_scanned)/SUM(${TABLE}.execution_count) ;;
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
    value_format: "0.00"
  }

  measure: total_records {
    type: count
    label: "Total Records"
  }


}
