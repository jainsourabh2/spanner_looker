# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view

view: txn_stats_top_10minute {
  # sql_table_name: `dr-poc-305406.spanner_sys.txn_stats_top_10minute`
  #   ;;

  derived_table: {
    sql:
      SELECT
        GENERATE_UUID() as uuid, *
      FROM `dr-poc-305406.spanner_sys.txn_stats_top_10minute`

      ;;
    }

  dimension: uuid {primary_key:yes}

  dimension: end_time {
    type: date_time
    sql: ${TABLE}.interval_end ;;
  }

  measure: avg_bytes {
    type: average
    sql: ${TABLE}.avg_bytes ;;
    value_format: "0.00"
  }

  measure: avg_commit_latency_seconds {
    type: average
    sql: ${TABLE}.avg_commit_latency_seconds ;;
    value_format: "0.00"
    drill_fields: [fprint,txn_stats_top_10minute__write_constructive_columns.write_constructive_columns,txn_stats_top_10minute__read_columns.read_columns]
    link: {
      label: "Analyze This Transaction"
      url: "https://dream11poc.cloud.looker.com/dashboards-next/10?Fprint={{ txn_stats_top_10minute.fprint._value | url_encode }}&&Interval+End+Time={{ txn_stats_top_10minute.interval_end_time._value | url_encode}}"
      icon_url: "http://google.com/favicon.ico"}
  }

  measure: avg_participants {
    type: average
    sql: ${TABLE}.avg_participants ;;
    value_format: "0.00"
  }

  measure: avg_total_latency_seconds {
    type: average
    sql: ${TABLE}.avg_total_latency_seconds ;;
    value_format: "0.00"
  }

  measure: avg_read_latency_seconds {
    type: average
    sql: ${TABLE}.avg_total_latency_seconds - ${TABLE}.avg_commit_latency_seconds;;
    value_format: "0.00"
  }

  measure: commit_abort_count {
    type: sum
    sql: ${TABLE}.commit_abort_count ;;
    value_format: "0.00,,\" M\""
  }

  measure: commit_attempt_count {
    type: sum
    sql: ${TABLE}.commit_attempt_count ;;
    value_format: "0.00,,\" M\""
  }

  measure: commit_failed_precondition_count {
    type: sum
    sql: ${TABLE}.commit_failed_precondition_count ;;
  }

  # measure: total_operations {
  #   type: count
  #   sql: ${TABLE}.fprint ;;
  # }

  dimension: fprint {
    type: string
    sql: CAST(${TABLE}.fprint as STRING) ;;
  }

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

  dimension: write_constructive_columns {
    hidden: yes
    sql: ${TABLE}.write_constructive_columns ;;
  }

  dimension: write_delete_tables {
    hidden: yes
    sql: ${TABLE}.write_delete_tables ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  dimension: read_columns {
    sql: ${TABLE}.read_columns ;;
  }
}

view: txn_stats_top_10minute__read_columns {
  dimension: read_columns {
    type: string
    sql: ${TABLE} ;;
  }

  dimension: offset {
    type: number
    sql: txn_stats_top_10minute__read_columns_with_offset;;
  }
}

view: txn_stats_top_10minute__write_delete_tables {
  dimension: write_delete_tables {
    type: string
    sql: ${TABLE} ;;
  }

  dimension: offset {
    type: number
    sql: txn_stats_top_10minute__write_delete_tables_with_offset;;
  }
}

view: txn_stats_top_10minute__write_constructive_columns {
  dimension: write_constructive_columns {
    type: string
    sql: ${TABLE} ;;
  }

  dimension: offset {
    type: number
    sql: txn_stats_top_10minute__write_constructive_columns_with_offset;;
  }
}
