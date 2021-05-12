# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: spanner_metric_export {
}

view: spanner_metric_export {
  sql_table_name: `dr-poc-305406.spanner_sys.spanner_metric_export`
    ;;

  dimension: metric_name {
    type: string
    sql: ${TABLE}.metricName ;;
  }

  dimension_group: point_data_time_interval__start {
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
    sql: ${TABLE}.pointData.timeInterval.start_time ;;
  }

  dimension: point_data_values_double_value {
    type: number
    sql: ${TABLE}.pointData.values.double_value ;;
    group_label: "Point Data Values"
    group_item_label: "Double Value"
  }

  dimension: point_data_values_int64_value {
    type: number
    sql: ${TABLE}.pointData.values.int64_value ;;
    group_label: "Point Data Values"
    group_item_label: "Int64 Value"
  }

  measure: count {
    type: count
    drill_fields: [metric_name]
  }
}
