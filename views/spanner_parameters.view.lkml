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
    drill_fields: [end_time,keyvalue]
  }

  measure: spanner_node {
    type: number
    sql: ${TABLE}.keyvalue ;;
  }

  measure: instance_cpu_utilization {
    type: average
    sql: ${TABLE}.keyvalue ;;
  }

  measure: instance_cpu_utilization_priority {
    type: average
    sql: ${TABLE}.keyvalue ;;
  }

  measure: avg_bytes_used {
    type: average
    sql: ${TABLE}.keyvalue/1024/1024 ;;
  }

  measure: total_api_read_errors {
    type: sum
    sql: ${TABLE}.keyvalue ;;
  }

  measure: total_api_write_errors {
    type: sum
    sql: ${TABLE}.keyvalue ;;
    }

  measure: total_attribute {
    type: sum
    sql: ${TABLE}.keyvalue ;;
  }
  measure: count {
    type: count
    drill_fields: [metric_name]
  }
}
