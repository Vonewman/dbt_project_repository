-- models/tracks3_4_Minutes.sql

{{ config(materialized="table") }}  -- Specify the materialization method as "table"

-- CTE to fetch data from the source "staging.tracks" and select desired columns
WITH data_source AS (
  SELECT
    TrackId,
    Name,
    AlbumId,
    MediaTypeId,
    GenreId,
    Milliseconds,
    Bytes
  FROM {{ source('staging', 'tracks') }}
),

-- CTE to filter the data based on the specified criteria (time and size in bytes)
final AS (
  SELECT *
  FROM data_source
  WHERE Milliseconds >= 180000 AND Milliseconds <= 240000 AND Bytes > 6600000
)

-- Insert the selected data into the "tracks3_4_Minutes" table
INSERT INTO {{ target('staging', 'tracks3_4_Minutes') }}
SELECT * FROM final;
