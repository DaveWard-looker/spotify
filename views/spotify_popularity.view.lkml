# The name of this view in Looker is "Spotify Popularity"
view: spotify_popularity {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `daveward-ps-dev.spotify_data.spotify_popularity`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Artist" in Explore.

  dimension: artist {
    type: string
    sql: ${TABLE}.artist ;;
    link: {
      label: "Find  {{ artist._value }} on wikipedia"
      url: "https://en.wikipedia.org/wiki/{{ artist_name_url._value | url_encode }}"
      icon_url: "http://www.google.com/s2/favicons?domain=wikipedia.org"
    }
  }

  dimension: artist_name_url {
    hidden: yes
    type: string
    sql: replace(${artist},' ','_') ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: chart {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: int64_field_0 {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.int64_field_0 ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  dimension: position {
    hidden: yes
    type: number
    sql: ${TABLE}.position ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
    link: {
      icon_url: "http://www.google.com/s2/favicons?domain=spotify.com"
      url: "{{ uri._value }}"
      label: "Listen to on spotify"
    }
    link: {
      label: "Find {{ artist._value }} on wikipedia"
      url: "https://en.wikipedia.org/wiki/{{ artist_name_url._value | url_encode }}"
      icon_url: "http://www.google.com/s2/favicons?domain=wikipedia.org"
    }
  }

  dimension: track {
    type: string
    sql: ${TABLE}.track ;;
    link: {
      icon_url: "http://www.google.com/s2/favicons?domain=spotify.com"
      url: "{{ uri._value }}"
      label: "Listen to {{ value }} on spotify"
    }
    link: {
      label: "Find {{ artist._value }}  on wikipedia"
      url: "https://en.wikipedia.org/wiki/{{ artist_name_url._value | url_encode }}"
      icon_url: "http://www.google.com/s2/favicons?domain=wikipedia.org"
    }
  }

  dimension: uri {
    hidden: yes
    type: string
    sql: ${TABLE}.uri ;;
  }

  measure: total_position {
    type: sum
    sql: ${position} ;;
    value_format_name: decimal_1
  }

  measure: average_position {
    type: average
    sql: ${position} ;;
    value_format_name: decimal_2
  }

  measure: best_position {
    type: min
    sql: ${position} ;;
    value_format_name: decimal_0
  }


}
