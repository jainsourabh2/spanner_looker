

view: lock_stats_top_10_minute {
  sql_table_name: `dr-poc-305406.spanner_sys.LOCK_STATS_TOP_10MINUTE`
    ;;

  dimension_group: interval_end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.INTERVAL_END ;;
  }

  measure: lock_wait_seconds {
    type: sum
    sql: ${TABLE}.LOCK_WAIT_SECONDS ;;
    drill_fields: [lock_stats_top_10_minute__sample_lock_requests.offset,lock_stats_top_10_minute__sample_lock_requests.lock_mode,lock_stats_top_10_minute__sample_lock_requests.column]
  }

  dimension: row_range_start_key {
    type: string
    sql: CAST(${TABLE}.ROW_RANGE_START_KEY AS STRING) ;;
  }

  dimension: sample_lock_requests {
    hidden: yes
    sql: ${TABLE}.SAMPLE_LOCK_REQUESTS ;;
  }

  measure: count {
    type: count
    drill_fields: [lock_stats_top_10_minute__sample_lock_requests.column,lock_stats_top_10_minute__sample_lock_requests.lock_mode]
  }
}

view: lock_stats_top_10_minute__sample_lock_requests {
  dimension: column {
    type: string
    sql: ${TABLE}.column ;;
  }

  dimension: lock_mode {
    type: string
    sql: ${TABLE}.lock_mode ;;
  }

  dimension: offset {
    type: number
    sql: lock_stats_top_10_minute_sample_lock_requests_with_offset;;
  }
}
