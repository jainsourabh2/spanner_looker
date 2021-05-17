view: active_queries_summary {
  sql_table_name: `dr-poc-305406.spanner_sys.ACTIVE_QUERIES_SUMMARY`
    ;;

  measure: active_count {
    type: sum
    sql: ${TABLE}.ACTIVE_COUNT ;;
  }

  measure: qlt_100_s {
    type: sum
    sql: ${TABLE}.COUNT_OLDER_THAN_100S ;;
  }

  measure: qlt_10_s {
    type: sum
    sql: ${TABLE}.COUNT_OLDER_THAN_10S ;;
  }

  measure: qlt_1_s {
    type: sum
    sql: ${TABLE}.COUNT_OLDER_THAN_1S ;;
  }

  dimension_group: oldest_start {
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
    sql: ${TABLE}.OLDEST_START_TIME ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
