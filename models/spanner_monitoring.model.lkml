connection: "dream11_spanner_database"

# include all the views
include: "/views/**/*.view"
include: "/**/*.dashboard"

datagroup: spanner_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: spanner_default_datagroup

# explore: ga_sessions_hits {
#   join: evergent_subscription_data {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${evergent_subscription_data.cp_customer_id}=${ga_sessions_hits.cp_customer_id} ;;
#   }
#   join: activations {
#     view_label: "Evergent Subscription Data"
#     type: left_outer
#     relationship: one_to_one
#     sql_on: ${activations.key} = ${evergent_subscription_data.key} ;;
#   }
#   join: avs_data_all {
#     type: inner
#     relationship: one_to_one
#     sql_on: ${avs_data_all.content_id}=${ga_sessions_hits.content_id} ;;
#   }
# }
explore: spanner_parameters {}

explore: QueryStats_Minute_Interval {}

# Un-hide and use this explore, or copy the joins into another explore, to get all the fully nested relationships from this view
explore: lock_stats_top_10_minute {

  join: txn_stats_top_10minute {
    view_label: "Txn Stats Top 10 Minutes "
    type: left_outer
    relationship: one_to_many
    sql_on: ${txn_stats_top_10minute.interval_end_time} = ${lock_stats_top_10_minute.end_time} ;;
  }
  join: lock_stats_top_10_minute__sample_lock_requests {
    view_label: "Lock Stats Top 10 Minute: Sample Lock Requests"
    sql: LEFT JOIN UNNEST(${lock_stats_top_10_minute.sample_lock_requests}) AS  lock_stats_top_10_minute__sample_lock_requests WITH OFFSET AS lock_stats_top_10_minute_sample_lock_requests_with_offset;;
    relationship: one_to_many
  }
}

explore: txn_stats_top_10minute {

  join: txn_stats_top_10minute__read_columns {
    view_label: "Txn Stats Top 10minute: Read Columns"
    sql: LEFT JOIN UNNEST(${txn_stats_top_10minute.read_columns}) as txn_stats_top_10minute__read_columns WITH OFFSET AS txn_stats_top_10minute__read_columns_with_offset;;
    relationship: one_to_many
  }

  join: txn_stats_top_10minute__write_delete_tables {
    view_label: "Txn Stats Top 10minute: Write Delete Tables"
    sql: LEFT JOIN UNNEST(${txn_stats_top_10minute.write_delete_tables}) as txn_stats_top_10minute__write_delete_tables WITH OFFSET AS txn_stats_top_10minute__write_delete_tables_with_offset ;;
    relationship: one_to_many
  }

  join: txn_stats_top_10minute__write_constructive_columns {
    view_label: "Txn Stats Top 10minute: Write Constructive Columns"
    sql: LEFT JOIN UNNEST(${txn_stats_top_10minute.write_constructive_columns}) as txn_stats_top_10minute__write_constructive_columns WITH OFFSET AS txn_stats_top_10minute__write_constructive_columns_with_offset ;;
    relationship: one_to_many
  }
}
