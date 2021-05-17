view: oldest_active_queries {
  sql_table_name: `dr-poc-305406.spanner_sys.OLDEST_ACTIVE_QUERIES`
    ;;

  dimension: session_id {
    type: string
    sql: ${TABLE}.SESSION_ID ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.START_TIME ;;
  }

  dimension: text {
    type: string
    sql: ${TABLE}.TEXT ;;
  }

  dimension: text_fingerprint {
    type: number
    sql: ${TABLE}.TEXT_FINGERPRINT ;;
  }

  dimension: text_truncated {
    type: yesno
    sql: ${TABLE}.TEXT_TRUNCATED ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
