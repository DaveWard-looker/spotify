view: best_country_position {
  derived_table: {
    sql: SELECT date,
      country,
      artist,
      rank() OVER ( PARTITION BY date,country, artist ORDER BY position desc) as best_position FROM `daveward-ps-dev.spotify_data.spotify_popularity` LIMIT 1000
       ;;
  }


  dimension: date {
    hidden: yes
    type: date
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: country {
    hidden: yes
    type: string
    sql: ${TABLE}.country ;;
  }

  dimension: artist {
    hidden: yes
    type: string
    sql: ${TABLE}.artist ;;
  }

  dimension: best_position {
    hidden: yes
    type: number
    sql: ${TABLE}.best_position ;;
  }

  set: detail {
    fields: [date, country, artist, best_position]
  }
}
